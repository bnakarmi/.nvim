local function close_buffer_in_split(force)
    local current = vim.api.nvim_get_current_buf()
    local alternate = vim.fn.bufnr("#")

    if vim.bo[current].modified and not force then
        vim.notify("Buffer has unsaved changes", vim.log.levels.WARN)
        return
    end

    if alternate ~= -1 and vim.api.nvim_buf_is_valid(alternate) then
        vim.cmd("buffer #")
    else
        vim.cmd("enew")
    end

    if vim.api.nvim_buf_is_valid(current) then
        vim.cmd((force and "bdelete! " or "bdelete ") .. current)
    end
end

vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Close all hidden buffers
vim.api.nvim_create_user_command("BufOnly", "%bdelete|edit #|bdelete #", {})
vim.keymap.set("n", "<leader>cab", "<cmd>BufOnly<CR>", { desc = "[C]lose all hidden buffers" })
vim.keymap.set("n", "<leader>cb", function()
    close_buffer_in_split(false)
end, { desc = "[C]lose buffer in current split and go to previous buffer" })
vim.keymap.set("n", "<leader>cB", function()
    close_buffer_in_split(true)
end, { desc = "[C]lose buffer in current split and go to previous buffer" })

-- Git
vim.keymap.set("n", "<leader>gs", "<cmd>LazyGit<CR>",
    { desc = "[G]it [S]tatus" })

-- Explorer
vim.keymap.set("n", "<leader>ex", "<cmd>Ex<CR>",
    { desc = "[E]xplorer" })

vim.keymap.set("v", "<leader>y", "\"+y", { desc = "[C]opy to Clipboard" })
vim.keymap.set("n", "p", function()
    local c = vim.fn.col(".")

    vim.cmd("normal! p")
    vim.fn.cursor(vim.fn.line("."), c)
end, { desc = "[P]aste and restore column" })
vim.keymap.set("n", "<leader>p", "\"+P", { desc = "[P]aste from Clipoard" })

vim.keymap.set("t", "<leader><esc>", "<c-\\><c-n>", { desc = "[T]erminal::Switch to normal mode" })
