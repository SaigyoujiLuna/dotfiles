---@class yukivim.utils.terminal
local M = {}

---@type table<string, yukivim.utils.terminal.Terminal>
M.terminals = {}

vim.api.nvim_set_hl(0, "TinyTermNormal", { link = "NormalFloat", default = true })
vim.api.nvim_set_hl(0, "TinyTermBorder", { link = "FloatBorder", default = true })
vim.api.nvim_set_hl(0, "TinyTermWinbar", { link = "WinBar", default = true })

---@class yukivim.utils.terminal.Terminal
---@field id string
---@field cmd string
---@field opts yukivim.utils.terminal.Opts
---@field buf integer|nil
---@field win integer|nil
---@field cwd string
---@field env table<string, string>
---@field job_id integer|nil
---@field exited boolean
---@field autocmd_id integer|nil
---@field esc_count number
---@field esc_timer? uv.uv_timer_t
---@field process_started boolean
local Terminal = {}
Terminal.__index = Terminal

---@class yukivim.utils.terminal.Opts
---@field cwd? string
---@field count? integer
---@field env? table<string, string>
---@field interactive? boolean
---@field start_insert boolean
---@field auto_insert boolean
---@field auto_close boolean
---@field win? table<string, any>

---@param cmd string|nil
---@param opts yukivim.utils.terminal.Opts
---@param tid string
---@return yukivim.utils.terminal.Terminal
function Terminal.new(cmd, opts, tid)
  opts = opts or {}
  local interactive = opts.interactive == nil
  if interactive then
    opts.start_insert = opts.start_insert ~= false
    opts.auto_insert = opts.auto_insert ~= false
    opts.auto_close = opts.auto_close ~= false
  end
  local self = setmetatable({
    id = tid,
    cmd = cmd,
    opts = opts,
    buf = nil,
    win = nil,
    cwd = opts.cwd or vim.fn.getcwd(),
    env = opts.env,
    job_id = nil,
    exited = false,
    autocmd_id = nil,
    esc_count = 0,
    esc_timer = nil,
    process_started = false,
  }, Terminal)
  return self
end

local function _refresh_splits_if_needed(term)
  -- if not term.win then
  --     return
  -- end
  -- local win_id = term.win
end

function Terminal:create_buf()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("filetype", "yuki_term", { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buf })
  self.buf = buf
  local autocmd_id = vim.api.nvim_create_autocmd("TermClose", {
    buffer = buf,
    callback = function()
      self:handle_exit()
    end,
  })
  self.autocmd_id = autocmd_id
end

function Terminal:create_win()
  local opts = vim.tbl_deep_extend("force", self.opts or {}, {

    buf = self.buf,
    cmd = self.cmd,
    term = self,
  })
  self.win = YukiVim.win.create_float(opts)
  self:setup_keymaps()
  return self.win
end
function Terminal:setup_keymaps()
  if not self.win or not vim.api.nvim_win_is_valid(self.win) then
    return
  end

  local opts = self.opts or {}
  -- local keys = (opts.win or {}).keys or config.config.win.keys or window.get_default_keys()
  local nav_keys = { ["<C-h>"] = true, ["<C-j>"] = true, ["<C-k>"] = true, ["<C-l>"] = true }

    vim.api.nvim_buf_set_keymap(self.buf, "t", "<Esc>", "", {
    callback = function()
      if self:handle_double_esc() then
        vim.cmd("stopinsert")
      else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
      end
    end,
    desc = "Double-esc to normal mode",
    noremap = true,
    silent = true,
  })
end
function Terminal:handle_double_esc()
  self.esc_count = self.esc_count + 1

  if self.esc_count == 2 then
    if self.esc_timer then
      self.esc_timer:close()
      self.esc_timer = nil
    end
    self.esc_count = 0
    return true
  end

  if not self.esc_timer then
    self.esc_timer = vim.uv.new_timer()
  end
  self.esc_timer:stop()
  self.esc_timer:start(200, 0, function()
    vim.schedule(function()
      if self.job_id and self:buf_valid() then
        vim.api.nvim_chan_send(self.job_id, "\27")
      end
      self.esc_count = 0
    end)
  end)

  return false
end

function Terminal:buf_valid()
  return self.buf ~= nil and vim.api.nvim_buf_is_valid(self.buf)
end

function Terminal:is_visible()
  if not self.win or not vim.api.nvim_win_is_valid(self.win) then
    return false
  end
  return vim.api.nvim_win_get_tabpage(self.win) == vim.api.nvim_get_current_tabpage()
end

function Terminal:show()
  if not self:buf_valid() then
    self:create_buf()
  end
  if not self:is_visible() then
    self:create_win()
  end

  if not self.process_started then
    vim.api.nvim_win_call(self.win, function()
      self:start_process()
    end)
  end
  local opts = self.opts or {}
  local start_insert = opts.start_insert
  if start_insert == nil then
    start_insert = true
  end
  if start_insert then
    vim.api.nvim_set_current_win(self.win)
    vim.cmd("startinsert")
  end
  return self.win
end

function Terminal:hide()
  if not self:is_visible() then
    return
  end

  _refresh_splits_if_needed(self)

  if vim.api.nvim_get_current_win() == self.win then
    vim.cmd("wincmd p")
  end
  pcall(vim.api.nvim_win_close, self.win, true)
  self.win = nil
end

function Terminal:start_process()
  local cmd = self.cmd or vim.o.shell
  local cwd = self.cwd or vim.fn.getcwd()
  local shell = vim.o.shell
  local shellcmdflag = vim.o.shellcmdflag or "-c"
  local cmd_list = { shell, shellcmdflag, cmd }
  local job_id = vim.fn.jobstart(cmd_list, {
    cwd = cwd,
    env = self.env,
    term = true,
    on_exit = function()
      self.exited = true
      self.job_id = nil
    end,
  })
  if job_id == 0 then
    error("Failed to start terminal (invalid arguments): " .. tostring(cmd))
  elseif job_id == -1 then
    error("Failed to start terminal (not executable): " .. tostring(cmd))
  end
  self.job_id = job_id
  self.exited = false
  self.process_started = true
end

function Terminal:handle_exit()
  if self.exited then
    return
  end
  self.exited = true
  if self.esc_timer then
    self.esc_timer:close()
    self.esc_timer = nil
  end
  if self.autocmd_id then
    vim.api.nvim_del_autocmd(self.autocmd_id)
    self.autocmd_id = nil
  end
  self.job_id = nil
  local opts = self.opts
  vim.schedule(function()
    self:hide()
    if self:buf_valid() then
      vim.api.nvim_buf_delete(self.buf, { force = true })
      self.buf = nil
    end
    M.terminals[self.id] = nil
  end)
end

---@class yukivim.utils.terminal.Config
---@field win? yukivim.utils.win.Config
---@field shell? string|string[] The shell to use. Defaults to `vim.o.shell`

---@param cmd? string
---@param opts? yukivim.utils.terminal.Opts
function M.tid(cmd, opts)
  opts = opts or {}
  return vim.inspect({
    cmd = cmd or vim.o.shell,
    cwd = opts.cwd or vim.fn.getcwd(),
    env = opts.env,
    count = opts.count or vim.v.count1,
  })
end

---@param cmd? string
---@param opts? yukivim.utils.terminal.Opts
---@return yukivim.utils.terminal.Terminal
function M.get_or_create(cmd, opts)
  opts = opts or {}
  local id = M.tid(cmd, opts)
  local existing = M.terminals[id]
  if existing and not existing.exited then
    return existing
  end
  local ret = Terminal.new(cmd, opts, id)
  M.terminals[id] = ret
  return ret
end

---@param cmd? string
---@param opts? yukivim.utils.terminal.Opts
---@return yukivim.utils.terminal.Terminal
function M.toggle(cmd, opts)
  opts = opts or {}
  local term = M.get_or_create(cmd, opts)
  if term:is_visible() then
    term:hide()
  else
    term:show()
    local auto_insert = opts.auto_insert
    if auto_insert == nil then
      auto_insert = true
    end
    if auto_insert then
      vim.api.nvim_set_current_win(term.win)
      vim.cmd("startinsert")
    end
  end
  return term
end

return M
