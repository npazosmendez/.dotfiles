" Bundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " package manager
Plugin 'flazz/vim-colorschemes' " colorscheme pack
Plugin 'SuperTab' " autocompletion
Plugin 'vim-lastplace' " remember cursor position across sessions
Plugin 'vim-fugitive' " git integration
Plugin 'delimitMate.vim' " automatic parenthesis/braces close
call vundle#end()

" File Type Recognition
filetype plugin indent on 

" General Settings
set number " line numbers
set mouse=a " mouse enabled
set nowrap " no line wrap
set showcmd " display incomplete commands
set ruler " show cursor position
set virtualedit=block " allow cursor anywhere in block vmode
set incsearch " search from currently typed

" Colorschemes
colo Monokai
"colo vividchalk
"colo zenburn

" Tabulations
set noautoindent   " oh gosh, then who's responsible for
set nocindent      " indentation? I'll have to 
set nosmartindent  " check eventually
set indentexpr=    " it's related to automatic indentation, also for homework
set tabstop=4 " Tab width
set shiftwidth=4 " ???

" Mappings
let mapleader = "," " mapping namespace
 " editor movement
nnoremap <C-Down> 3j3<C-e>
nnoremap <C-Up> 3k3<C-y>
nnoremap <C-j> 3j3<C-e>
nnoremap <C-k> 3k3<C-y>
 " newline
nmap <CR> o<Esc>
 " replace/substitute operator remap
nnoremap R s
vnoremap R s
 " send d and x text to black hole
nnoremap d "_d
nnoremap dd "_dd
nnoremap D "_D
nnoremap x "_x
nnoremap X "_X
vnoremap d "_d
vnoremap D "_D
 " send y and p text to system's clipboard
nnoremap y "+y
nnoremap yy "+yy
nnoremap p "+p
nnoremap P "+P
vnoremap y "+y
vnoremap p "+p
vnoremap P "+P
 " new cut command (implemented with delete)
nnoremap s "+d
nnoremap ss "+dd
nnoremap S "+D
vnoremap s "+d
vnoremap S "+D
 " move lines (==, gv and gi are for reindentation)
nnoremap <S-j> :m .+1<CR>==
nnoremap <S-k> :m .-2<CR>==
inoremap <S-j> <Esc>:m .+1<CR>==gi
inoremap <S-k> <Esc>:m .-2<CR>==gi
vnoremap <S-j> :m '>+1<CR>gv=gv
vnoremap <S-k> :m '<-2<CR>gv=gv
nnoremap <S-Down> :m .+1<CR>==
nnoremap <S-Up> :m .-2<CR>==
inoremap <S-Down> <Esc>:m .+1<CR>==gi
inoremap <S-Up> <Esc>:m .-2<CR>==gi
vnoremap <S-Down> :m '>+1<CR>gv=gv
vnoremap <S-Up> :m '<-2<CR>gv=gv
 " execute within file
autocmd FileType python nnoremap <buffer> <F9> :!clear;python %<cr>
autocmd FileType c nnoremap <buffer> <F9> :!clear && gcc -std=c99 % && echo "Program Start:" && echo && ./a.out && echo && rm a.out <cr>
autocmd FileType cpp nnoremap <buffer> <F9> :!clear && g++ -std=c++11 -g -Wall % && echo "Program Start:" && echo && ./a.out && echo && rm a.out <cr>
autocmd FileType tex nnoremap <buffer> <F9> :!clear;pdflatex main.tex;evince main.pdf &<cr>

syntax on " so 'hightlight' works

" Misc
let delimitMate_expand_cr=1 " block macro
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o " ???
let g:tex_flavor = "latex" " to aid vim in .tex type recognition
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
  " transparent background
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
  highlight Statement ctermbg=none
endif


" To Investigate
" http://vim.wikia.com/wiki/Indenting_source_code
" https://blog.aaronbieber.com/2013/12/03/master-vim-registers-with-ctrl-r.html
" How do I abort the current command if I fucked up?
" Plugin 'christoomey/vim-run-interactive' for bash commands from vim
" Plugin 'pbrisbin/vim-mkdir' for creating directories
" Plugin 'vim-syntastic' for dark magic
" Plugin 'command-t' for more dark magic
" ctrl-o in insert mode enters normal mode for 1 command only
" Capslock and Escape can be exchanged via xmodmap
" nmap <S-CR> O<Esc> don't work
" map redo to S-u?
" avoiding esc inoremap <S-CR> <ESC> don't work
" research about how mapping works, what happens to original mappings, recursion, etc
