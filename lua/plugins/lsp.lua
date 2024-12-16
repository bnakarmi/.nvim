
return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        config = function()
            require('mason').setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        lazy = false,
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "cssls",
                    "gopls",
                    "html",
                    "lua_ls",
                    "rust_analyzer",
                    "ts_ls"
                }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local lspconfig = require("lspconfig")

            for _, lsp in ipairs({ "cssls", "html", "lua_ls", "gopls" }) do
                lspconfig[lsp].setup({ capabilities = capabilities })
            end

            vim.keymap.set(
                "n",
                "<leader>lf",
                function()
                    vim.lsp.buf.format { async = true }
                end,
                { desc = "[L]sp [F]ormat" }
            )

            vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "[L]sp [H]elp" })
            vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "[L]sp [D]efinition" })
            vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "[L]sp [D]eclaration" })
            vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, { desc = "[L]sp [I]mplementation" })
            vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "[L]sp [T]ype Definition" })
            vim.keymap.set("n", "<leader>lR", vim.lsp.buf.references, { desc = "[L]sp [R]eferences" })
            vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "[L]sp [H]elp" })
            vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "[L]sp [R]eferences" })
            vim.keymap.set("n", "<leader>lc", vim.lsp.buf.code_action, { desc = "[L]sp [A]ctions" })
        end
    },
}
