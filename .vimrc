syntax on
set nocompatible
set ai
set backspace=indent,eol,start
set history=50
set background=dark
set showcmd
set incsearch
set hlsearch
set number
set cindent
set smartcase
set autowrite
set showbreak=\ \ \>>\ 
set breakindent
set fileformat=unix
set encoding=utf-8
set noequalalways

set expandtab
set tabstop     =4
set softtabstop =4
set shiftwidth  =4
set scrolloff   =4

set cursorline

set foldenable
set foldmethod=syntax
set foldlevel=99
set foldcolumn=1

set backupdir=~/.vim_backup,.
set directory=~/.vim_backup,.

set cscopequickfix=s-,c-,d-,i-,t-,e-,a-

set listchars=eol:⏎,tab:>-,trail:.,nbsp:.
hi NonText ctermfg=black guifg=black


"                   === MOVEMENT MACROS === 

nnoremap h <C-w>h
nnoremap j <C-w>j
nnoremap k <C-w>k
nnoremap l <C-w>l

"change tabs
nnoremap H gT
nnoremap L gt

nmap - /
nmap _ ?
vmap - /
vmap _ ?
nmap c- c/

"move to next/previous function
map [[ ?{<CR>w99[{
map ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

nnoremap H g^
nnoremap L g$
vnoremap H g^
vnoremap L g$

nnoremap K {
nnoremap J }
vnoremap K {
vnoremap J }

nnoremap ; g;

nnoremap j gj
nnoremap k gk

map <ScrollWheelUp> <C-Y><C-Y>
map <ScrollWheelDown> <C-E><C-E>

"                   === EDITING MACROS ===

inoremap jk <Esc>
inoremap kj <Esc>

inoremap JK <Esc>

nnoremap <space> za

noremap p ]p
nnoremap P [p

nnoremap ,p "+]p
nnoremap ,P "+]P

inoremap {<CR> {<CR><CR>}<ESC>kcc

nnoremap U <C-R>
nnoremap ,s :w<CR>
nnoremap ,q :wq<CR>
nnoremap ,Q :q!<CR>

nnoremap q/ q/i

"                   === COMMAND MACROS ===

cmap w!! w !sudo tee > /dev/null %

nnoremap gv `[v`]

nnoremap ,W :%s/\s\+$//<cr>:let @/=''<CR>

iab <expr> dts strftime("%c")
iab <expr> todo "// TODO ".strftime('%Y/%m/%d %H:%M')." - "

nnoremap ,v :vs $MYVIMRC<CR>

"execute command
nnoremap ,p 0ik:r!<ESC>"cdd@c 

"ctags
nnoremap <C-\> <C-w>}
"cscope
nnoremap ,u yiw:cs find s <C-R>0<CR>:copen<CR>

nnoremap <c-l> :nohl<cr><c-l>

"close quickfix window
nnoremap ,x :ccl<CR>

"                   === AUTO COMMANDS ===

"auto reload vim_rc
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

"auto reload folds
autocmd BufWinLeave *.* mkview!
autocmd BufWinEnter *.* silent loadview

"                   === PLUGIN LIST ===

"ATTENZIONE! Needs plugin vim-plug
call plug#begin('~/.vim/bundle')
Plug 'godlygeek/csapprox'
Plug 'flazz/vim-colorschemes'
Plug 'jnurmine/Zenburn'
Plug 'altercation/vim-colors-solarized'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'ervandew/supertab'
Plug 'airblade/vim-rooter'
Plug 'takac/vim-hardtime'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'rhysd/clever-f.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'EinfachToll/DidYouMean'
Plug 'Konfekt/FastFold'
Plug 'mileszs/ack.vim'
Plug 'Shougo/neocomplete.vim'
Plug 'chrisbra/histwin.vim'
Plug 'matze/vim-move'

Plug 'xuhdev/vim-latex-live-preview'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"
Plug 'xolox/vim-misc'

"Plug 'metakirby5/codi.vim'
"Plug 'xolox/vim-colorscheme-switcher'
"Plug 'wkentaro/conque.vim' 
"Plug 'vim-scripts/Gundo'
"Plug 'scrooloose/syntastic'
"Plug 'artur-shaik/vim-javacomplete2'
"Plug 'mbbill/undotree'
"Plug 'itchyny/lightline.vim'
"Plug 'tmhedberg/SimpylFold'
"Plug 'vim-scripts/indentpython.vim'
"Plug 'hdima/python-syntax'
call plug#end()

"                   === PLUGIN OPTIONS ===

let g:airline_theme = "zenburn"
let g:move_key_modifier = 'C'
let g:JavaComplete_SourcesPath = "~/progetti/silvestri/java-project/gapp"
let g:syntastic_mode_map = {"mode": "passive","active_filetypes": [],"passive_filetypes":[]}
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:fzf_action = {'ctrl-t': 'tab split','ctrl-x': 'split','ctrl-v': 'vsplit' }
let g:ackprg = 'ag --vimgrep --smart-case'
let g:ack_use_cword_for_empty_search = 1
let g:livepreview_previewer='zathura'
let g:livepreview_engine='xelatex'
let python_highlight_all=1
"supertab
set completeopt=menuone,preview

colorscheme alduin
"colorscheme Dev_Delight

"                   === PLUGIN MACROS ===

nnoremap ,n :NERDTreeToggle<Enter>
nnoremap ,t :TagbarToggle<Enter>

nnoremap ,T  : Tabularize /=<CR>
vnoremap ,T  : Tabularize /=<CR>
nnoremap ,,T : Tabularize /=/r1c1r0<CR>
vnoremap ,,T : Tabularize /=/r1c1r0<CR>

nnoremap ,g :GundoToggle<CR>

"nerdcommenter
nmap ,e  <Leader>c<Space>
vmap ,e <Leader>c<Space>
nmap ,cc <Leader>c<Space>
nmap ,cm <Leader>cm
nmap ,cs <Leader>cs
vmap ,cc <Leader>c<Space>
vmap ,cm <Leader>cm
vmap ,cs <Leader>cs
vmap ,C <Leader>c<Space>

nnoremap ,w :AckWindow!<Space>
nnoremap ,f :Ack!<Space>



"                   === FILETYPE SETTINGS ===

autocmd filetype c call SettingsC()
autocmd filetype cpp call SettingsCpp()
autocmd filetype java call SettingsJava()
autocmd filetype python call SettingsPython()
autocmd filetype tex call SettingsLatex()

autocmd BufNewFile *.cpp r ~/.vim/usaco_template.cpp

function! SettingsC()
    nnoremap <F4> :wa <CR> :!g++ % -o comp_%:r ;  ./comp_%:r <CR>
endfunction

function! SettingsCpp()
    nnoremap <F5> :wa <CR> :!g++ % -o comp_%:r ;  ./comp_%:r <CR>
    nnoremap <F4> :wa <CR> :!g++ % -o comp_%:r ;  ./comp_%:r < input.txt <CR>
    "nnoremap <F6> :wa <CR> :!make;  cygstart ./run <CR>

    abbr vi vector<int>
    abbr vvi vector<vector<int> >
    abbr fori for(int i = 0; i < n; i++) {<CR>
endfunction

function! SettingsJava()
    "autocmd FileType java setlocal omnifunc=javacomplete#Complete
    "autocmd filetype Java set completefunc=javacomplete#CompleteParamsInfo
    abbr print System.out.println();<Esc>hh
    "//	nnoremap <F4> :wa <CR> :!/c/progetti/android/LOL/build.sh; /c/progetti/android/LOL/run.sh <CR>
    "nnoremap <F5> :wa <CR> :!/c/progetti/android/RajawaliVRCardboard/build_and_run.sh <CR>

    nnoremap <F4> :wa <CR> :!javac %; java Main < input.txt <CR>
    nnoremap <F5> :wa <CR> :!javac %; java %:r <CR>
    "setlocal omnifunc=javacomplete#Complete
    "set makeprg=javac\ -d\ \~\/comp\ $(find\ gapp\ -name\ \"\*\.java\"\)
    set makeprg=javac\ -d\ \~\/comp\ $(find\ -name\ \"\*\.java\"\)
    "cp -r resources/* ~/comp/resources/; javac -d ~/comp (find gapp -name "*.java"); java -cp ~/comp gapp.ulg.test.slideNewTry
    set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
    map <F9>  <Esc>:silent :make<Return>:copen<Return><C-l>
    map <F10> <Esc>:cprevious<Return>
    map <F11> <Esc>:cnext<Return>
    map <F12> <Esc>:silent :!java -cp ~/comp gapp.ulg.test.slideNewTry<CR>
endfunction

function! SettingsPython()
    nnoremap <F4> :wa <CR> :!python % <CR>
    nnoremap <F5> :wa <CR> :!python % <CR>
endfunction

function! SettingsLatex()
    nnoremap <F4> :wa <CR> :!xelatex --shell-escape % <CR>
    nnoremap <F5> :wa <CR> :!zathura %:r.pdf <CR>
    setlocal nocursorline
    set foldmethod=manual
    set regexpengine=1
    syn sync minlines=10
    syn sync maxlines=50
    :NoMatchParen
    setlocal updatetime=1000
endfunction