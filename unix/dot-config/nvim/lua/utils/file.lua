---@class yukivim.utils.file
local M = {}

---@param _from? string
---@param _to? string
function M.rename_file(_from, _to)
  local from = vim.fn.fnamemodify(_from or vim.api.nvim_buf_get_name(0), ":p")
  local to = _to and vim.fn.fnamemodify(_to, ":p") or nil
  from, to = vim.fs.normalize(from), to and vim.fs.normalize(to) or nil
  local function rename()
    assert(to ~= nil)
    M.on_rename_file(from, to, function()
      from = vim.fn.fnamemodify(from, ":p")
      to = to and vim.fn.fnamemodify(to, ":p")
      vim.fn.mkdir(vim.fs.dirname(to), "p")
      local ret = vim.fn.rename(from, to)
      if ret ~= 0 then
        vim.notify("Failed to rename file: " .. from .. " to " .. to)
      end
      local from_buf = vim.fn.bufnr(from)
      if from_buf >= 0 then
        local to_buf = vim.fn.bufadd(to)
        vim.bo[to_buf].buflisted = true
        for _, win in ipairs(vim.fn.win_findbuf(from_buf)) do
          vim.api.nvim_win_call(win, function()
            vim.cmd("buffer " .. to_buf)
          end)
        end
        vim.api.nvim_buf_delete(from_buf, { force = true })
      end
    end)
  end
  if to then
    return rename()
  end

  local root = vim.fs.normalize(vim.fn.getcwd(0))
  if from:find(root, 1, true) ~= 1 then
    root = vim.fs.dirname(from)
  end

  local extra = from:sub(#root + 2)

  vim.ui.input({
    prompt = "Rename File: ",
    default = extra,
    completion = "file",
  }, function(value)
    if not value or value == "" or value == extra then
      return
    end
    to = vim.fs.normalize(root .. "/" .. value)
    rename()
  end)
end

---@param from string
---@param to string
---@param fn? fun()
function M.on_rename_file(from, to, fn)
  local changed = { files = {
    oldUri = vim.uri_from_fname(from),
    newUri = vim.uri_from_fname(to),
  } }
  local clients = vim.lsp.get_clients()
  for _, client in ipairs(clients) do
    if client:supports_method("workspace/willRenameFiles") then
      local resp = client:request_sync("workspace/willRenameFiles", changed, 1000, 0)
      if resp and resp.result ~= nil then
        vim.lsp.util.apply_workspace_edit(resp.result, client.offset_encoding)
      end
    end
  end
  if fn then
    fn()
  end
  for _, client in ipairs(clients) do
    if client:supports_method("workspace/didRenameFiles") then
      client:notify("workspace/didRenameFiles", changed)
    end
  end
end

return M
