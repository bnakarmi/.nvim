vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config.vtsls = {
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

        vim.keymap.set(
            "n",
            "<leader>lf",
            function()
                require('conform').format({ async = true, bufnr = bufnr })
            end,
            { desc = "[L]sp [F]ormat" }
        )

        vim.keymap.set(
            "v",
            "<leader>lf",
            function()
                require('conform').format({ async = true, bufnr = bufnr }, function(err)
                    if not err then
                        local mode = vim.api.nvim_get_mode().mode

                        if vim.startswith(string.lower(mode), "v") then
                            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
                        end
                    end
                end)
            end,
            { desc = "[L]sp [F]ormat - [R]ange" }
        )
    end
}
