vim.opt.exrc = true
-- vim.opt.guicursor = ""
vim.opt.mouse = "a"
-- Hide unsaved buffer
vim.opt.hidden = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.errorbells = false

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.showmode = true

vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes:1"
vim.opt.background = "dark"

vim.opt.updatetime = 50

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.cursorline = true
vim.opt.statusline = "%F %M %Y %R %= ASCII:%b HEX:0x%B ROW:%l COL:%c %p%%"
vim.opt.laststatus = 3

vim.g.netrw_browse_split = 2;
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25

vim.g.mapleader = " "
