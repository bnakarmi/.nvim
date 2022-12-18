vim.keymap.set("i", "kj", "<Esc>")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

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
-- Find Files
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>")
-- Find String
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>")
-- Find Buffers
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>")
-- Find Help Tags
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>")

-- Close Buffers
vim.keymap.set("n", "<leader>cb", ":BufOnly<CR>")
