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
vim.keymap.set("n", "do", vim.diagnostic.open_float, { desc = "[O]pen [D]iagnostic [E]rror" })
vim.keymap.set("n", "dq", vim.diagnostic.setloclist, { desc = "[O]pen [D]iagnostic [Q]uickfix [L]ist" })

vim.diagnostic.config({
    virtual_text = true,
    severity_sort = true,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '✘ ',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '',
        },
        linehl = {
            [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
        },
        numhl = {
            [vim.diagnostic.severity.WARN] = 'WarningMsg',
        },
    },
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})
