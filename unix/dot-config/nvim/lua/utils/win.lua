---@class yukivim.utils.win
---@field win integer
---@field buf integer
local M = {}
M.__index = M

local default_keys = {
  { "<C-h>", "<C-w>h", mode = "t", desc = "Move to window left" },
  { "<C-j>", "<C-w>j", mode = "t", desc = "Move to window below" },
  { "<C-k>", "<C-w>k", mode = "t", desc = "Move to window above" },
  { "<C-l>", "<C-w>l", mode = "t", desc = "Move to window right" },
  -- {
  --   "q",
  --   function()
  --     local current_win = vim.api.nvim_get_current_win()
  --     local ok, term_id = pcall(vim.api.nvim_win_get_var, current_win, "tiny_term_id")
  --     if not (ok and term_id) then
  --       return
  --     end
  --     local terminal = require("tiny-term.terminal")
  --     local term = terminal.get(term_id)
  --     if term then
  --       term:hide()
  --     end
  --   end,
  --   mode = "n",
  --   desc = "Hide terminal",
  -- },
  -- {
  --   "gf",
  --   function()
  --     local file = vim.fn.expand("<cfile>")
  --     if file == "" then
  --       return
  --     end
  --     local current_win = vim.api.nvim_get_current_win()
  --     local ok, term_id = pcall(vim.api.nvim_win_get_var, current_win, "yuki_win_id")
  --     if ok and term_id then
  --       local terminal = require("tiny-term.terminal")
  --       local term = terminal.get(term_id)
  --       if term then
  --         term:hide()
  --       end
  --     end
  --     vim.cmd("e " .. file)
  --   end,
  --   mode = "n",
  --   desc = "Open file under cursor",
  -- },
}

---@class yukivim.utils.win.Config
---@field position? "float"|"bottom"|"top"|"left"|"right"
---@field width? number
---@field height? number
---@field border? string
---@field keys? table<string, false|string|fun(self: yukivim.utils.win)>
---@field buf? integer
---@field on_win_open? fun(self: yukivim.utils.win)
local defaults = {
  position = "float",
  keys = {
    q = "close",
  },
}

function M.get_default_keys()
  return default_keys
end
function M:buf_valid()
  return self.buf and vim.api.nvim_buf_is_valid(self.buf)
end

---@param opts yukivim.utils.win.Config
---@return integer
function M.create_float(opts)
  local width = 0.8
  local height = 0.8

  local editor_width = vim.o.columns
  local editor_height = vim.o.lines
  local win_width = math.floor(editor_width * width)
  local win_height = math.floor(editor_height * height)
  local row = math.floor((editor_height - win_height) / 2)
  local col = math.floor((editor_width - win_width) / 2)

  ---@type vim.api.keyset.win_config
  local config = {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = "minimal",
    border = opts.border,
    mouse = true,
  }

  local buf = opts.buf or vim.api.nvim_create_buf(false, true)
  if not buf or buf == 0 then
    error("Failed to create terminal buffer")
  end

  local win_id = vim.api.nvim_open_win(buf, true, config)
  if not win_id or win_id == 0 then
    error("Failed to create floating window")
  end
  if not vim.api.nvim_win_is_valid(win_id) then
    error("Window became invalid immediately after creation")
  end
  vim.api.nvim_set_option_value("wrap", false, { win = win_id })
  vim.api.nvim_set_option_value("signcolumn", "no", { win = win_id })
  -- vim.api.nvim_set_option_value(
  --   "winhighlight",
  --   "NormalFloat:TinyTermNormal,FloatBorder:TinyTermBorder",
  --   { win = win_id }
  -- )
  local self = setmetatable({
    buf = buf,
    win = win_id,
  }, M)
  if opts.on_win_open then
    opts.on_win_open(self)
  end

  return win_id
end

return M
