local set = vim.keymap.set

set(
    "n",
    "<leader>lf",
    function()
        require('conform').format({ async = true, lsp_fallback = true })
    end,
    { desc = "[L]sp [F]ormat" }
)

set(
    "v",
    "<leader>lf",
    function()
        require('conform')
            .format({
                async = true, lsp_fallback = true
            }, function(err)
                if not err then
                    local mode = vim.api.nvim_get_mode().mode

                    if vim.startswith(string.lower(mode), "v") then
                        vim.api.nvim_feedkeys(
                            vim.api.nvim_replace_termcodes("<Esc>", true, false, true),
                            "n", true)
                    end
                end
            end)
    end,
    { desc = "[L]sp [F]ormat - [R]ange" }
)

set("n", "<leader>lh", vim.lsp.buf.hover, { desc = "[L]sp [H]elp" })
set("n", "<leader>ld", vim.lsp.buf.definition, { desc = "[L]sp [D]efinition" })
set("n", "<leader>lD", vim.lsp.buf.declaration, { desc = "[L]sp [D]eclaration" })
set("n", "<leader>li", vim.lsp.buf.implementation, { desc = "[L]sp [I]mplementation" })
set("n", "<leader>lt", vim.lsp.buf.type_definition, { desc = "[L]sp [T]ype Definition" })
set("n", "<leader>lR", vim.lsp.buf.references, { desc = "[L]sp [R]eferences" })
set("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "[L]sp [H]elp" })
set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "[L]sp [R]eferences" })
set("n", "<leader>lc", vim.lsp.buf.code_action, { desc = "[L]sp [A]ctions" })
