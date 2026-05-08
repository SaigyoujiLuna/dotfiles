vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true -- smart auto indent
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.signcolumn = "yes"
-- opt.colorcolumn = "100" -- show column at 100 position chars
opt.showmatch = true
opt.showmode = false

opt.confirm = true

opt.mouse:append("a")
opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true


opt.termguicolors = true

opt.smoothscroll = true
