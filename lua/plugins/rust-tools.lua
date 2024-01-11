return {
    "simrat39/rust-tools.nvim",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local rt = require("rust-tools")

        rt.setup({
            server = {
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                on_attach = function(_, _)
                    vim.keymap.set("n", "<leader>lh", rt.hover_actions.hover_actions,
                        { desc = "[L]SP [H]over" }
                    )

                    vim.keymap.set(
                        "n",
                        "<leader>lc",
                        rt.code_action_group.code_action_group,
                        { desc = "[L]SP [C]ode [A]ction" }
                    )
                end
            },
            tools = {
                hover_actions = {
                    auto_focus = true
                }
            }
        })
    end
}

