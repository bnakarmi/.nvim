vim.cmd.syntax("enable")

return {
    {
        "nanotech/jellybeans.vim",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("jellybeans")

            vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#c06c75" })
            vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", {
                fg = "#c06c75",
                bg = "#2a1f22",
            })
            vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", {
                sp = "#c06c75",
            })
            vim.api.nvim_set_hl(0, "DiagnosticLineNrError", {
                fg = "#c06c75",
                bg = "NONE",
                bold = true,
            })
            vim.api.nvim_set_hl(0, "ErrorMsg", {
                fg = "#c06c75",
                bg = "#2a1f22",
            })
        end
    }
}
