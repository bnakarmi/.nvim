return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio"
    },
    config = function()
        require("dapui").setup()

        local dap, dapui = require("dap"), require("dapui")

        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        -- Start
        vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<cr>", { desc = "[D]ebug [T]oggle Breakpoint" })
        vim.keymap.set("n", "<leader>dB", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>", { desc = "[D]ebug [C]onditional Breakpoint" })

        vim.keymap.set("n", "<leader>di", ":DapStepInto<cr>", { desc = "[D]ebug [S]tep Into" })
        vim.keymap.set("n", "<leader>dI", ":DapStepOut<cr>", { desc = "[D]ebug [S]tep Into" })
        vim.keymap.set("n", "<leader>do", ":DapStepOver<cr>", { desc = "[D]ebug [S]tep Over" })
        vim.keymap.set("n", "<leader>dO", "<cmd>lua require'dap'.step_back()<cr>", { desc = "[D]ebug [S]tep Back" })

        vim.keymap.set("n", "<leader>dc", ":DapContinue<cr>", { desc = "[D]ebug [C]ontinue" })
        vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.run_to_cursor()<cr>", { desc = "[D]ebug [R]un to Cursor" })
        vim.keymap.set("n", "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>", { desc = "[D]ebug [P]ause" })
        vim.keymap.set("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>", { desc = "[D]ebug [D]isconnect" })
        vim.keymap.set("n", "<leader>dx", "<cmd>lua require'dap'.terminate()<cr>", { desc = "[D]ebug [T]erminate" })
        vim.keymap.set("n", "<leader>dq", "<cmd>lua require'dap'.close()<cr>", { desc = "[D]ebug [Q]uit" })

        vim.keymap.set("n", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", { desc = "[D]ebug [E]valuate" })
        vim.keymap.set("v", "<leader>de", "<cmd>lua require'dapui'.eval()<cr>", { desc = "[D]ebug [E]valuate" })
        vim.keymap.set("n", "<leader>dE", "<cmd>lua require'dapui'.eval(vim.fn.input '[Expression] > ')<cr>", { desc = "[D]ebug [E]valuate Input" })

        vim.keymap.set("n", "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "[D]ebug [T]oggle UI" })
        vim.keymap.set("n", "<leader>drt", "<cmd>lua require'dap'.repl.toggle()<cr>", { desc = "[D]ebug [T]oggle Repl" })

        vim.keymap.set("n", "<leader>dh", "<cmd>lua require'dap.ui.widgets'.hover()<cr>", { desc = "[D]ebug [H]over Variables" })
        vim.keymap.set("n", "<leader>ds", "<cmd>lua require'dap.ui.widgets'.scopes()<cr>", { desc = "[D]ebug [S]copes" })
        vim.keymap.set("n", "<leader>dgs", "<cmd>lua require'dap'.session()<cr>", { desc = "[D]ebug [G]et Session" })
        --End
    end,
}
