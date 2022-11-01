"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ignore white space in vimdiff
" set diffopt+=iwhite
" set diffexpr=""

" Get out of VI's compatible mode..
set nocompatible
" Sets how many lines of history VIM has to remember
set history=100
"Enable filetype plugin
filetype plugin on
filetype indent on
" switch syntax highlighting on
" syntax on
syntax enable

" Set to auto read when a file is changed from the outside
set autoread
" save when changing buffer
set autowrite

" forbiden mouse
set mouse=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Interface & Display
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 区分大小写
set infercase
set linebreak
" 将tab键和多余的空格显示出来
set listchars=tab:»·,trail:·
set list

set wildmenu
set wildmode=longest:full,full
" 自动补全的触发键, default=<Tab>
" set wildchar=<C-n>
" set scroll offset
set scrolloff=5
" Show the line and column number of the cursor position, separated by a comma
set ruler
" change buffer without saving
set hid
" set backspace
set backspace=indent,eol,start
" Ignore case in search patterns.
set ignorecase
set smartcase
" When there is a previous search pattern, highlight all its matches.
set hlsearch
" While typing a search command, show where the pattern, as it was typed so far, matches.
set incsearch
" Set magic on, for regular expressions
set magic
" When a bracket is inserted, briefly jump to the matching one
set showmatch
set matchtime=2
" no sound on errors
set noerrorbells
set novisualbell
" The value of this option influences when the last window will have a status line
set laststatus=2    " always show the statue line
" line number
set number
set relativenumber

" set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set synmaxcol=200          " Only highlight the first 200 columns.

" set virtualedit=all

" 高亮显示匹配的尖括号
set mps+=<:>
set mps+={:}
set mps+=$:$

" <leader> 键映射修改
let mapleader="\<Space>"

""""""""""""""""""""""""""""""
" Indent
""""""""""""""""""""""""""""""
set shiftwidth=2
set tabstop=2
set softtabstop=2
" set shiftwidth=4
" set tabstop=4
" set softtabstop=4
set expandtab   "Use the appropriate number of spaces to insert a <Tab>.
set smarttab    "set smarttab, at the start of line use shiftwide and others tabstop
" Auto indent
set autoindent
" Smart indent
set smartindent
" show a visual line under the cursor's current line and highlight the line
" number
set cursorline
set cursorlineopt=number

" set clipboard^=unnamed
" https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-from-wsl
set clipboard+=unnamedplus

if system('uname -r') =~ "microsoft"
if has('nvim')
    let s:win32yank = '/usr/local/bin/win32yank.exe'
    let g:clipboard = {
          \  'name' : 'wsl',
          \  'copy' : {
          \    '+' : s:win32yank..' -i --crlf',
          \    '*' : s:win32yank..' -i --crlf',
          \  },
          \  'paste' : {
          \    '+' : s:win32yank..' -o --lf',
          \    '*' : s:win32yank..' -o --lf',
          \  },
          \}
    unlet s:win32yank
endif
endif

""""""""""""""""""""""""""""""
" Encoding
""""""""""""""""""""""""""""""
scriptencoding=utf-8 " :w ++enc=utf-8 to solve conversion error
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,cp936,latin1
set termencoding=utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoCmd
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("autocmd")
	"auto read vimrc when it refreshed
    autocmd! bufwritepost ~/.vim/vimrc source ~/.vim/vimrc

	"自动回到上次打开的位置
	autocmd! BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

    " indentLine 
    autocmd FileType json,markdown let g:indentLine_conceallevel = 0

    " make vim json to jsonc type
    " for 'Comments are not permitted in JSON' problem
    au BufRead,BufNewFile *.json set filetype=jsonc

    au BufRead,BufNewFile *.s,*.S set filetype=gas

endif 

" https://www.reddit.com/r/vim/comments/2362q1/let_mapleader_now_how_do_i_get_rid_of_that_delay/
augroup FastEscape
    autocmd!
    au InsertEnter * set timeoutlen=0
    au InsertLeave * set timeoutlen=1000
augroup END
