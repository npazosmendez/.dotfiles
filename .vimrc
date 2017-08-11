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
set showcmd " display incomplete commands
set ruler " show cursor position
set wrap lbr " line wrap by words
set breakindent " indents line wraps
set breakindentopt=shift:1 " extra indent on line wraps
set virtualedit=block " allow cursor anywhere in block vmode
set incsearch " search from currently typed
set noswapfile " what it says on the tin

" Colorschemes
colo Monokai
"colo vividchalk
"colo zenburn

" Tabulations
set noautoindent   " oh gosh, then who's responsible for
set nocindent      "  indentation? I'll have to check eventually 
set nosmartindent
set indentexpr=    " it's related to automatic indentation, also for homework
set tabstop=4 " tab width
set shiftwidth=4 " ???
set expandtab " tab as spaces

" Mappings
let mapleader = "," " mapping namespace
 " editor movement
nnoremap <C-Down> 3j3<C-e>
nnoremap <C-Up> 3k3<C-y>
nnoremap <C-j> 3j3<C-e>
nnoremap <C-k> 3k3<C-y>
 " newline
nmap <CR> o<Esc>
 " ex command prefix
nnoremap º :
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
vnoremap <S-j> :m '>+1<CR>gv=gv
vnoremap <S-k> :m '<-2<CR>gv=gv
nnoremap <S-Down> :m .+1<CR>==
nnoremap <S-Up> :m .-2<CR>==
vnoremap <S-Down> :m '>+1<CR>gv=gv
vnoremap <S-Up> :m '<-2<CR>gv=gv
 " visually moving through line wraps
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
 " execute within file
autocmd FileType python nnoremap <buffer> <F9> :!clear;python %<cr>
autocmd FileType c nnoremap <buffer> <F9> :!clear && gcc -std=c99 % && echo "Program Start:" && echo && ./a.out && echo && rm a.out <cr>
autocmd FileType cpp nnoremap <buffer> <F9> :!clear && g++ -std=c++11 -g -Wall % && echo "Program Start:" && echo && ./a.out && echo && rm a.out <cr>
autocmd FileType tex nnoremap <buffer> <F9> :!clear;pdflatex main.tex;okular main.pdf &<cr>

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

" Learning
" basic toolbelt: r,ysp,hjkl,xd,uC-R,ia,v,:eE
" 'fx','Fx','tX','TX' find and 'till motions
" 'c' for replacing
" 'r' for replacing a character
" 'A' for appending at the end of line
" 'I' for inserting at the beginning of the file
" '%' for searching matching parentheses/braces/brackets
" '/' and '?' for searching patterns
" '*' and '#' for searching words
" 'g*' and 'g#' for matching words
" '#gg' go to line #
" 'G' to go to last line
" 'gv' to reselect last block
" 'ctrl-o' in insert mode allows a normal mode command
" 'ctrl-o' and 'ctrl-i' to go back and forth between cursor positions
" ':s' search and replace
"  - 'g' flag allows multiple replaces in a single line
"  - 'c' flag asks for confirmation
"  - ranges: '%' all file, '.,$' from current line until the eof
" tip: command + search pattern
" tip: an empty string will repeat a search pattern

" To Investigate
" http://vim.wikia.com/wiki/Indenting_source_code
" https://blog.aaronbieber.com/2013/12/03/master-vim-registers-with-ctrl-r.html
" http://vim.wikia.com/wiki/Using_undo_branches Plugin 'command-t' for more dark magic
" Plugin 'christoomey/vim-run-interactive' for bash commands from vim
" Plugin 'pbrisbin/vim-mkdir' for creating directories
" Plugin 'vim-syntastic' for dark magic
" nmap <S-CR> O<Esc> don't work
" map redo to S-u?
" avoiding esc inoremap <S-CR> <ESC> don't work
" research about how mapping works, what happens to original mappings, recursion, etc
" add mapping to block indent in visual mode
" shift-arrow keys moves cursor to the beginning :(
" search in delimitMate how to move to closest opening/closing braces
