local function augroup(name)
    return vim.api.nvim_create_augroup("yukinvim_" .. name, { clear = true})
end
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        vim.hl.on_yank()
    end
})
