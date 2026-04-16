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
vim.keymap.set("n", "<leader>cb", "<cmd>BufOnly<CR>", { desc = "[C]lose all hidden buffers" })

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
