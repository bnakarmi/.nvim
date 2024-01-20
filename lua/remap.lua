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
vim.keymap.set("n", "<leader>cb", "<cmd>BufOnly<CR>")

-- Telescope
vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<CR>",
    { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<CR>",
    { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<CR>",
    { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<CR>",
    { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>",
    { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<CR>",
    { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sls", "<cmd>Telescope lsp_document_symbols<CR>",
    { desc = "[S]earch [L]sp [S]ymbols" })

-- Git
vim.keymap.set("n", "<leader>gs", "<cmd>LazyGit<CR>",
    { desc = "[G]it [S]tatus" })

-- Explorer
vim.keymap.set("n", "<leader>ex", "<cmd>Ex<CR>",
    { desc = "[E]xplorer" })

