local keymap = require("bimarsh.keymap")
local nnoremap = keymap.nnoremap
local inoremap = keymap.inoremap
local vnoremap = keymap.vnoremap

inoremap("kj", "<Esc>")

-- Move lines up/down 
nnoremap("<A-j>", ":m .+1<CR>==")
nnoremap("<A-k>", ":m .-2<CR>==")
inoremap("<A-j>", "<Esc>:m .+1<CR>==gi")
inoremap("<A-k>", "<Esc>:m .-2<CR>==gi")
vnoremap("<A-j>", ":m '>+1<CR>gv=gv")
vnoremap("<A-k>", ":m '<-2<CR>gv=gv")

-- Save
nnoremap("<leader>ss", ":wa<CR>")

-- Format
nnoremap("<leader>f", ":Format<CR>")

-- NerdTree
nnoremap("<leader>n", "<cmd>NERDTreeFind<CR>")
nnoremap("<leader>N", "<cmd>NERDTreeClose<CR>")

-- Telescope
nnoremap("<leader>ff", "<cmd>Telescope find_files<CR>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<CR>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<CR>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<CR>")

-- Close buffers
nnoremap("<leader>x", ":BufOnly<CR>")
