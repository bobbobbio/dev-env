" Set shell to bash
set shell=/bin/bash

" Don't use swapfiles
set noswapfile

" Automatically reread a file when vim detects it has changed, and your buffer
" has no changes.
set autoread

syntax on
set backspace=2

" Mouse
set mouse=a
" sgr is way better. You can use the mouse on large ( > 256 ) screens and can
" resize splits just fine.
set ttymouse=sgr

" Hide toolbar / menubar in GUI mode
" set guioptions -=T
" set guioptions -=m

" whitespace
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/

" Color and syntax hilighting stuff
set t_Co=256
" colorscheme koehler
colorscheme catppuccin_frappe
hi Repeat guifg=#00ccff ctermfg=blue
hi Label guifg=#cc8800 ctermfg=red
hi Conditional guifg=#D663EB ctermfg=red
au BufRead,BufNewFile *.x set filetype=x
hi TabLine ctermfg=white ctermbg=black
hi TabLineFill ctermfg=white ctermbg=black
hi TabLineSel ctermfg=black ctermbg=white
hi Pmenu ctermbg=gray
hi StatusLine ctermfg=white ctermbg=black

" Show path autocompletes
set wildmenu

" Don't have an annoying delay after hitting escape
set timeoutlen=1000 ttimeoutlen=0

" Vundle setup
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

"" Advanced file system explorer
Plugin 'scrooloose/nerdtree'
" Fancy vim status bar!
" Plugin 'bling/vim-airline'
Plugin 'itchyny/lightline.vim'
" Tree based undo
Plugin 'sjl/gundo.vim'
" Switch between header / source files quickly
Plugin 'dantler/vim-alternate'
" Dispatch
Plugin 'tpope/vim-dispatch'
" Mercurial wrapper
Plugin 'phleet/vim-mercenary'
" silver searcher
" Plugin 'rking/ag.vim'
" search for files easily
" Plugin 'kien/ctrlp.vim'
" Workspace, tab, and buffer management
Plugin 'szw/vim-ctrlspace'
" Switch to test file from c/h file
Plugin 'shrinidhisondur/qtest.vim'
" Easily navigate buffers
" Bundle 'jlanzarotta/bufexplorer'
" Rust syntax-highlighting
Plugin 'rust-lang/rust.vim'
Plugin 'prabirshrestha/vim-lsp'
" open scad coloring
Plugin 'sirtaj/vim-openscad'
" rip-grep plugin
Plugin 'jremmen/vim-ripgrep'

" For vim-lsp Rust support
if executable('rust-analyzer')
  au User lsp_setup call lsp#register_server({
        \   'name': 'Rust Language Server',
        \   'cmd': {server_info->['rust-analyzer']},
        \   'whitelist': ['rust'],
        \   'initialization_options': {
        \       'cargo': {
        \           'features': 'all',
        \           'extraEnv': {
        \               'RISC0_SKIP_BUILD': '1',
        \               'RISC0_SKIP_BUILD_KERNELS': '1'
        \           },
        \           'targetDir': 'target/rust-analyzer'
        \       }
        \   },
        \ })
endif

let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
let g:lsp_document_highlight_enabled = 0

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    " setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    inoremap <buffer> <expr><c-d> lsp#scroll(-4)

endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

call vundle#end()            " required
filetype plugin indent on    " required

" airline needs theses
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Need this to show unicode

" ctrl-space settings
set hidden
set showtabline=0

" filetype plugin for nerd commenter
filetype plugin on

let g:gundo_prefer_python3 = 1

" Key Remap for tagbar, nerdtree, and gundo
nmap <F8> :TagbarToggle<CR>
nmap <F5> :NERDTreeToggle<CR>
nmap <F6> :GundoToggle<CR>
" nmap <F1> :BufExplorer<CR>
" nmap <F2> :setlocal spell! spelllang=en_us<CR>

set spell
set spelllang=en_us
hi clear SpellBad
hi clear SpellLocal
hi SpellBad cterm=underline
hi SpellLocal cterm=underline

" CtrlP settings
let g:ctrlp_cmd = 'CtrlPMixed'

" set the dictionary for spelling complete
set dictionary=/usr/share/dict/words

" Key Remap for Make
nmap <F9> :Make<CR>

command! -nargs=* Checkrun !./check_run.py <args>"

" Macro for checktime
command! -nargs=* S checktime"

" Set the leader key to comma
let mapleader=","

" Hook up the system pasteboard
" vnoremap "+y "+y:call system('pbcopy', @+)<CR>:echo ""<CR>
" noremap "+yy "+yy:call system('pbcopy', @+)<CR>:echo ""<CR>
" noremap "+Y "+Y:call system('pbcopy', @+)<CR>:echo ""<CR>

" Make shortcut for system pasteboard
vmap sy "+y
map syy "+yy
map sY "+Y

" Highlighting
set hlsearch
set incsearch
set ignorecase

" set color column
set colorcolumn=+1

" undo file
set undofile
set undodir=/Users/remi/.vim/undo

" Remove nasty scrollbars
set guioptions-=r
set go-=L

" Wrapping
set textwidth=100
set fo+=t

" line numbers
set number

" spaces for tabs
set expandtab
set shiftwidth=4
set softtabstop=4

" Run rustfmt on save
let g:rustfmt_autosave = 1
"let g:rustfmt_command = "/home/remi/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/bin/rustfmt --edition 2021"
"let g:rustfmt_command = "rustfmt --edition 2021"

" For rusty-tags
autocmd BufRead *.rs :setlocal tags=./rusty-tags.vi;/
autocmd BufWrite *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" <bar> redraw!

" don't show mode at last line
set noshowmode

" ruler indicator
" Turned off because airline does this
" set ruler

" Keep selection after tab adjust
vnoremap < <gv
vnoremap > >gv

" cscope f7 refresh
map <F7> :!~/bin/tags.sh<CR> :cscope reset<CR>

" auto load cscope file
if has("cscope")
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    if filereadable("pycscope.out")
        cs add pycscope.out
    endif
    cs reset
endif

" cscope in quickfix
set cscopequickfix=s-,c-,d-,i-,t-,e-

" use cscope for tags
set cscopetag

" hit the tags database before cscope
set csto=1

" cscope shortcuts
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>

" NerdTree
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeQuitOnOpen=1

" lightline theme
let g:lightline = {}

" show full file path in lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ],
      \ },
      \ 'inactive': {
      \   'left': [ [ 'relativepath', 'modified' ] ],
      \ },
      \ 'colorscheme': 'catppuccin_mocha'
      \ }

" Build current associated test
function! QbuildT()
    let buffer = @%
    let regex = '\(.*\)_test\.[ch]'
    if empty(matchstr(buffer, regex))
        let file_to_build = matchlist(buffer, '\(.*\)\.[ch]')[1] . '_test.list'
    else
        let file_to_build = matchlist(buffer, '\(.*\)\.[ch]')[1] . '.list'
    endif
    execute "Make build/debug/" . file_to_build
endfunction

" Build current .o file
function! QbuildO()
    let buffer = @%
    let file_to_build = matchlist(buffer, '\(.*\)\.[ch]')[1] . '.o'
    execute "Make build/debug/" . file_to_build
endfunction

command! MakeT call QbuildT()
command! MakeO call QbuildO()

nmap <F11> :MakeT<CR>
nmap <F12> :MakeO<CR>
nnoremap tn :tabnext<CR>
nnoremap tp :tabprev<CR>
