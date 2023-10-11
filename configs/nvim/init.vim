" General configuration
set nocompatible
set showmatch
set ignorecase
set mouse=v
set hlsearch
set incsearch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set number
set wildmode=longest,list
set cc=80
filetype plugin indent on
set mouse=a
set clipboard=unnamedplus
filetype plugin on
set cursorline
set ttyfast
set noswapfile
set backupdir=~/.cache/vim

" Plugins
call plug#begin("~/.config/nvim/plugged")

Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'

call plug#end()

" Keybinds
:inoremap jj <Esc>

" Visual
colorscheme catppuccin

" External scripts
lua require('tree')
