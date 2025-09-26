vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function organize_imports(command, bufnr)
    local buf_nr = bufnr or vim.api.nvim_get_current_buf()
    local params = {
        command = command,
        arguments = { vim.api.nvim_buf_get_name(buf_nr) },
    }

    vim.lsp.buf.execute_command(params)
end

vim.lsp.config.ts_ls.setup({
    capabilities = capabilities,
    on_attach = function(_, bufnr)
        vim.api.nvim_create_user_command(
            "TypescriptOrganizeImports",
            function()
                organize_imports("_typescript.organizeImports", bufnr)
            end,
            { desc = "[O]rganize [I]mports" })

        vim.keymap.set("n", "<leader>lo", "<cmd>TypescriptOrganizeImports<cr>",
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
})
