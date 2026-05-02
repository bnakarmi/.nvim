local set = vim.keymap.set

set("n", "<leader>db", ":DapToggleBreakpoint<cr>", { desc = "[D]ebug [T]oggle Breakpoint" })
set("n", "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
    { desc = "[D]ebug [C]onditional Breakpoint" })

set("n", "<leader>di", ":DapStepInto<cr>", { desc = "[D]ebug [S]tep Into" })
set("n", "<leader>dI", ":DapStepOut<cr>", { desc = "[D]ebug [S]tep Into" })
set("n", "<leader>do", ":DapStepOver<cr>", { desc = "[D]ebug [S]tep Over" })
set("n", "<leader>dO", "<cmd>lua require'dap'.step_back()<cr>", { desc = "[D]ebug [S]tep Back" })

set("n", "<leader>dc", ":DapContinue<cr>", { desc = "[D]ebug [C]ontinue" })
set("n", "<leader>dr", "<cmd>lua require'dap'.run_to_cursor()<cr>", { desc = "[D]ebug [R]un to Cursor" })
set("n", "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>", { desc = "[D]ebug [P]ause" })
set("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", { desc = "[D]ebug [D]isconnect" })
set("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", { desc = "[D]ebug [T]erminate" })
set("n", "<leader>dq", "<cmd>lua require'dap'.close()<cr>", { desc = "[D]ebug [Q]uit" })

set("n", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", { desc = "[D]ebug [E]valuate" })
set("v", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", { desc = "[D]ebug [E]valuate" })
set("n", "<leader>dE", "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>",
    { desc = "[D]ebug [E]valuate Input" })

set("n", "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "[D]ebug [T]oggle UI" })
set("n", "<leader>drt", "<cmd>lua require'dap'.repl.toggle()<cr>", { desc = "[D]ebug [T]oggle Repl" })

set("n", "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", { desc = "[D]ebug [H]over Variables" })
set("n", "<leader>ds", "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", { desc = "[D]ebug [S]copes" })
set("n", "<leader>dgs", "<cmd>lua require'dap'.session()<cr>", { desc = "[D]ebug [G]et Session" })
