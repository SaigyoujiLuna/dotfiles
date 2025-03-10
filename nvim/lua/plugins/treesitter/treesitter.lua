return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
        ensure_installed = {
            "c",
            "lua",
            "vim",
            "vimdoc",
            "java",
            "rust",
            "python",
        },
        sync_install = false,
        auto_install = true,
    }
}
