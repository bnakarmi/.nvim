vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")
    -- Colorscheme
    use("lucasprag/simpleblack")
    use({
        "EdenEast/nightfox.nvim",
    })
    use({
        'folke/tokyonight.nvim'
    })
    use({
        'Shatur/neovim-ayu'
    })

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = {
            { "nvim-lua/plenary.nvim" },
        },
        config = function()
            require('telescope').setup()
        end
    })

    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use({ "nvim-treesitter/nvim-treesitter-context" })

    -- LSP
    use({
        "VonHeikemen/lsp-zero.nvim",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "simrat39/rust-tools.nvim" },
            -- LSP clients
            { "mfussenegger/nvim-jdtls" },
            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },
            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
    })

    use("tpope/vim-fugitive")
end)
