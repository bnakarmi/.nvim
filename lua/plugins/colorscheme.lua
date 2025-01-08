vim.cmd.syntax("enable")

return {
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
}
