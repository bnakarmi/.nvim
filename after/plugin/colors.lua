vim.g.ayucolor = "darker"

vim.cmd.syntax("enable")
vim.cmd.colorscheme("ayu")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
