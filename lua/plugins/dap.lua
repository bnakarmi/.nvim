return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "leoluz/nvim-dap-go"
        },
        config = function()
            local dap = require("dap")
            local dapuiwidgets = require("dap.ui.widgets")
            local dapui = require("dapui")

            require("dapui").setup()
            require("dap-go").setup()

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

            -- vim.keymap.set("n", "<leader>du", dapui.toggle,
            --    { desc = "[D]ebug [T]oggle UI" })

            vim.keymap.set("n", "<leader>db", dap.set_breakpoint,
                { desc = "[D]ebug [C]onditional Breakpoint" })
            vim.keymap.set("n", "<leader>dcb", function()
                dap.set_breakpoint(vim.fn.input '[Condition] > ')
            end, { desc = "[D]ebug [C]onditional Breakpoint" })
            vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint,
                { desc = "[D]ebug [T]oggle Breakpoint" })

            vim.keymap.set("n", "<leader>dc", dap.continue,
                { desc = "[D]ebug [C]ontinue" })
            vim.keymap.set("n", "<leader>dx", dap.terminate,
                { desc = "[D]ebug [T]erminate" })
            vim.keymap.set("n", "<leader>dd", dap.disconnect,
                { desc = "[D]ebug [D]isconnect" })
            vim.keymap.set("n", "<leader>dq", dap.close,
                { desc = "[D]ebug [Q]uit" })

            vim.keymap.set("n", "<leader>d[", dap.step_back,
                { desc = "[D]ebug [S]tep Back" })
            vim.keymap.set("n", "<leader>di", dap.step_into,
                { desc = "[D]ebug [S]tep Into" })
            vim.keymap.set("n", "<leader>do", dap.step_out,
                { desc = "[D]ebug [S]tep Out" })
            vim.keymap.set("n", "<leader>d]", dap.step_over,
                { desc = "[D]ebug [S]tep Over" })

            vim.keymap.set("n", "<leader>dr", dap.run_to_cursor,
                { desc = "[D]ebug [R]un to Cursor" })
            vim.keymap.set("n", "<leader>ds", dap.session,
                { desc = "[D]ebug [S]ession" })
            vim.keymap.set("n", "<leader>dh", dapuiwidgets.hover,
                { desc = "[D]ebug [H]over Variables" })
            vim.keymap.set("n", "<leader>dS", function()
                dapui.centered_float(dapuiwidgets.scopes)
            end, { desc = "[D]ebug [S]copes" })
            vim.keymap.set("n", "<leader>drt", dap.repl.toggle,
                { desc = "[D]ebug [T]oggle Repl" })
            vim.keymap.set("n", "<leader>de", function()
                dap.eval(vim.fn.input '[Expression] > ')
            end, { desc = "[D]ebug [E]valuate Input" })
        end
    }
}
