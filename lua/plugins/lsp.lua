return {
    {
        "mason-org/mason.nvim",
        dependencies = {
            "mason-org/mason-lspconfig.nvim",
            "neovim/nvim-lspconfig",
        },
        lazy = false,
        config = function()
            require('mason').setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls"
                }
            })


            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            vim.lsp.config.vtsls = {
                filetypes = { "typescript", "javascript" },
                capabilities = capabilities,
                on_attach = function(_, bufnr)
                    vim.keymap.set("n", "<leader>lo", function()
                            vim.lsp.buf.execute_command({
                                command = "typescript.organizeImports",
                                arguments = { vim.api.nvim_buf_get_name(0) }
                            })
                        end,
                        { desc = "[O]rganize [I]mports" }
                    )
                end
            }
        end
    }
}
