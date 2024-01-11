return {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
        require('catppuccin').setup({
            color_overrides = {
                mocha = {
                    base = "#000000",
                    mantle = "#000000",
                    crust = "#000000",
                },
            },
        })

        vim.cmd.syntax("enable")
        vim.cmd.colorscheme("catppuccin")
    end
}
