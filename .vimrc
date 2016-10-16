"============================================================
" .vimrc
" auther : soboro
"============================================================

" Basic settings """"""""""""""""""""""""""""""""""""""""""""

set autoindent 
set backup
set backupdir=~/.vim/backup/
set clipboard=unnamed
set nocompatible
set directory=~/.vim/swap/

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
colorscheme hybrid

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

" NeoBundle """""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
filetype off

set rtp+=~/.vim/neobundle.vim.git
if has('vim_starting')
	set runtimepath+=~/.vim/neobundle.vim.git
	call neobundle#rc(expand('~/.vim/bundle'))
endif

" Bundles
NeoBundle 'scrooloose/nerdtree'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Load additional files """"""""""""""""""""""""""""""""""""

if filereadable(expand('~/.vimrc.local'))
	source ~/.vimrc.local
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTree """""""""""""""""""""""""""""""""""""""""""""""""

"起動時にファイルの指定がなければNERDTreeを実行
let file_name=expand("%")
if has('vim_starting') && file_name==""
	autocmd VimEnter * NERDTree ./
endif

" カーソルが外れているときは自動的にnerdtreeを隠す
function! ExecuteNERDTree()
	"b:nerdstatus = 1 : NERDTree 表示中
	"b:nerdstatus = 2 : NERDTree 非表示中
 
	if !exists('g:nerdstatus')
		execute 'NERDTree ./'
		let g:windowWidth = winwidth(winnr())
		let g:nerdtreebuf = bufnr('')
		let g:nerdstatus = 1 
 
	elseif g:nerdstatus == 1 
		execute 'wincmd t'
		execute 'vertical resize' 0 
		execute 'wincmd p'
		let g:nerdstatus = 2 
	elseif g:nerdstatus == 2 
		execute 'wincmd t'
		execute 'vertical resize' g:windowWidth
		let g:nerdstatus = 1 
 
	endif
endfunction

" 隠しファイルを表示
let g:NERDTreeShowHidden = 1
noremap <c-e> :<c-u>:call ExecuteNERDTree()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

