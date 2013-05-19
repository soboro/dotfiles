set autoindent 
set backup
set backupdir=~/.vim/backup/
set clipboard=unnamed
set nocompatible
set directory=~/.vim/swap/
set incsearch
set number
set showmatch
"set smarttab
set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
set grepprg=grep\ -nh
nnoremap <ESC><ESC> :nohlsearch<CR>
syntax enable
if has('gui_running')
 set background= light
else
 set background=dark
endif
set laststatus=2
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]

" 挿入モード時の色指定
" https://github.com/fuenor/vim-statusline/blob/master/insert-statusline.vim
if !exists('g:hi_insert')
  let g:hi_insert = 'highlight StatusLine guifg=White guibg=lightblue gui=none ctermfg=White ctermbg=lightblue cterm=none'
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

highlight CursorLine ctermbg=lightgray guibg=lightgray
highlight CursorColumn ctermbg=lightgray guibg=lightgray

