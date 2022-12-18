vim.cmd [[ command! BufOnly execute '%bdelete|edit #|bdelete #' ]]
vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format{ async = true }' ]]
