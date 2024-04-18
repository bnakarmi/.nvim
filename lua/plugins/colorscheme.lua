return {
    {
        "nanotech/jellybeans.vim",
        priority = 1000,
        config = function()
            vim.cmd.syntax("enable")
            vim.cmd.colorscheme("jellybeans")
        end
    }
}
