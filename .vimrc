set nocompatible
set modeline
set noswapfile

filetype plugin on

" Enable Solarized
if has("gui_running")
"	set background=dark
	set background=light
	syntax enable
	colorscheme solarized
else
	set background=dark
	syntax enable
endif
 
set titlestring=%F\ %m

" no bells!
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" bash-style filename completion
set wildmode=longest,list


" The semi-colon is magic, means search up, which is necessaryif autochdir is
" turned on.
"set autochdir
set tags=./tags;,./codex.tags;

set nowrap

" for use while editing Haskell files
if expand("%:e") == "hs"
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set autoindent
    set smartindent
    set nocindent
    set softtabstop=4

    " Per http://hackage.haskell.org/package/hothasktags
    set iskeyword=a-z,A-Z,_,.,39

    set textwidth=75
endif

" for use while editing C files
if expand("%:e") == "c"
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set autoindent
    set smartindent
    set nocindent
    set softtabstop=4
endif

" for use while editing text files
if expand("%:e") == "txt"
    set ts=4
    set expandtab
    set textwidth=78
endif

if expand("%:t") == "COMMIT_EDITMSG"
	set textwidth=70
	syn match commitComment "^#.*"
	hi link commitComment Comment
	set noautochdir
	go 1
endif

if expand("%:t") =~ "msg"
	set textwidth=70
	set filetype=none
	syn match commitComment "^#.*"
	hi link commitComment Comment
	set noautochdir
endif

let loaded_matchparen=1
set nohlsearch

if has("gui_running")
	set columns=90 lines=36 
	set number

" always show status line
"	set laststatus=2
endif

"set guifont=Inconsolata\ Medium\ 12
"set guifont=Inconsolata\ Medium\ 10
"set guifont=Inconsolata\ Medium\ 11
set guifont=DejaVu\ Sans\ Mono\ 10
set guicursor=a:block-blinkon0,i:ver10-blinkon0
set mouseshape=n:beam,ve:beam,sd:updown
" disable tearoff menus,toolbar
set guioptions-=tT
set guioptions-=m
set guioptions-=r


source $VIMRUNTIME/mswin.vim

highlight hsDelimiter guifg=#2aa198
highlight hsImportLabel gui=NONE guifg=#859900
highlight hsImportParams guifg=#657b83
highlight hsVarSym guifg=#2aa198
highlight VarId guifg=#657b83
highlight hsModuleName gui=NONE guifg=#2aa198
highlight hsPragma guifg=#6c71c4
highlight Comment gui=NONE
highlight hsLineComment gui=NONE
highlight hsBlockComment gui=NONE guifg=#cb4b16
highlight hs_hlFunctionName gui=NONE guifg=#268bd2
highlight hsString ctermfg=Blue cterm=bold gui=bold guifg=#586e75
highlight hsQQContent ctermfg=Blue cterm=bold gui=bold guifg=#586e75
highlight hsStatement gui=NONE guifg=#859900
highlight hsStructure gui=NONE guifg=#859900
highlight hsType gui=NONE
highlight hsConditional gui=NONE guifg=#859900
highlight hsCommentTodo term=bold ctermfg=0 ctermbg=11 gui=bold guifg=#d33682 guibg=yellow

highlight OverLength ctermbg=red ctermfg=white guifg=green guibg=#592929
"match OverLength /\%>80v.\+/

func! ToggleNumbering()
	if &number
		set nonumber
	else
		set number
	endif
endfunc

func! ToggleMenubar()
	if &guioptions =~ "m"
		set guioptions-=m
	else
		set guioptions+=m
	endif
endfunc

map <silent> <F2> :TOhtml<CR>
map <silent> <F8> :execute ToggleNumbering()<CR>
map <F9> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
"nnoremap <silent> <Plug>(CommandT) :CommandT<CR>
nmap <silent> <Leader>r :CommandTTag<CR>
nmap <silent> <Leader>f :CommandTMRU<CR>
nmap <silent> <Leader><Tab> :e #<CR>

" Make it so Ctrl+[ is the inverse of Ctrl+], going backward in the tag stack.

if has("gui_running")
	nmap <c-t> :CommandTTag<CR>
	nmap <a-Left> :pop 1<CR>
	nmap <a-Right> <c-]>
	nmap <C-PageUp> :bprevious<CR>
	nmap <C-PageDown> :bnext<CR>

	map <silent> <F12> :execute ToggleMenubar()<CR>

	nmap <C-S> :update<CR>

    " restore messed up search on Ctrl+F
    unmap <C-F>
endif

vmap < <gv
vmap > >gv
 
let g:gitgutter_sign_column_always = 1
"highlight SignColumn ctermfg=Grey guibg=#e5e5e5
"highlight SignColumn ctermbg=Black guibg=#ffffff
highlight SignColumn ctermbg=Black guibg=grey95
au FileType haskell map ff :%!stylish-haskell<CR> 
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.lo,*/dist/*,*.a
 
" dodge file reload warnings; do so automatically. Danger?
set autoread

"set runtimepath^=~/.vim/bundle/ctrlp.vim

let g:GPGExecutable='/usr/bin/gpg2'

set ignorecase
set smartcase
set hidden
