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
set nowrapscan " no file wrapping while searching

" Colorschemes
colo Monokai
"colo vividchalk
"colo zenburn

" Indentations
set noautoindent   " ??
set nocindent      " ?? 
set nosmartindent  " ??
set indentexpr=    " ??
set tabstop=4 " tab width
set shiftwidth=0 " autoindent width <<, >>, == (0 -> tabstop value)
set expandtab " tab as spaces
autocmd FileType ruby set tabstop=2
autocmd FileType python set tabstop=2

" Mappings
let mapleader = "," " mapping namespace
 " editor movement
nnoremap <C-Down> 3j3<C-e>
nnoremap <C-Up> 3k3<C-y>
nnoremap <C-j> 3j3<C-e>
nnoremap <C-k> 3k3<C-y>
 " newline
nnoremap <CR> o<Esc>
 " search shortcut (for some reason mapping * doesn't work)
nnoremap <kMultiply> *N
nnoremap # *N
 " ex commands
nnoremap º :
nnoremap ºw :w<CR>
nnoremap ºq :q<CR>
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
autocmd FileType ruby nnoremap <buffer> <F9> :!clear;ruby %<cr>
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
" basic toolbelt: r,ysp,hjkl,xd,uC-R,v,:eE,iIaAoO,bBwWeE

" 'fx','Fx','tX','TX' find and 'till motions
" 'c' for replacing
" 'A' for appending at the end of line
" 'I' for inserting at the beginning of the file
" '.' repeats last command
" '#gg' go to line #
" 'G' to go to last line
" 'gv' to reselect last block
" 'ctrl-o' and 'ctrl-i' to go back and forth between cursor positions
" 'ctrl-o' in insert mode allows a normal mode command

" 'ctrl-r ctrl-w' in command mode pastes the current word in the command line

" '%' for searching matching parentheses/braces/brackets
" '/' and '?' for searching patterns
"   - 'n/N' to move between apparitions
"   - 'gn' if an operator is pending, operates ONLY on the match
"     (without it visually selects the next match, but I don't care)
"  Replacement Options
"   1. ':.,$s/foo/bar/gc'
"   2. '*' then 'cgn' then 'bar<ESC>' then '.' ...
"   3. '*' then 'cw' then 'bar<ESC>' then 'n' then '.' ...
" '*' and '#' for searching words
" 'g*' and 'g#' for matching words

" ':s' search and replace
"  - 'g' flag allows multiple replaces in a single line
"  - 'c' flag asks for confirmation
"  - ranges: '%' all file, '.,$' from current line until the eof

" tip: an empty string will repeat a search pattern (?)
" tip: command + search pattern
" tip: command + count + motion

" Maps
" Commands are mapped, not keystrokes! It's misleading because that's what it looks
" like sometimes. For example, given the map 'h' -> 'y', pressing 'h' inmediatly sends
" an 'y', but this behaviour changes if there're other commands with the command
" mapped as a prefix. If the map were backwards, 'y' -> 'h', pressing 'y' gives you
" a window were an 'y' is on hold, and only after a while it registers as an 'h'
" Also, 'non-recursive' means that the definition is non-recursive, not something else

" To Investigate
" http://vim.wikia.com/wiki/Indenting_source_code
" https://blog.aaronbieber.com/2013/12/03/master-vim-registers-with-ctrl-r.html
" http://vim.wikia.com/wiki/Using_undo_branches Plugin 'command-t' for more dark magic
" Plugin 'christoomey/vim-run-interactive' for bash commands from vim
" Plugin 'pbrisbin/vim-mkdir' for creating directories
" Plugin 'vim-syntastic' for dark magic
" https://medium.com/@schtoeffel/you-don-t-need-more-than-one-cursor-in-vim-2c44117d51db
" map redo to S-u?
" add mapping to block indent in visual mode
" shift-move should retain vertical position :(
" g-move to duplicate lines (should retain vertical position)
" avoid 'vim' command opening non-text files/directories
