
set nocompatible               " be iMproved
filetype off                   " required!

"// --- vim-plug --- //
call plug#begin('~/.vim/plugged')

Plug 'Townk/vim-autoclose'
Plug 'Valloric/YouCompleteMe', { 'do': 'sudo ./install.py --gocode-completer' }
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-system-copy'
Plug 'christoomey/vim-tmux-navigator'
Plug 'derekwyatt/vim-scala'
Plug 'elzr/vim-json'
Plug 'fatih/molokai'
Plug 'fatih/vim-go'
Plug 'fholgado/minibufexpl.vim'
Plug 'godlygeek/tabular'
Plug 'haya14busa/incsearch.vim'
Plug 'junegunn/seoul256.vim'
Plug 'kien/ctrlp.vim'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'moll/vim-node'
Plug 'othree/javascript-libraries-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'plasticboy/vim-markdown'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'stephpy/vim-yaml'
Plug 'ternjs/tern_for_vim'
Plug 'tfnico/vim-gradle'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

call plug#end()

"// --- General --- //
syntax on
filetype plugin indent on
filetype plugin on

set autoindent
set autoread
set confirm
set hidden
set hlsearch
set ignorecase
set modeline
set nobackup
set nocompatible
set nofoldenable
set noswapfile
set showcmd
set smartcase
set smartindent
set splitright
set visualbell
set noerrorbells

set backspace=2
set encoding=utf-8
set fileencodings=utf-8,cp950
set history=1000
set ls=2
set pastetoggle=<F2>
set scrolloff=999 " keep cursor at center when page up/down
set shiftwidth=4
set tabstop=4
"set expandtab
set timeoutlen=500
set ttimeoutlen=0
set clipboard=unnamed

autocmd Filetype gitcommit setlocal spell textwidth=72 " git commit format check

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif
" :~)

"// --- Appearance --- //
set t_Co=256
set background=dark
colorscheme Tomorrow-Night
" colorscheme github
highlight Normal ctermbg=NONE
highlight nonText ctermbg=NONE


let g:seoul256_background = 233
let python_highlight_all=1
"set cursorline			"cursor highlight
set t_Co=256


" status line appearance
set statusline=%1*%F\ %*                        " filepath
set statusline+=[%{strlen(&fenc)?&fenc:'none'}, " file encoding
set statusline+=%{&ff}]                         " file format
set statusline+=%h                              " help file flag
set statusline+=%m                              " modified flag
set statusline+=%r                              " read only flag
set statusline+=%y                              " filetype
set statusline+=%=                              " left/right separator
set statusline+=%c,                             " cursor column
set statusline+=%l/%L                           " cursor line/total lines
set statusline+=\ %P                            " percent through file
set statusline+=\ %o                            " bytes offset

hi User1 ctermfg=blue ctermbg=black
hi User2 ctermfg=red  ctermbg=black
" :~)


"// ---  Keys Mapping --- //
let mapleader = " "

" Visual selection hotkey
nmap <Leader><Leader> V

" Ag search
let g:ag_prg="ag --word-regexp --vimgrep --smart-case"
let g:ag_highlight=1
nmap <leader>a :Ag<cr>

" Save file
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Let pointer stay after visual block yanking
:vmap y ygv<Esc>

" Disable direction key
:imap jk   <C-C>
:noremap   <up>     <nop>
:noremap   <down>   <nop>
:noremap   <left>   <nop>
:noremap   <right>  <nop>

" Keep line in center
nmap <space> zz
nmap n nzz
nmap N Nzz

" Split window
nnoremap <silent> vv <C-w>v
nnoremap <silent> ss <C-w>s

" Insert blank line without into insert mode
map <S-Enter> O<Esc>
map <CR> o<Esc>

" Paste without explicitly turning paste mode on/off
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" Copy/Paste cross session
" How: 'Ctrl+V' select the rows you want to copy, 'Shift+Y' copy, jump to anthoer buffer, 'Shift+P' paste
" *** ------------------------ ***
" copy the current visual selection to ~/.vbuf
vmap <S-y> :w! ~/.vbuf<CR>
" copy the current line to the buffer file if no visual selection
nmap <S-y> :.w! ~/.vbuf<CR>
" paste the contents of the buffer file
nmap <S-p> :r ~/.vbuf<CR>

" Mark redundant spaces
" How: 'F3' mark redundant spaces, 'N' to search next
" <leader>+w to remove all trailing space
" *** --------------------- ***
function ShowSpaces(...)
	let @/='\v(\s+$)|( +\ze\t)'
	let oldhlsearch=&hlsearch
	if !a:0
	let &hlsearch=!&hlsearch
	else
	let &hlsearch=a:1
	end
	return oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
nnoremap <F3>     :ShowSpaces 1<CR>

func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
noremap <leader>w :call DeleteTrailingWS()<CR>

" Show function name
" How: '<leader>+,' shows function name
" *** ------------------ ***
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map f :call ShowFuncName() <CR>
" :~)

" Toggle wrap line
" highlight OverLength ctermbg=red ctermfg=white guibg=#592929
" match OverLength /\%101v.\+/

"// === Plugins Start === //

" --- YouCompleteMe ---
let g:ycm_min_num_of_chars_for_completion = 3
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_complete_in_comments = 1
let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']

set completefunc=youcompleteme#Complete
set completeopt=preview,longest,menuone

" --- tern_for_vim ---
let g:tern_show_argument_hints='on_hold'
let g:tern_map_keys = 1

" --- incsearch.vim ---
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" --- Vim indent guide plugin ---
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" --- Ctags plugin ---
set tags=tags;/
" configure tags - add additional tags here
set tags+=~/.vim/tags/cpp
" build tags of your own project with Ctrl-L
function! UpdateTags()
    execute ":!ctags -R --languages=C++ --c++-kinds=+p --fields=+iaS --extra=+q ./"
    echohl StatusLine | echo "C/C++ tag updated" | echohl None
endfunction
"nnoremap <C-L> :call UpdateTags()))

" --- Taglist plugin ---
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window   = 1
nnoremap <silent> <F6> :TlistToggle<CR>

" --- vim-go plugin ---
let g:go_highlight_interfaces = 1
let g:go_highlight_structs = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_build_constraints = 1
let g:go_auto_sameids = 1
let g:go_def_mapping_enabled = 0 " //for speed, use tags
let g:go_fmt_command = "goimports"
let g:go_guru_scope = ["straas.io/..."]
au FileType go nmap <leader>b <Plug>(go-install)
au FileType go nmap <C-I> <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)
au FileType go nmap <Leader>l <Plug>(go-metalinter)
au FileType go nmap <C-]> <Plug>(go-def)
au FileType go nmap <C-t> <Plug>(go-def-pop)
au FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <Leader>ip <Plug>(go-implements)
au FileType go nmap <leader>t <Plug>(go-alternate-edit)

" --- Tagbar plugin ---
nmap <F8> :TagbarToggle<CR>

" --- NERDTree plugin ---
map <leader>r :NERDTreeFind<cr>
nmap <silent> <C-N> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "left"
let NERDTreeIgnore = ['cscope\.*', '\.*temp\.*']

" --- fugitive plugin ---
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>

" --- Ack plugin ---
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" --- MiniBufExplorer plugin ---
function! <SID>CycleBuffer(forward)

" The following hack handles the case where we only have one
" window open and it is too small
if (winbufnr(2) == -1)
resize
endif

" Change buffer (keeping track of before and after buffers)
let l:origBuf = bufnr('%')
if (a:forward == 1)
	bn!
else
	bp!
endif
let l:curBuf  = bufnr('%')

" Skip any non-modifiable buffers, but don't cycle forever
" This should stop us from stopping in any of the [Explorers]
while getbufvar(l:curBuf, '&modifiable') == 0 && l:origBuf != l:curBuf
if (a:forward == 1)
	bn!
else
bp!
endif
let l:curBuf = bufnr('%')
endwhile

endfunction

" switching to buffer 1 - 9 is mapped to ,[nOfBuffer]
for buffer_no in range(1, 9)
  execute "nmap <Leader>" . buffer_no . " :b" . buffer_no . "\<CR>"
endfor

noremap <silent> <leader>n :call <SID>CycleBuffer(1)<CR>:<BS>
noremap <silent> <leader>p :call <SID>CycleBuffer(0)<CR>:<BS>

" --- Ctrlp plugin ---
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*/bin/*,*/target/*,*.so,*.swp,*.zip,*/Godeps/*,*/vendor/*     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows  "
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|Godeps\|vendor\|tmp$',
	\ 'file': '\v\.(exe|so|dll|class|a)$',
	\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
	\ }

let g:ctrlp_max_files = 1000000 " 加大 cache 索引的檔案數, 否則會漏找檔案

" Make CtrlP faster
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
let g:ctrlp_use_caching = 0


" --- Vimwiki plugin ---
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/',
			\'template_path': '~/Dropbox/vimwiki/template/',
			\'template_default': 'default',
			\'template_ext': '.html',
			\'path_html': '~/Dropbox/repo/vimwiki/'}]

" 對中文用戶來說，我們並不怎麼需要駝峰英文成為維基詞條
let g:vimwiki_camel_case = 0
" 標記為完成的 checklist 項目會有特別的顏色
let g:vimwiki_hl_cb_checked = 1
" 我的 vim 是沒有菜單的，加一個 vimwiki 菜單項也沒有意義
let g:vimwiki_menu = ''
" 是否開啟按語法折疊  會讓文件比較慢
let g:vimwiki_folding = 1
" 是否在計算字串長度時用特別考慮中文字符
let g:vimwiki_CJK_length = 1
" 支援html標記符
let g:vimwiki_valid_html_tags='b,i,s,u,sub,sup,kbd,del,br,hr,div,code,h1,pre'

map <F4> :VimwikiAll2HTML<cr>
"map <F4> :Vimwiki2HTML<cr>

" --- Markdown to HTML ---
nmap <leader>q :%!/Users/brownylin/Dropbox/Markdown.pl --html4tags <cr>

" --- CSCOPE plugin ---
" 讓子目錄也可以利用根目錄建構出的 cscope.out 檔案
function s:FindFile(file)
    let curdir = getcwd()
    let found = curdir
    while !filereadable(a:file) && found != "/"
        cd ..
        let found = getcwd()
    endwhile
    execute "cd " . curdir
    return found
endfunction

if has("cscope")

    " use both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
    set cscopetag

    " check cscope for definition of a symbol before checking ctags: set to 1
    " if you want the reverse search order.
    set csto=0

    " add any cscope database in current directory
    let $CSCOPE_DIR=s:FindFile("cscope.out")
    let $CSCOPE_DB=$CSCOPE_DIR."/cscope.out"
    if filereadable($CSCOPE_DB)
        cscope add $CSCOPE_DB $CSCOPE_DIR
    endif

    command -nargs=0 Cscope !cscope -ub -R &
    " show msg when any other cscope db added
    set cscopeverbose

    " disable autocscope auto mappings
    let g:autocscope_menus = 0

    """"""""""""" cscope/vim key mappings
    "
    " The following maps all invoke one of the following cscope search types:
    "
    "   's'   symbol: find all references to the token under cursor
    "   'g'   global: find global definition(s) of the token under cursor
    "   'c'   calls:  find all calls to the function name under cursor
    "   't'   text:   find all instances of the text under cursor
    "   'e'   egrep:  egrep search for the word under cursor
    "   'f'   file:   open the filename under cursor
    "   'i'   includes: find files that include the filename under cursor
    "   'd'   called: find functions that function under cursor calls

    nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>

    nmap <C-w>s :scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-w>g :scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-w>c :scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-w>t :scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-w>e :scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-w>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-w>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-w>d :scs find d <C-R>=expand("<cword>")<CR><CR>

    nmap <C-w><C-w>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <C-w><C-w>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <C-w><C-w>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <C-w><C-w>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <C-w><C-w>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <C-w><C-w>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <C-w><C-w>i :vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <C-w><C-w>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

endif
" :~)

" --- gotags for tagbar ---
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
" :~)

" --- golint ---
set rtp+=/Users/brownylin/Dropbox/livehouse/Go/ext/src/github.com/golang/lint/misc/vim
