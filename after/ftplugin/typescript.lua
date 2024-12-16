local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local function organize_imports(command, bufnr)
    local buf_nr = bufnr or vim.api.nvim_get_current_buf()
    local params = {
        command = command,
        arguments = { vim.api.nvim_buf_get_name(buf_nr) },
    }

    vim.lsp.buf.execute_command(params)
end

lspconfig.ts_ls.setup({
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
    end
})
