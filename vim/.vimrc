" NeoBundle setting
" Before use this .vimrc, type following
" $ curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > install.sh
" $ sh ./install.sh
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim/

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

if filereadable($HOME . '.vimrc.local')
  source $HOME/.vimrc.local
endif

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'qpkorr/vim-bufkill'

" Yaml indent
NeoBundle 'chase/vim-ansible-yaml'

" Rust
NeoBundle 'rust-lang/rust.vim'

" Markdown
"NeoBundle 'plasticboy/vim-markdown'

" Python
" NeoBundle 'Vimjas/vim-python-pep8-indent'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck


" General
set fenc=utf-8
set nobackup
set noswapfile
set autoread
set hidden
set showcmd

" バッファ
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
" 行末の空白を表示する
set list
set listchars=trail:·
highlight ExtraWhitespace ctermfg=darkgreen guifg=darkgreen
" 半角，タブ
" match ExtraWhitespace /\s\+$/
" 半角スペースのみ
match ExtraWhitespace / \+$/
" 保存時に行末の空白を削除
autocmd BufWritePre * :%s/\s\+$//ge

" Color theme
colorscheme lucius
syntax on
set t_Co=256
" If your env is not 24bit color terminal, disable following setting
set termguicolors
set background=dark
let g:terminal_ansi_colors = [
\ '#073642',
\ '#dc322f',
\ '#859900',
\ '#b58900',
\ '#268bd2',
\ '#d33682',
\ '#2aa198',
\ '#eee8d5',
\ '#008BA6',
\ '#cb4b16',
\ '#586e75',
\ '#657b83',
\ '#839496',
\ '#6c71c4',
\ '#93a1a1',
\ '#fdf6e3',
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

let g:ansible_options = {'ignore_blank_lines': 0}

" Indent width
if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "ファイルタイプに合わせたインデントを利用
  filetype indent on
  "sw=softtabstop, sts=shiftwidth, ts=tabstop, et=expandtabの略
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
  autocmd FileType html        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType scss        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType sass        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript  setlocal sw=4 sts=4 ts=4 et
endif
