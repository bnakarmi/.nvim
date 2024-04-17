local sign = function(opts)
    vim.fn.sign_define(opts.name, {
        texthl = opts.name,
        text = opts.text,
        numhl = "",
    })
end

sign({ name = "DiagnosticSignError", text = "✘" })
sign({ name = "DiagnosticSignWarn", text = "▲" })
sign({ name = "DiagnosticSignHint", text = "⚑" })
sign({ name = "DiagnosticSignInfo", text = "" })

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "[P]revious [D]iagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "[N]ext [D]iagnostic" })
vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { desc = "[O]pen [D]iagnostic [E]rror" })

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    signs = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})
