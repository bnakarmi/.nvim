vim.cmd.packadd("packer.nvim")

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    -- Colorscheme
    use("nvim-lualine/lualine.nvim")
    use("lucasprag/simpleblack")
    use("k4yt3x/ayu-vim-darker")
    use("EdenEast/nightfox.nvim")

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = {
            { "nvim-lua/plenary.nvim" },
        },
    })
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

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

    -- Debug
    use({
        "mfussenegger/nvim-dap",
        opt = true,
        event = "BufReadPre",
        module = { "dap" },
        wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "nvim-dap-python" },
        requires = {
            { "theHamsta/nvim-dap-virtual-text" },
            { "rcarriga/nvim-dap-ui" },
            { "mfussenegger/nvim-dap-python" },
            { "mxsdev/nvim-dap-vscode-js" },
            {
                "microsoft/vscode-js-debug",
                opt = true,
                run = "npm install --legacy-peer-deps && npm run compile",
            },
            { "nvim-telescope/telescope-dap.nvim" },
        },
    })

    -- Flutter
    use("akinsho/flutter-tools.nvim")
    -- NerdTree
    use("preservim/nerdtree")
    use("Xuyuanp/nerdtree-git-plugin")
    -- Utilities
    use("airblade/vim-gitgutter")
    use("tpope/vim-surround")
end)
