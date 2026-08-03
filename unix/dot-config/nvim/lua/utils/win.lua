---@class yukivim.utils.win
---@field id number
---@field buf? number
---@field meta table<string, any>
local M = setmetatable({}, {
  __call = function(t, ...)
    return t.new(...)
  end,
})
M.__index = M

---@class yukivim.utils.win.Config
---@field position? "float"|"bottom"|"top"|"left"|"right"
---@field keys? table<string, false|string|fun(self: yukivim.utils.win)>
---@field on_buf? fun(self: yukivim.utils.win)
---@field on_win? fun(self: yukivim.utils.win)
---@field on_close? fun(self: yukivim.utils.win)
local defaults = {
  position = "float",
  keys = {
    q = "close",
  },
}

local id = 0

---@param opts? yukivim.utils.win.Config|{}
---@return yukivim.utils.win
function M.new(opts)
  local self = setmetatable({}, M)
  id = id + 1
  self.id = id
  self.meta = {}
  opts = M.resolve(defaults, opts)
end

---@param ...? yukivim.utils.win.Config
---@return yukivim.utils.win.Config
function M.resolve(...)
  local done = {} ---@type table<string, boolean>
  local merge = {} ---@type yukivim.utils.win.Config[]
  local stack = {}
  for i = 1, select("#", ...) do
    local next = select(i, ...) ---@type yukivim.utils.win.Config|string?
    if next then
      table.insert(stack, next)
    end
  end
  while #stack > 0 do
    local next = table.remove(stack)
    next = type(next) == "string" and { position = next } or next
  end
  local ret = #merge == 0 and {} or #merge == 1 and merge[1] or vim.tbl_deep_extend("force", {}, unpack(merge))
  ret.style = nil
  return ret
end
function M:buf_valid()
  return self.buf and vim.api.nvim_buf_is_valid(self.buf)
end

function M.create_float(opts)
  local width = 0.8
  local height = 0.8

  local editor_width = vim.o.columns
  local editor_height = vim.o.lines
  local win_width = math.floor(editor_width * width)
  local win_height = math.floor(editor_height * height)
  local row = math.floor((editor_height - win_height) / 2)
  local col = math.floor((editor_width - win_width) / 2)

  local config = {
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    style = "minimal",
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
  vim.api.nvim_set_option_value(
    "winhighlight",
    "NormalFloat:TinyTermNormal,FloatBorder:TinyTermBorder",
    { win = win_id }
  )
  --
  -- Store terminal ID on window for keymap access
  if opts.term then
    pcall(vim.api.nvim_win_set_var, win_id, "yuki_term_id", opts.term.id)
  end

  return win_id
end

return M
