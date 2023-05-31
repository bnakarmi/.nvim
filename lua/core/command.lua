vim.cmd [[ command! BufOnly execute '%bdelete|edit #|bdelete #' ]]
vim.cmd [[ command! CompileJava execute 'lua require("jdtls").compile("incremental")' ]]
