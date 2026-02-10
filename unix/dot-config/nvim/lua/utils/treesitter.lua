local Range = require("utils.lib.range")

---@class yukivim.utils.treesitter
local M = {}

M.cache = require("utils.lib.cache").new()
M.selection_nodes = require("utils.lib.nodes").new()

---@param buf integer
---@param language string
function M.select_larger_node(buf, language)
  M.incremental(buf, language, function(_, node)
    return node:parent()
  end)
end

---@param buf integer
function M.select_smaller_node(buf, _)
  local node = M.selection_nodes:pop(buf)
  if node then
    M.select(buf, node)
  end
end

---@private
---@param buf integer
---@param language string
---@param parent fun(parser: vim.treesitter.LanguageTree, node: TSNode): TSNode?
function M.incremental(buf, language, parent)
  local parser = M.parse(buf, language)
  if not parser then
    return
  end

  local range = Range.visual()
  local last = M.selection_nodes:last(buf)
  local node = nil ---@type TSNode?

  if not last or not range:same(Range.node(buf, last)) then
    node = parser:named_node_for_range(range:ts(), {
      ignore_injections = false,
    })
    M.selection_nodes:clear(buf)
  else
    parser = parser:language_for_range(range:ts())
    while parser and not node do
      node = parser:named_node_for_range(range:ts())
      while node and range:same(Range.node(buf, node)) do
        node = parent(parser, node)
      end
      parser = parser:parent()
    end
  end
  if node then
    M.selection_nodes:push(buf, node)
    M.select(buf, node)
  end
end

---@private
---@param buf integer
---@param language string
---@return vim.treesitter.LanguageTree?
function M.parse(buf, language)
  local parser = vim.treesitter.get_parser(buf, language)
  if not parser then
    return nil
  end
  local first, last = vim.fn.line("w0"), vim.fn.line("w$")
  parser:parse({ first - 1, last })
  return parser
end
---@private
---@param buf integer
---@param node TSNode
function M.select(buf, node)
  local range = Range.node(buf, node)
  if vim.api.nvim_get_mode().mode ~= "v" then
    vim.cmd.normal({ "v", bang = true })
  end
  vim.api.nvim_win_set_cursor(0, range:cursor_start())
  vim.cmd.normal({ "o", bang = true })
  vim.api.nvim_win_set_cursor(0, range:cursor_end())
end

function M.setup(opts)
  vim.api.nvim_create_autocmd("FileType", {
    group = YukiVim.augroup("treesitter"),
    callback = function(args)
      local buf, filetype = args.buf, args.match
      local language = vim.treesitter.language.get_lang(filetype)
      if not language then
        return
      end
      opts = opts or {}
      if opts.incremental_selection and opts.incremental_selection.enable then
        M.attach_incremental(buf, language, opts.incremental_selection)
      end
    end,
  })
end

---@private
---@param buf integer
---@param language string
---@param opts {keymaps?: {node_incremental?: string, node_decremental?: string}}
---@return boolean
function M.attach_incremental(buf, language, opts)
  if not vim.treesitter.language.add(language) then
    return false
  end

  if not opts.keymaps then
    return true
  end

  local set = M.cache:get(buf)
  if set:has("incremental") then
    return true
  end

  ---@param func fun(integer,  string)
  ---@param rhs string
  local map = function(func, rhs)
    vim.keymap.set({ "n", "v" }, rhs, function()
      func(buf, language)
    end, {
      buffer = buf,
      silent = true,
      desc = "Select larger node",
    })
  end
  if opts.keymaps.node_incremental then
    map(M.select_larger_node, opts.keymaps.node_incremental)
  end
  if opts.keymaps.node_decremental then
    map(M.select_smaller_node, opts.keymaps.node_decremental)
  end
  return true
end

return M
