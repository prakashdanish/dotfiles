
"         _
"  __   _(_)_ __ ___  _ __ ___ 
"  \ \ / / | '_ ` _ \| '__/ __|
"   \ V /| | | | | | | | | (__ 
"    \_/ |_|_| |_| |_|_|  \___|
" 



" plugins
" -------

call plug#begin()

" code formatting
Plug 'ambv/black'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'w0rp/ale'

" colorschemes
Plug 'danishprakash/vim-yami'   " defaul monochrome
Plug 'ayu-theme/ayu-vim'        " light scheme for writing
Plug 'sickill/vim-monokai'      " for other users

" utils
Plug '/usr/local/opt/fzf'
Plug 'RRethy/vim-illuminate'
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'danishprakash/vim-githubinator'
Plug 'danishprakash/vimport'
Plug 'davidhalter/jedi-vim'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'honza/vim-snippets'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'scrooloose/nerdtree'
Plug 'simeji/winresizer'
Plug 'townk/vim-autoclose'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'machakann/vim-sandwich'

" plugin development
Plug '/Users/danish/programming/vim-docker'
Plug '/Users/danish/programming/vim-yami'
Plug '/Users/danish/programming/vim-blameline'
" Plug '/Users/danishprakash/programming/vim-githubinator'
" Plug '/Users/danishprakash/programming/vim-md'
" Plug '/Users/danishprakash/programming/vimport'


call plug#end()



" globals
" -------

" define leader key
let mapleader=' '

let ayucolor="light"

" hide bloat in NERDTree
let g:NERDTreeMinimalUI=1

" python execs for nvim
let g:completor_python_binary = '/usr/local/bin/python3'
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" use default mappings for vim-githubinator
let g:githubinator_no_default_mapping=0

" vim-jedi
let g:jedi#auto_vim_configuration = 0
let g:jedi#popup_select_first = 0
let g:jedi#show_call_signatures = '1'
let g:jedi#use_splits_not_buffers = 'left'

" linters for ale
let g:ale_linters = {'python': ['flake8'], 'javascript': ['eslint']}
let g:ale_python_flake8_options = '--ignore=E501'

" UltiSnips motions
let g:UltiSnipsJumpBackwardTrigger='<c-t>'
let g:UltiSnipsJumpForwardTrigger='<c-r>'

" If you want :UltiSnipsEdit to vertically split your window.
let g:UltiSnipsEditSplit='vertical'

" configuration for lightline (statusline)
let g:lightline = {
      \ 'colorscheme': 'yami',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'filename', 'gitbranch', 'readonly', 'modified' ], ['tabline']],
      \   'right': [[ 'lineinfo', 'filetype' ]]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ 'separator': {
      \ 'right': '',
      \ 'left': ''
      \ },
      \ } 

" set separators bw objects in lightline (statusline)
let g:lightline.subseparator = { 'left': '/', 'right': '/' }

" use lsp for go-to-def, disable vim-go
let g:go_def_mapping_enabled = 0

" disable preview window while picking files
let g:fzf_preview_window = ''

" this is analogous to the height flag
let g:fzf_layout = { 'down': '~25%' }

" disable colors for fzf
let $FZF_DEFAULT_OPTS="--color='bw'"

" delay for displaying blameline
let g:blameline_delay = 1000

" set goimports as the fmt command for vim-go
let g:go_fmt_command = "goimports"



" configurations
" --------------

set background=dark
set belloff+=ctrlg                 " If Vim beeps during completion
set cursorline                     " highlight current cursor column
set expandtab                      " expand tab to spaces
set hlsearch                       " enable search highlights
set ignorecase                     " ignore case while searching
set magic                          " :h pattern
set mouse=a                        " enable mouse for `a`ll modes
set nomodeline                     " vim reading random lines as modelines
set noshowmode                     " hide current mode label
set nowrap                         " disable line wrapping
set number                         " always show line number
set relativenumber                 " show line numbers relative to the current line
set scrolloff=10                   " cursor remains at ~center of the window
set shiftwidth=4                   " tab width while autoindenting
set tabstop=4                      " tab width for things like :retab
set shortmess+=c                   " disable completion messages in statusline
set shortmess+=a                   " suppress a bunch of info messages
set shortmess+=I                   " don't show intro messages on startup
set showmatch                      " set show matching parenthesis
set undodir=~/.config/nvim/undodir " undo meta file location
set undofile                       " maintain undo history bw sessions
set ai                             " auto indent
set inccommand=nosplit             " interactive substitution
set smartindent                    " smart indent
set smartcase                      " override ignorecase if case is searched for explicitly
set signcolumn=yes                 " always show signcolumns
set cmdheight=1                    " prompt height
set hidden                         " temp coc.nvim configuration, if hidden is not set, TextEdit might fail.
set updatetime=300                 " Smaller updatetime for CursorHold & CursorHoldI



" autocommands
" --------

" autocommands for go development
" augroup GoDev
"     autocmd!

"     " run `GoImports` on every buffer write for go files
"     autocmd BufWritePost *.go :GoImports
" augroup END

augroup NERDTree
    autocmd!
    autocmd FileType nerdtree set syntax=ON
augroup END

" workflow for daily journal
augroup journal
    autocmd!

    " populate journal template
    autocmd VimEnter */journal/**   0r ~/.config/nvim/templates/journal.skeleton

    " set header for the particular journal
    autocmd VimEnter */journal/**   :call SetJournalHeader()

    " other configurations
    autocmd VimEnter */journal/**   set ft=markdown
    autocmd VimEnter */journal/**   syntax off

    " https://stackoverflow.com/questions/12094708/include-a-directory-recursively-for-vim-autocompletion
    autocmd VimEnter */journal/**   set complete=k/Users/danish/programming/mine/journal/**/*
augroup END


" source vimrc when saved 
augroup VimReload
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

" setting wrap while editing markdown files
autocmd FileType markdown set wrap

" start nerdtree on start-up 
" autocmd VimEnter * NERDTree

autocmd FileType python setlocal completeopt-=preview

" reload file if changed outside of vim (think branch changes)
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


" configure goyo.vim for writing
function! s:goyo_enter()
    set nocursorline
    syntax off
endfunction

function! s:goyo_leave()
    set cursorline
    syntax on
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()



" remappings
" ----------

" clear search highlight on <c-[> (esc)
nnoremap <silent><c-[> :nohlsearch<CR>

" open current file in NERDTree
nnoremap <leader>j :GitGutterPrevHunk<CR>

" correct previous spelling mistakes
" https://castel.dev/post/lecture-notes-1/
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" skip to next git change
nnoremap <leader>j :GitGutterPrevHunk<CR>
nnoremap <leader>k :GitGutterNextHunk<CR>

" focus current file in NERDTree
nnoremap <leader>n :NERDTreeFind<CR>

" remap c-u and c-d to use lesser jumps
nnoremap <C-d> 8j
nnoremap <C-u> 8k

" keybinding for tags fuzzy finder
nnoremap <leader>t :Tags<CR>

" add daily journal title
nnoremap <leader>jj :call SetJournalHeader()<CR>

" cycle through buffers
" nnoremap <silent><C-n> :bnext<CR>
" nnoremap <silent><C-p> :bprevious<CR>

" open file finder
" nnoremap <silent><C-p> :Files<CR>

" add new line(o/O) without entering insert mode
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" overwrite write op on protected files
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" remap C-/ to comment out the current line
nnoremap <C-_> gcc

" toggle gitgutter
nnoremap <leader>gt :GitGutterToggle<CR>

" open file finder
nnoremap <silent> <leader><leader> :Files<CR>

" open line finder
nnoremap <silent> <leader>l :Lines<CR>

" open buffer finder
nnoremap <silent> <leader>b :Buffers<CR>

" search using rg
nnoremap <leader>4 :Rg <c-r>=expand("<cword>")<cr><CR>

" \_ uses last changed or yanked text as an object
onoremap <leader>_ :<C-U>normal! `[v`]<CR>

" start nerdtree 
nnoremap <leader>nd :NERDTreeToggle<CR>

" hit enter to insert highlighted item in popup list
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" enable Goyo for markdown writing and toggle ALE
nnoremap <silent> <leader>go :Goyo 90<cr>

" execute current buffer with python3 
autocmd FileType python nnoremap <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>

" codefmt 
nnoremap <leader>fm :FormatCode<cr>
vnoremap <leader>fm :FormatLines<cr>

" ALE toggle
nnoremap <leader>al :ALEToggle<cr>

" moving across splits
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" open a vertical split window and fire up FZF
nnoremap <silent><leader>v :vnew<cr>:Files<CR>

" convert current word to uppercase and enter insert mode
nnoremap <S-u> viwU<esc>el

" close current buffer
nnoremap <silent><leader>q :bd<cr>

" save current file
nnoremap <leader>w <esc>:w<cr>

" surround current word with double-quotes
" nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" open vimrc in vertial split and source it
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>so :so $MYVIMRC<cr> :CocRestart<CR>

" move around wrapped lines as if separate lines
noremap <silent> j gj
noremap <silent> k gk

" move to beginning/end of line
nnoremap H ^
nnoremap L $

"move 5 lines up and down while holding Shift and j/k
" nnoremap <silent> <C-j> :+5 <CR>
" nnoremap <silent> <C-k> :-5 <CR>
" nnoremap <silent> <C-j> <nop>
" nnoremap <silent> <C-k> <nop>

" source plugin file (dev)
nnoremap <leader>sp :so /Users/danishprakash/.local/share/nvim/site/autoload/zen.vim<cr>

" flash the current line when changing window position using `zz`
" nnoremap <silent>zz zz :call StrobeCursorLine()<CR>

" :w!! to save with sudo
ca w!! w !sudo tee >/dev/null "%"





" colors
" ------

colorscheme yami
filetype on
filetype plugin indent on
syntax manual
set listchars=tab:│\ ,nbsp:␣,trail:∙,extends:>,precedes:<
set fillchars=vert:\│


" settings are specific to preto colorscheme
hi ALEError cterm=none

" enable 256 color support
if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
    set termguicolors
endif


" clear end of buffer chars
set fillchars=eob:\ 

" highlight matching parens with a darker shade (required when using no syntax)
hi MatchParen guifg=white guibg=gray


" functions
" ---------

nnoremap <silent> <leader>ue :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>

" WIP
func! UnescapeNewlines()
    let l:beg = col("'<")
    let l:end =  col("'>")
    echo beg
    echo end
endfunc


" custom completion source test
" func! ListNames()
"     call complete(col('.'), ['Danish', 'Aman', 'Hallelujah'])
"     return ''
" endfunc

" inoremap <leader>y <C-R>=ListNames()<CR>

" set header title for journal
" and enter writing mode
function! SetJournalHeader()
    execute 'normal gg'
    let filename = '#' . ' ' . expand('%:r')
    call setline(1, filename)
    execute 'normal o'
    execute 'Goyo'
endfunction

" figure out highlight group under cursor
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>

" blink cursorline for searches
" nnoremap <silent> n n:cal StrobeCursorLine()<cr>
" nnoremap <silent> N N:call StrobeCursorLine()<cr>

" function! StrobeCursorLine()
"     for l:count in range(3)
"         set invcursorline
"         redraw
"         exec 'sleep 10m'
"         set invcursorline
"         redraw
"         exec 'sleep 10m'
"     endfor
" endfunction


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
