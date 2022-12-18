vim.keymap.set("i", "kj", "<Esc>")

-- Recenter on half page down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- Recenter on half page up
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- Save all
vim.keymap.set("n", "<leader>sa", ":wa<CR>")

-- Format
vim.keymap.set("n", "<leader>f", ":Format<CR>")

-- NerdTree
-- Open Explorer
vim.keymap.set("n", "<leader>oe", "<cmd>NERDTreeFind<CR>")
-- Close Explorer
vim.keymap.set("n", "<leader>ce", "<cmd>NERDTreeClose<CR>")

-- Telescope
-- Search Files
vim.keymap.set("n", "<leader>sf", "<cmd>Telescope find_files<CR>", { desc = "[S]earch [F]iles" })
-- Search String
vim.keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "[S]earch [S]tring" })
-- Search Buffers
vim.keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<CR>", { desc = "[S]earch [B]uffers" })
-- Search Help Tags
vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "[S]earch [H]elp" })
-- Search Diagnostics
vim.keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>", { desc = "[S]earch [D]iagnostics" })

-- Close Buffers
vim.keymap.set("n", "<leader>cb", ":BufOnly<CR>")
