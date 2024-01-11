return {
    {
        "mfussenegger/nvim-dap",
        config = function()
            local dap = require("dap")
            local dapui = require("dap.ui.widgets")

            -- vim.keymap.set("n", "<leader>dE", "<cmd>require'dap'.eval(vim.fn.input '[Expression] > ')<cr>",
            --     { desc = "[D]ebug [E]valuate Input" })
            -- vim.keymap.set("n", "<leader>dC", "<cmd>require'dap'.set_breakpoint(vim.fn.input '[Condition] > ')<cr>",
            --     { desc = "[D]ebug [C]onditional Breakpoint" })
            -- vim.keymap.set("n", "<leader>dU", "<cmd>lua require'dapui'.toggle()<cr>", { desc = "[D]ebug [T]oggle UI" })

            vim.keymap.set("n", "<leader>dR", dap.run_to_cursor, { desc = "[D]ebug [R]un to Cursor" })
            vim.keymap.set("n", "<leader>db", dap.step_back, { desc = "[D]ebug [S]tep Back" })
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "[D]ebug [C]ontinue" })
            vim.keymap.set("n", "<leader>dd", dap.disconnect, { desc = "[D]ebug [D]isconnect" })
            vim.keymap.set("n", "<leader>dg", dap.session, { desc = "[D]ebug [G]et Session" })
            vim.keymap.set("n", "<leader>dh", dapui.hover, { desc = "[D]ebug [H]over Variables" })
            vim.keymap.set("n", "<leader>dS", function()
                dapui.centered_float(dapui.scopes)
            end, { desc = "[D]ebug [S]copes" })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "[D]ebug [S]tep Into" })
            vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "[D]ebug [S]tep Over" })
            vim.keymap.set("n", "<leader>dq", dap.close, { desc = "[D]ebug [Q]uit" })
            vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "[D]ebug [T]oggle Repl" })
            vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "[D]ebug [S]tart" })
            vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "[D]ebug [T]oggle Breakpoint" })
            vim.keymap.set("n", "<leader>dx", dap.terminate, { desc = "[D]ebug [T]erminate" })
            vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "[D]ebug [S]tep Out" })
        end
    }
}
