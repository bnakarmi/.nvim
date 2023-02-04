vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    -- Colorscheme
    use({
        "nvim-lualine/lualine.nvim",
        config = function()
            require("lualine").setup()
        end
    })
    use("lucasprag/simpleblack")
    use("EdenEast/nightfox.nvim")

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

    use({
        "jose-elias-alvarez/null-ls.nvim",
    })

    -- LSP
    use({
        "VonHeikemen/lsp-zero.nvim",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
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

    -- Flutter
    use({
        "akinsho/flutter-tools.nvim",
        config = function()
            require("flutter-tools").setup({})
        end
    })

    -- NerdTree
    use("preservim/nerdtree")
    use("Xuyuanp/nerdtree-git-plugin")
    -- Utilities
    use("airblade/vim-gitgutter")
    use("tpope/vim-surround")
end)
