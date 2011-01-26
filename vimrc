" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Set up the pathogen plugin.
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

"text handling configuration
set fileencodings=utf-8
set fileformats=unix,dos

let ruby_space_errors = 1
set whichwrap=b,s,<,>,[,]
au FileType xml,html runtime! scripts/closetag.vim
au FileType java,c,c++ setlocal ts=2 sw=2 et
au FileType python setlocal ts=4 sw=4
au FileType ruby setlocal ts=2 sw=2 et tw=80
au FileType perl setlocal ts=2 sw=2
au FileType php setlocal ts=2 sw=2
au FileType man map <buffer> <silent> q :q<CR>
au FileType man map <buffer> <silent> <SPACE> <PAGEDOWN>
au FileType man map <buffer> <silent> b <PAGEUP>
let g:manpageview_winopen="reuse"
