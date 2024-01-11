return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    'lua',
                    'python',
                    'rust',
                    'typescript',
                    'javascript',
                    'css',
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    disable = { 'html', 'yaml' },
                    additional_vim_regex_highlighting = false
                },
                indent = { enable = true },
            })
        end
    },
    { "nvim-treesitter/nvim-treesitter-context" }
}
