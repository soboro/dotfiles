"============================================================
" .vimrc
" auther : soboro
"============================================================

" Basic settings """"""""""""""""""""""""""""""""""""""""""""
set noautoindent
set nosmartindent
"set autoindent
"set smartindent

set backup
set backupdir=~/.vim/backup/
set clipboard=unnamed
set nocompatible
set directory=~/.vim/swap/
set undodir=~/.vim/undo

set incsearch
set hlsearch

set showmatch
set matchtime=1

set noexpandtab
set tabstop=4
set shiftwidth=4
set softtabstop=0

set number
set textwidth=0
set wildmenu wildmode=list:full
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh

" status line
set laststatus=2
set statusline=""
set statusline+=\ [line:%l\ /\ %L]
set statusline+=\ %F
set statusline+=\ %h\ r\ %w\ %m
set statusline+=%=
set statusline+=%y
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).'/'.&ff.']'}

set t_Co=256

set list
set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

"Cursor shape
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

syntax enable
filetype plugin indent on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Key maps """""""""""""""""""""""""""""""""""""""""""""""""

"<ESC>2回で検索結果のクリア
nnoremap <ESC><ESC> :nohlsearch<CR>

"タブの移動
nnoremap <C-Tab>   gt
nnoremap <C-S-Tab> gT

"xでの削除をレジスタに入れない
nnoremap x "_x

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Color settings """""""""""""""""""""""""""""""""""""""""""

" color scheme
"colorscheme hybrid

" 挿入モード時の色指定
" https://github.com/fuenor/vim-statusline/blob/master/insert-statusline.vim
if !exists('g:hi_insert')
	let g:hi_insert = 'highlight StatusLine guifg=White guibg=#F92672 gui=none ctermfg=White ctermbg=darkmagenta cterm=none'
endif

if has('unix') && !has('gui_running')
	inoremap <silent> <ESC> <ESC>
	inoremap <silent> <C-[> <ESC>
endif

if has('syntax')
	augroup InsertHook
		autocmd!
		autocmd InsertEnter * call s:StatusLine('Enter')
		autocmd InsertLeave * call s:StatusLine('Leave')
	augroup END
endif

let s:slhlcmd = ''

function! s:StatusLine(mode)
	if a:mode == 'Enter'
		silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
		silent exec g:hi_insert
	else
		highlight clear StatusLine
		silent exec s:slhlcmd
	endif
endfunction

function! s:GetHighlight(hi)
	redir => hl
	exec 'highlight '.a:hi
	redir END
	let hl = substitute(hl, '[\r\n]', '', 'g')
	let hl = substitute(hl, 'xxx', '', '')
	return hl
endfunction

" カーソル行のハイライト設定

set cursorline

augroup cch
	autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END

hi clear CursorLine
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
highlight CursorLine gui=underline guifg=NONE guibg=NONE

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" auto complete
set completeopt=menuone
for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
	  exec "imap " . k . " " . k . "<C-N><C-P>"
endfor
imap <expr> <TAB> pumvisible() ? "\<Down>" : "\<Tab>"

" like XCode
"hi Pmenu ctermbg=250
"hi Pmenu ctermfg=233
"hi PmenuSel ctermbg=26
"hi PmenuSel ctermfg=252

" Dark-Orange
hi Pmenu ctermbg=234
hi Pmenu ctermfg=39
hi PmenuSel ctermbg=130
hi PmenuSel ctermfg=252

hi PmenuSbar ctermbg=2
hi PmenuThum ctermbg=3

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
