require("nvim-treesitter.configs").setup({
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = {
        'go',
        'lua',
        'python',
        'rust',
        'typescript',
        'javascript',
        'help',
        'css'
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        disable = { 'html' },
        additional_vim_regex_highlighting = false
    },
    indent = { enable = true },
})
