" VIM configuration
" Author: Baihu Qian
" Email: baihuqian@gmail.com
" Date: Sept 14th, 2016
" Version: 2.2

"====================================================================
" enable VIM's power
set nocompatible

" automatically reload .vimrc
autocmd! bufwritepost .vimrc source %

"=====================Vundle Configuration=========================
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"---------------------START OF PLUGIN--------------------------------
" Themes
Plugin 'altercation/vim-colors-solarized' "Solarized color for vim https://github.com/altercation/vim-colors-solarized
Plugin 'tomasr/molokai'
Plugin 'vim-airline/vim-airline' "Status bar
Plugin 'vim-airline/vim-airline-themes'
" YouCompleteMe
if has('mac')
  Plugin 'Valloric/YouCompleteMe'
endif
" Autocompletion for quotes, parens, brackets, etc.
Plugin 'Raimondi/delimitMate'
" File browser
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
" Static code Analysis
Plugin 'scrooloose/syntastic'
" Methods, variables, functions overview
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'     " requires exuberant ctags to work, use "brew install ctags-exuberant"
Plugin 'majutsushi/tagbar'
" Sublime text style file opener(using Ctrl + P)
Plugin 'derekwyatt/vim-scala'
Plugin 'kien/ctrlp.vim'
Plugin 'fatih/vim-go' " Go support
Plugin 'ervandew/supertab' " Tab completion
Plugin 'jiangmiao/auto-pairs' " Pair parenthesis
Plugin 'scrooloose/nerdcommenter'
Plugin 'Yggdroot/indentLine' " Display the indention levels with thin vertical lines

"---------------------END OF PLUGIN--------------------------------
call vundle#end()            " required
filetype plugin indent on    " required
"===================================================================
" Plugin configuration
" airline
set laststatus=2 " Status bar to show all the time
let g:airline_powerline_fonts = 1 " need to install fonts, and set the non-ASCII fonts in iTerm2 to fonts-for-powerline
let g:airline_theme='solarized'

" NERDTree/tabs
let g:nerdtree_tabs_open_on_console_startup = 0 " 1 to enable NERDTree on startup

" Syntastic
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

" Easytags settings
let g:easytags_file = '~/.vim/tags'  " Use a global tag file in ~/.vim/tags
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_resolve_links = 1
let g:easytags_suppress_ctags_warning = 1

" Theme configuration
set background=dark         " toggle to "light" for light colorsheme
colorscheme molokai

" NERDCommenter
filetype plugin on
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/'  }  }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" enable syntax highlighting
syntax on

" fix backspace deletion issue
set backspace=indent,eol,start

" enable cursor wrap
" < and > are cursor keys in normal/visual mode
" [ and ] are cursor keys in insert mode
set whichwrap+=<,>,h,l,[,]

" set apparance 
set scrolloff=7		" lines below/above cursor
set winwidth=79		" window width 
set number 		    " show line number
set relativenumber  " show relative line number
set mouse=a 		" enable mouse
" set cursorcolumn	" highlight current column
set cursorline		" highlight current line 
set nowrap		    " do not wrap content

" aboslute line number in insert mode, relative line number in normal mode
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber

" set search behavior
set hlsearch        " highlight search hit
set incsearch       " search when typing
set ignorecase      " ignore case when searching
set smartcase       " don't ignore case if captical letters appear in search

" No backup and swapfile
set nobackup
set noswapfile

" Whitespace notification
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
autocmd filetype html,xml set listchars-=tab:>.

" 代码折叠
set foldenable
" 折叠方法
" manual    手工折叠
" indent    使用缩进表示折叠
" expr      使用表达式定义折叠
" syntax    使用语法定义折叠
" diff      对没有更改的文本进行折叠
" marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
set foldmethod=indent
set foldlevel=99

" Map fold key to space
nmap <space> za

" indentation
set smartindent		" enable smart indent
set autoindent		" enable auto indent
set tabstop=2          " set width of tab in terms of number of white spaces
set shiftwidth=2        " set the size of indent
set softtabstop=2	" backspace will delete the same amount of spaces
set expandtab		" insert space instead of tab
set smarttab

" Autocompletion
set completeopt=longest,menu
" <Enter> after selection won't create a new line
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" FileEncode Settings
set encoding=utf-8	" encode new file in UTF-8
set ffs=unix,dos,mac	" Use Unix as the standard file type

" Automatically reload changed file
set autoread

" Mute error bell
set novisualbell

set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Map keys
" Use w!! to write the file as sudo
cmap w!! w !sudo tee % >/dev/null

" Python
augroup vimrc_autocmds
    autocmd!
    " highlight characters past column 120
    autocmd FileType python highlight Excess ctermbg=DarkGrey guibg=Black
    autocmd FileType python match Excess /\%120v.*/
    autocmd FileType python set nowrap
    augroup END

" For copy, use F2 to toggle row number display
function! HideNumber()
    if(&relativenumber == &number)
        set relativenumber! number!
    elseif(&number)
        set number!
    else
        set relativenumber!
    endif
    set number?
endfunc
" F1 to toggle line number
map <F1> :call HideNumber()<CR>

" Toggle between relative number and absolute line number
function! ToggleNumber()
    if(&number && &relativenumber)
        set number
        set relativenumber!
    else
        set number
        set relativenumber
    endif
endfunc
map <F2> :call ToggleNumber()<CR>

function! ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "a"
    endif

    if &mouse == ""
        let &mouse = s:old_mouse
        echo "Mouse enabled (" . &mouse . ")"
    else
        let s:old_mouse = &mouse
        let &mouse=""
        echo "Mouse disabled"
    endif
endfunc
map <F3> :call ToggleMouse()<CR>

" Toggle Syntastic code check
map <F4> :SyntasticToggleMode<CR>

" Toggle paste mode
set pastetoggle=<F5>

" Toggle word wrap
map <F6> :set wrap!<CR>

" Toggle file tab
map <F7> :NERDTreeToggle<CR>

" Toggle Tagbar
map <F8> :TagbarToggle<CR>

" Automatically add headers for shell scripts and Python scripts
autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    " shell scripts
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    " Python scripts
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif

    normal G
    normal o
    normal o
endfunc

" <F10> to run a file
map <F10> :call CompileRun()<CR>
func! CompileRun()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
        exec "!rm ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!time ./%<"
        exec "!rm ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        exec "!zsh %"
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'go'
        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'javascript'
        exec "!nodemon %"
    elseif &filetype == 'ruby'
        exec "!time ruby %"
    endif
endfunc


