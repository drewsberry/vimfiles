" Information {{{
"
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc
" When started as "evim", evim.vim will already have done these settings.  if v:progname =~? "evim" finish endif
"
" }}}

" Default Settings {{{
"
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

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
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" }}}

" Custom settings {{{
"
set autoindent
set bg=dark  " set background as dark
syntax on
"colorscheme solarized
set nu
set numberwidth=3
set expandtab
set shiftwidth=4
set softtabstop=4
highlight LineNr ctermfg=White
" highlight LineNr ctermbg=DarkGrey
" highlight Comment ctermfg=DarkYellow
set guifont=Inconsolata\ 10
"setlocal spell spelllang=en_gb " Set British spellchecking on (useful pretty
"much only for writing LaTeX documents with vim).

" Manual folding. With visual block over area to be folded, press 'zf' to fold
set foldmethod=manual

" These make saving and loading folds automatic
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" Custom key binding for compiling single files in C
autocmd FileType c map \c :!gcc -o "%:p:r" "%:p"<CR>
autocmd FileType c map \ce :!gcc -o "%:p:r" "%:p" && "%:p:r"<CR>

" Automatically change line width if I modify a paragraph.
" Prevents me from having to run qqip
"set formatoptions+=a
nmap <F2> :set formatoptions+=a <CR>
nmap <F3> :set formatoptions-=a <CR>

" }}}

" " Vim-latex settings {{{
" 
" " REQUIRED: This makes vim invoke LaTex-Suite when you open a tex file
" " filetype plugin on
" 
" " IMPORTANT: win32 users will need to have 'shellslash' set so that LaTeX
" " can be called correctly
" " set shellslash
" 
" " IMPORTANT: grep will sometimes skip displaying the file name if you
" " search in a single file. This will confuse LaTex-Suite Set your grep
" " program to always generate a file-name.
" set grepprg=grep\ -nH\ $*
" 
" " OPTIONAL: This enables automatic indentation as you type.
" filetype indent on
" 
" " OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" " 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" " The following changes the default filetype to 'tex':
" let g:tex_flavor='latex'
" let g:Tex_DefaultTargetFormat='pdf'
" let g:Tex_ViewRule_dvi='okular'
" let g:Tex_ViewRule_ps='okular'
" let g:Tex_ViewRule_pdf='okular --presentation'
" let g:Tex_IgnoredWarnings = 
"   \"Undefull\n".
"   \"Overfull\n".
"   \"specifier changed to\n".
"   \"You have requested\n".
"   \"Missing number, treated as zero.\n".
"   \"There were undefined references\n".
"   \"Citation %.%# undefined\n".
"   \"LaTeX Font Warning: Font shape `OMS/qpl/m/n' undefined\n".
"   \'LaTeX Font Warning:'"
" " This number N says that latex-suite should ignore the first N of the above.
" let g:Tex_IgnoreLevel = 80
" 
" let g:Imap_FreezeImap = 1

" Rainbow parentheses default settings
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

" Rainbow parentheses on by default
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" Use Pathogen
execute pathogen#infect()

" }}}

" vim: set filetype=vim:
