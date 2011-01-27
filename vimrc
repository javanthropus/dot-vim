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
"  set nobackup		 " Do not keep a backup file, use versions instead.
"else
"  set backup		   " Keep a backup file.
"endif
set history=50		" Keep 50 lines of command line history.
set ruler		      " Show the cursor position all the time.
set showcmd		    " Display incomplete commands.
set incsearch		  " Do incremental searching.

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" The GUI background is light while the terminal background is dark.
if has("gui_running")
  set background=light
else
  set background=dark
end

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  autocmd!

  " Set basic properties for various file types.
  autocmd FileType text setlocal textwidth=78
  autocmd FileType vim setlocal ts=2 sw=2 et tw=80
  autocmd FileType java,c,c++ setlocal ts=2 sw=2 et tw=80
  autocmd FileType python setlocal ts=4 sw=4 tw=80
  autocmd FileType ruby setlocal ts=2 sw=2 et tw=80
  autocmd FileType perl setlocal ts=2 sw=2 tw=80
  autocmd FileType php setlocal ts=2 sw=2 tw=80

  " Configure toggle comment maps.
  autocmd FileType vim map <buffer> <silent> ,c :call CommentLineToEnd('"')<CR>
  autocmd FileType text,python,ruby,perl,php,conf map <buffer> <silent> ,c :call CommentLineToEnd('#')<CR>
  autocmd FileType xml,html map <buffer> <silent> ,c :call CommentLinePincer('<!-- ', ' -->')<CR>
  autocmd FileType java,c++ map <buffer> <silent> ,C :call CommentLinePincer('/* ', ' */')<CR>
  autocmd FileType java,c++ map <buffer> <silent> ,c :call CommentLineToEnd('//')<CR>
  autocmd FileType c map <buffer> <silent> ,c :call CommentLinePincer('/* ', ' */')<CR>

  " Load the closetag script for XML-like files.
  autocmd FileType xml,html runtime! scripts/closetag.vim

  " Set common pager mappings when reading manpages.
  function! SetManMaps()
    map <buffer> <silent> q :q<CR>
    map <buffer> <silent> <SPACE> <PAGEDOWN>
    map <buffer> <silent> b <PAGEUP>
  endfunction " SetManMaps
  autocmd FileType man call SetManMaps()

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

" Text handling configuration
set fileencodings=utf-8
set fileformats=unix,dos

" Lines with trailing whitespace in Ruby files will be flagged.
let ruby_space_errors = 1

" The current will be reused to open new manpages.
let g:manpageview_winopen="reuse"

" Allow for line wrapping with arrows, space, and backspace in commands that use
" them.
set whichwrap=b,s,<,>,[,]
