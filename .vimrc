set autoindent 
set backup
set backupdir=~/.vim/backup/
set clipboard=unnamed
set nocompatible
set directory=~/.vim/swap/
set incsearch
set number
set showmatch
set smarttab
set wildmenu wildmode=list:full
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh
nnoremap <ESC><ESC> :nohlsearch<CR>
syntax enable
if has('gui_running')
 set background=light
else
 set background=dark
endif
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT:%{&ff}]\ [TYPE:%Y]\ [POS:%l,%v](%p%%)

set t_Co=256
colorscheme molokai

if has('gui_running')
  nnoremap <C-Tab>   gt
  nnoremap <C-S-Tab> gT
endif

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

"罫線を引く
augroup cch
  autocmd! cch
	autocmd WinLeave * set nocursorline
	autocmd WinLeave * set nocursorcolumn
	autocmd WinEnter,BufRead * set cursorline
	autocmd WinEnter,BufRead * set cursorcolumn
augroup END

highlight CursorLine cterm=none ctermbg=black guibg=lightgray
highlight CursorColumn ctermbg=black guibg=lightgray

"vundle
filetype off
set rtp+=~/.vim/vundle.git/
call vundle#rc()
Bundle "git://github.com/scrooloose/nerdtree.git"
filetype plugin indent on "required!

