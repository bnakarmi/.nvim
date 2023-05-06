vim.keymap.set("i", "kj", "<Esc>")

-- Recenter on half page down
vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- Recenter on half page up
vim.keymap.set("n", "<C-u>", "<C-u>zz")
-- Recenter on page forward
vim.keymap.set("n", "<C-f>", "<C-f>zz")
-- Recenter on page backward
vim.keymap.set("n", "<C-b>", "<C-b>zz")
-- Recenter on find next
vim.keymap.set("n", "n", "nzz")
-- Recenter on find previous
vim.keymap.set("n", "N", "Nzz")

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
vim.keymap.set("n", "<leader>sg", "<cmd>Telescope live_grep<CR>", { desc = "[S]earch by [G]rep" })
-- Search Buffers
vim.keymap.set("n", "<leader>sb", "<cmd>Telescope buffers<CR>", { desc = "[S]earch [B]uffers" })
-- Search Help Tags
vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", { desc = "[S]earch [H]elp" })
-- Search Diagnostics
vim.keymap.set("n", "<leader>sd", "<cmd>Telescope diagnostics<CR>", { desc = "[S]earch [D]iagnostics" })
-- Search Keymaps
vim.keymap.set("n", "<leader>sk", "<cmd>Telescope keymaps<CR>", { desc = "[S]earch [K]eymaps" })

-- Close Buffers
vim.keymap.set("n", "<leader>cb", ":BufOnly<CR>")

-- Debugging
vim.keymap.set("n", "<leader>dR", "<cmd>lua require'dap'.run_to_cursor()<cr>", { desc = "[D]ebug [R]un to Cursor" })
vim.keymap.set("n", "<leader>dE", "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", { desc = "[D]ebug [E]valuate Input" })
vim.keymap.set("n", "<leader>dC", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", { desc = "[D]ebug [C]onditional Breakpoint" })
vim.keymap.set("n", "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "[D]ebug [T]oggle UI" })
vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.step_back()<cr>", { desc = "[D]ebug [S]tep Back" })
vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { desc = "[D]ebug [C]ontinue" })
vim.keymap.set("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", { desc = "[D]ebug [D]isconnect" })
vim.keymap.set("n", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", { desc = "[D]ebug [E]valuate" })
vim.keymap.set("n", "<leader>dg", "<cmd>lua require'dap'.session()<cr>", { desc = "[D]ebug [G]et Session" })
vim.keymap.set("n", "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", { desc = "[D]ebug [H]over Variables" })
vim.keymap.set("n", "<leader>dS", "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", { desc = "[D]ebug [S]copes" })
vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", { desc = "[D]ebug [S]tep Into" })
vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", { desc = "[D]ebug [S]tep Over" })
vim.keymap.set("n", "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>", { desc = "[D]ebug [P]ause" })
vim.keymap.set("n", "<leader>dq", "<cmd>lua require'dap'.close()<cr>", { desc = "[D]ebug [Q]uit" })
vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { desc = "[D]ebug [T]oggle Repl" })
vim.keymap.set("n", "<leader>ds", "<cmd>lua require'dap'.continue()<cr>", { desc = "[D]ebug [S]tart" })
vim.keymap.set("n", "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = "[D]ebug [T]oggle Breakpoint" })
vim.keymap.set("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", { desc = "[D]ebug [T]erminate" })
vim.keymap.set("n", "<leader>du", "<cmd>lua require'dap'.step_out()<cr>", { desc = "[D]ebug [S]tep Out" })
vim.keymap.set("v", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", { desc = "[D]ebug [E]valuate" })

-- Terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "[T]erminal [C]lose" })
