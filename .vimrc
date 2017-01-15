"============================================================
" .vimrc
" auther : soboro
"============================================================

" Basic settings """"""""""""""""""""""""""""""""""""""""""""

set backup
set backupdir=~/.vim/backup/
"set clipboard=unnamed
set nocompatible
set directory=~/.vim/swap/
set undodir=~/.vim/undo

set incsearch
set hlsearch

set showmatch
set matchtime=1

set noautoindent
set nosmartindent
filetype plugin indent on

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

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

" Common Key Maps """""""""""""""""""""""""""""""""""""""""""""""""

" remap <ESC>
noremap! <C-j> <ESC>
noremap <C-j> <ESC>

"<ESC>2回で検索結果のクリア
nnoremap <ESC><ESC> :nohlsearch<CR>

"タブの移動
nnoremap <C-Tab>   gt
nnoremap <C-S-Tab> gT

"xでの削除をレジスタに入れない
nnoremap x "_x

inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [ []<Left>
inoremap { {}<Left>
inoremap ( ()<Left>
inoremap ' ''<Left>
inoremap " ""<Left>

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
""set completeopt=menuone
""for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
""    exec "imap " . k . " " . k . "<C-N><C-P>"
""endfor
""imap <expr> <TAB> pumvisible() ? "\<Down>" : "\<Tab>"

" like XCode
"hi Pmenu ctermbg=250
"hi Pmenu ctermfg=233
"hi PmenuSel ctermbg=26
"hi PmenuSel ctermfg=252

" Dark-Orange
""hi Pmenu ctermbg=234
""hi Pmenu ctermfg=39
""hi PmenuSel ctermbg=130
""hi PmenuSel ctermfg=252
""
""hi PmenuSbar ctermbg=2
""hi PmenuThum ctermbg=3

" plug-in settings """"""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" dein ""
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !=# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute 'git clone https://github.com/Shougo/dein.vim.git' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let g:rc_dir = expand('~/.vim/dein')
    let s:toml = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
    
    call dein#load_toml(s:toml, {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

if dein#check_install()
    call dein#install()
endif

"" neocomplcache ""
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 1
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
      return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplete#sources#rsense#home_directory = '~/.rbenv/shims/rsense'

"" NERDTree
function s:MoveToFileAtOpen()
    call feedkeys("\<C-w>")
    call feedkeys("\l")
endfunction
autocmd VimEnter * execute 'NERDTree' | call s:MoveToFileAtOpen()
""autocmd BufEnter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden = 1
map <C-e> :NERDTreeToggle<CR>

"" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    "" for issue syntax be disabled when it wtitten before dein settings
syntax enable

