set ts=4
"set textwidth=80
syntax on
colorscheme slate

set expandtab
set nocompatible
set ruler
"set term=builtin_ansi
set autoindent		" always set autoindenting on
set showmatch
set nohls	 				" no highlight search
set nonu
" set tags=tags;/ 
" let Grep_Skip_Files = '.#* ~* tags *.bak *.jpg *.log' 

set backupdir=/tmp
set directory=/tmp
set errorfile=/tmp/alex.errors.log
set fileformats=unix,mac,dos
set number

if has("autocmd")
  " Enable filetype detection
  filetype plugin indent on
  set ofu=syntaxcomplete#Complete
 
  " Restore cursor position for irb vim
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

" MiniBufExplorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" TagList
map P :TlistToggle<CR>
let g:tlist_javascript_settings = 'javascript;s:string;a:array;o:object;f:function'

" FuzzyFinder
map ff :FufFile **/<CR>

cmap js :call JavascriptLint()<CR>
