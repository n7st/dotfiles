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
Plug 'nvim-lua/plenary.nvim' " Required by Telescope
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'
Plug 'folke/which-key.nvim'

" Code completion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

call plug#end()

function! ToggleBottomTerminal()
  let term_win = -1
  let bottom_row = -1

  for win in range(1, winnr('$'))
    let bufnr = winbufnr(win)
    if getbufvar(bufnr, '&buftype') ==# 'terminal'
      let pos = win_screenpos(win)[0]
      if pos > bottom_row
        let term_win = win
        let bottom_row = pos
      endif
    endif
  endfor

  if term_win > 0
    execute term_win . 'wincmd w'
    close
  else
    botright split
    resize 28
    terminal
  endif
endfunction

" Keybinds
let mapleader = ' '

:inoremap jj <Esc>

" Find files using Telescope command-line sugar {{
:nnoremap <leader>fz <cmd>Telescope find_files<cr>
:nnoremap <leader>fg <cmd>Telescope live_grep<cr>
:nnoremap <leader>fb <cmd>Telescope buffers<cr>
:nnoremap <leader>fh <cmd>Telescope help_tags<cr>
:nnoremap <leader>, <cmd>Telescope buffers<cr>
":nnoremap <leader>ot :botright split<CR>:resize 28<CR>:terminal<CR>
:nnoremap <leader>ot :call ToggleBottomTerminal()<CR>
:nnoremap <leader>oT <cmd>term<cr>
:nnoremap <leader>bk :bdelete<cr>

" cs = "clean splits"
:nnoremap <leader>cs :wincmd =<cr>

" DOOM Emacs compat - open fuzzy finder in current buffer's file's directory
:nnoremap <leader>. :lua require('telescope.builtin').find_files({ cwd = vim.fn.expand('%:p:h') })<CR>
:nnoremap <leader>/ :lua require('telescope.builtin').live_grep({ cwd = vim.fn.expand('%:p:h') })<CR>

" Terminal keybinds
:tnoremap <Esc> <C-\><C-N>
" }}

:autocmd TermOpen * startinsert

" Visual
colorscheme catppuccin

" External scripts
lua require('tree')
lua require('autocompletion')

