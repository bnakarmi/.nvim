" Plugins
call plug#begin()
    Plug 'nvim-lualine/lualine.nvim'
    " Colorscheme
    Plug 'lucasprag/simpleblack'
    Plug 'k4yt3x/ayu-vim-darker'
    Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
    Plug 'EdenEast/nightfox.nvim'
    " Icons
    Plug 'ryanoasis/vim-devicons'
    Plug 'kyazdani42/nvim-web-devicons'
    " Telescope
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    " LSP installer
    Plug 'williamboman/nvim-lsp-installer'
    " LSP
    Plug 'neovim/nvim-lspconfig'
    " Completion
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-cmdline'
    " Snippet
    Plug 'L3MON4D3/LuaSnip'
    Plug 'rafamadriz/friendly-snippets'
    " Flutter
    Plug 'akinsho/flutter-tools.nvim'
    " Formatter
    Plug 'jose-elias-alvarez/null-ls.nvim'
    " NerdTree
    Plug 'preservim/nerdtree'
    Plug 'Xuyuanp/nerdtree-git-plugin'
    " Utilities
    Plug 'windwp/nvim-autopairs'
    Plug 'terrortylor/nvim-comment'
    Plug 'alvan/vim-closetag'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-surround'
call plug#end()

lua require("bimarsh")
