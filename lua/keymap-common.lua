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

vim.keymap.set("n", "<leader>cb", "<cmd>BufOnly<CR>", { desc = "[C]lose all hidden buffers" })

-- Git
vim.keymap.set("n", "<leader>gs", "<cmd>LazyGit<CR>",
    { desc = "[G]it [S]tatus" })

-- Explorer
vim.keymap.set("n", "<leader>ex", "<cmd>Ex<CR>",
    { desc = "[E]xplorer" })

vim.keymap.set("n", "[c", "<cmd>cprev<CR>",
    { desc = "[Q]uickfix list previous" })
vim.keymap.set("n", "]c", "<cmd>cnext<CR>",
    { desc = "[Q]uickfix list next" })

-- Copy/Paste from clipboard
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "[C]opy to Clipboard" })
vim.keymap.set("n", "<leader>p", "\"+P", { desc = "[P]aste from Clipoard" })

vim.keymap.set("n", "p", function()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local keys = tostring(vim.v.count1) .. "p"

    vim.api.nvim_feedkeys(
        vim.api.nvim_replace_termcodes(keys, true, false, true),
        "n",
        false
    )

    vim.schedule(function()
        local pos = vim.api.nvim_win_get_cursor(0)
        vim.api.nvim_win_set_cursor(0, { pos[1], col })
    end)
end, { desc = "[P]aste and restore column" })

vim.keymap.set("t", "<leader><esc>", "<c-\\><c-n>", { desc = "[T]erminal::Switch to normal mode" })
