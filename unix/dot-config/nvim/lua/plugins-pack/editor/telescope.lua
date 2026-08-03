vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "telescope-fzf-native.nvim" and (kind == "update" or kind == "install") then
      if not ev.data.active then
        vim.cmd.packadd("telescope-fzf-native.nvim")
      end
      local path = ev.data.path
      vim.system({ "make", "-C", path })
    end
  end,
})

local telescope = require("telescope")
telescope.setup({
})
telescope.load_extension("fzf")

local telescope_api = require("telescope.builtin")
-- stylua: ignore
vim.keymap.set({ "n" }, "<leader><Space>", function() telescope_api.find_files() end, { desc = "Find files" })
-- stylua: ignore
vim.keymap.set({ "n" }, "<leader>/", function() telescope_api.live_grep() end, { desc = "Live Grep" })
vim.keymap.set({ "n" }, "gs", function()
  telescope_api.lsp_document_symbols({
    symbols = YukiVim.config.get_kind_filter(vim.api.nvim_get_current_buf()),
  })
end, { desc = "LSP Symbols" })
vim.keymap.set({ "n" }, "gS", function()
  telescope_api.lsp_workspace_symbols({
    symbols = YukiVim.config.kind_filter.default,
  })
end)
