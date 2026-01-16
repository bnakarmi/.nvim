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
    }
}
