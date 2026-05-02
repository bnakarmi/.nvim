local set = vim.keymap.set

set("i", "kj", "<Esc>")
set("v", ">", ">gv")
set("v", "<", "<gv")

-- Move lines up/down
set("n", "<A-j>", ":m .+1<CR>==")
set("n", "<A-k>", ":m .-2<CR>==")
set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
set("v", "<A-j>", ":m '>+1<CR>gv=gv")
set("v", "<A-k>", ":m '<-2<CR>gv=gv")

set("n", "<leader>cb", "<cmd>BufOnly<CR>", { desc = "[C]lose all hidden buffers" })

-- Git
set("n", "<leader>gs", "<cmd>LazyGit<CR>", { desc = "[G]it [S]tatus" })

-- Explorer
set("n", "<leader>ex", "<cmd>Ex<CR>", { desc = "[E]xplorer" })
set("n", "[[", "<cmd>cprev<CR>", { desc = "[Q]uickfix list previous" })
set("n", "]]", "<cmd>cnext<CR>", { desc = "[Q]uickfix list next" })

-- Copy/Paste from clipboard
set("v", "<leader>y", "\"+y", { desc = "[C]opy to Clipboard" })
set("n", "<leader>p", "\"+P", { desc = "[P]aste from Clipoard" })

set("n", "p", function()
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

-- Open a terminal at the bottom of the screen with a fixed height.
set("n", ",st", function()
    vim.cmd.new()
    vim.cmd.wincmd "J"
    vim.api.nvim_win_set_height(0, 12)
    vim.wo.winfixheight = true
    vim.cmd.term()
end)

set("t", "<leader><esc>", "<c-\\><c-n>", { desc = "[T]erminal::Switch to normal mode" })
