" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=500		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

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

  " http://stackoverflow.com/questions/356126/how-can-you-automatically-remove-trailing-whitespace-in-vim
  fun! <SID>StripTrailingWhitespaces()
      let l = line(".")
      let c = col(".")
      %s/\s\+$//e
      call cursor(l, c)
  endfun
  autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" set terminal title
set title

" show line numbers
set number

" ignore case in search unless searching uppercase letters
set ignorecase smartcase

" cool menu with highlighting
set wildmenu wildmode=list:longest

" shot messages
set shortmess=aoOtTI

" automatically save buffer on :next or the like
set autowrite

" highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+\%#\@<!$/

" faster scrolling with ^e ^y
nnoremap <C-e> 3<C-e>

nnoremap <C-y> 3<C-y>

" better % command
runtime macros/matchit.vim

" moving between tabs
map <S-Right> :tabn<return>
map <S-Left> :tabprev<return>

" nice leader key to bind custom actions
let mapleader = ","

" :noh with ,n
nmap <silent> <leader>n :silent :nohlsearch<CR>

" where to store swap and backup files
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/tmp

" Move cursor back to where it was in insert mode after exiting insert mode.
" This prevents the cursor from moving one character to the left.
"inoremap <silent> <Esc> <Esc>`^

" http://stackoverflow.com/questions/677986/vim-copy-selection-to-os-x-clipboard
"set clipboard=unnamed
"vmap <C-x> :!pbcopy<CR>
"vmap <C-c> :w !pbcopy<CR><CR>

vmap <C-c> y: call system("xclip -i -selection clipboard", getreg("\""))<CR>
vmap <C-x> d: call system("xclip -i -selection clipboard", getreg("\""))<CR>
"nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

" vim plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle', 'NERDTreeToggleVCS', 'NERDTreeFocus', 'NERDTreeFind'] }
" Plug 'micha/vim-colors-solarized'
Plug 'joshdick/onedark.vim'
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'tpope/vim-obsession'

call plug#end()


" NERDTree https://github.com/scrooloose/nerdtree
autocmd vimenter * if !argc() | execute 'NERDTree' | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" solarized colors:
" syntax enable
set background=dark
"let g:solarized_termcolors=256
" colorscheme solarized
colorscheme onedark

" http://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap // y/<C-R>"<CR>

set ttymouse=sgr