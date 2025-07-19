" vim-plug setting
" Install plug.vim if not yet installed:
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"   https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

if &compatible
  set nocompatible               " Be iMproved
endif

" Load plugins
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'junegunn/vim-plug'               " Optional: manage itself
Plug 'jonathanfilip/vim-lucius'
Plug 'qpkorr/vim-bufkill'
Plug 'chase/vim-ansible-yaml'
Plug 'rust-lang/rust.vim'
" Plug 'plasticboy/vim-markdown'
" Plug 'Vimjas/vim-python-pep8-indent'

call plug#end()

" General
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd
" ヤンクコピー
vnoremap <leader>y "+y
nnoremap <leader>y "+y
set clipboard=unnamedplus

" バッファ操作
nnoremap <C-c> :BD<CR>

" Style
set number
set cursorline
set virtualedit=onemore
set smartindent
set cindent
set visualbell
set showmatch
set laststatus=2
set wildmode=list:longest
nnoremap j gj
nnoremap k gk

if has('vim_starting')
  let &t_SI .= "\e[6 q"
  let &t_EI .= "\e[2 q"
  let &t_SR .= "\e[4 q"
endif

" 行末の空白を表示・削除
set list
set listchars=trail:·
highlight ExtraWhitespace ctermfg=darkgreen guifg=darkgreen
match ExtraWhitespace / \+$/
autocmd BufWritePre * :%s/\s\+$//ge

" Color theme
colorscheme lucius
syntax on
set t_Co=256
set termguicolors
set background=dark
let g:terminal_ansi_colors = [
\ '#073642', '#dc322f', '#859900', '#b58900',
\ '#268bd2', '#d33682', '#2aa198', '#eee8d5',
\ '#008BA6', '#cb4b16', '#586e75', '#657b83',
\ '#839496', '#6c71c4', '#93a1a1', '#fdf6e3',
\ ]

" Tab
set list listchars=tab:\▸\-
set expandtab
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start

" Search
set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Ansible
let g:ansible_options = {'ignore_blank_lines': 0}

" Filetype-specific indent
if has("autocmd")
  filetype plugin on
  filetype indent on
  autocmd FileType c           setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType ruby        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType js          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType zsh         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scala       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType json        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType yml         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType yaml        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript  setlocal sw=4 sts=4 ts=4 et
endif

" Load local settings if available
if filereadable($HOME . '/.vimrc.local')
  source $HOME/.vimrc.local
endif

