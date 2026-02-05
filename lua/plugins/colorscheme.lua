vim.cmd.syntax("enable")

return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        enable = false,
        config = function()
            require('gruvbox').setup({
                dim_inactive = true
            })

            vim.cmd.colorscheme("gruvbox")
        end
    },
    {
        "nanotech/jellybeans.vim",
        priority = 1000,
        enabled = false,
        config = function()
            vim.cmd.colorscheme("jellybeans")
        end
    },
    {
        "rebelot/kanagawa.nvim",
        priority = 1000,
        enabled = false,
        config = function()
            vim.cmd.colorscheme("kanagawa-dragon")
        end
    },
    {
        "neanias/everforest-nvim",
        priority = 1000,
        enabled = false,
        config = function()
            vim.cmd.colorscheme("everforest")
        end
    },
    {
        "shaunsingh/nord.nvim",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("nord")
        end
    },
}
