vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == "fff.nvim" and (kind == "update" or kind == "install") then
      if not ev.data.active then
        vim.cmd.packadd("fff.nvim")
      end
      require("fff.download").download_or_build_binary()
    end
  end,
})
vim.pack.add({
  "https://github.com/dmtrKovalenko/fff.nvim",
})
vim.g.fff = {
  lazy_sync = true,
  -- debug = { enabled = true, show_scores = true },
}

vim.keymap.set({ "n" }, "<leader><Space>", function()
  require("fff").find_files()
end, { desc = "Find files" })
vim.keymap.set({ "n" }, "<leader>/", function()
  require("fff").live_grep()
end, { desc = "Live Grep" })
