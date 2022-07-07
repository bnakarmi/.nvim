set exrc
set relativenumber
set nu
set nohlsearch
set hidden
set noerrorbells
set tabstop=4 softtabstop=4
set expandtab
set shiftwidth=4
set autoindent
set smartindent
set nowrap
set incsearch
set termguicolors
set scrolloff=8
set noshowmode
set colorcolumn=80
set signcolumn=yes
set background="dark"
set mouse=a

" map leader to space
let mapleader = " "

" Exit insert mode
inoremap kj <Esc>
" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
" Move lines up/down 
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" Format
nnoremap <leader><S-f> <cmd>Format<cr>

" Plugins
call plug#begin()
    " Airline Themes
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " Colorscheme Themes
    Plug 'lucasprag/simpleblack'
    Plug 'ayu-theme/ayu-vim'
    " Telescope
    Plug 'kyazdani42/nvim-web-devicons'
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
    " Formatter
    Plug 'lukas-reineke/lsp-format.nvim'
    " Auto pair
    Plug 'windwp/nvim-autopairs'
call plug#end()

" Theme
syntax enable

" Airline
let g:airline_theme = 'molokai'
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1 
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_powerline_fonts = 1
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let ayucolor = 'dark'
colorscheme ayu 

lua require('lsp-config')
lua require('cmp-config')
lua require('autopairs')
