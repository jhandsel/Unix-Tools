" Plugins
" - ale (linting)
" - commentary (commenting/uncommenting)
" - vim-mucomplete (tab completion and autocomplete)
" - vim-python-pep8-indent (auto-indenting when split line in parenthesis)
" - vim-pydocstring (auto python docstring)
" - vim-repl (open a repl)
" - vim-tmux-navigator (integrate vim and tmux navigation)
" - tagbar (class and method table)
" - pydoc from somini (better python help pages)

" Pretty editor
syntax enable
filetype on
filetype plugin indent on
set autoindent

" Default to UTF-8
set encoding=utf-8

" Sane editing
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
" set colorcolumn=80
set colorcolumn=100
autocmd FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Make searching better
set ignorecase
set smartcase
set hlsearch
"set incsearch

" Toggle line numbers and sign column (shows error annotations) with F2
set number
set relativenumber
" Show errors in signcolumn if it is on
set signcolumn=number
" Toggle signcolumn. Works on vim>=8.1 or NeoVim
function! ToggleSignColumn()
    if !exists("b:signcolumn_on") || b:signcolumn_on
        set signcolumn=no
        let b:signcolumn_on=0
    else
        set signcolumn=number
        let b:signcolumn_on=1
    endif
endfunction
" Map toggle
nnoremap <F2> :set invnumber invrelativenumber<CR>:call ToggleSignColumn()<CR>

" Show a line under cursor
set cursorline

" Match braces
set showmatch

" Enable backspace
set backspace=indent,eol,start

" Always show status bar with line number and column
set laststatus=2
set ruler

" Give more space for messages at bottom of screen
set cmdheight=2

" Disable backups (otherwise get tilde files everywhere)
set nobackup

" Use enter to create new lines w/o entering insert mode
nnoremap <CR> o<Esc>
" Below is to fix issues with the ABOVE mapping in quickfix window
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

""" Fix yaml formatting
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Navigation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When open a split, put it below or right
set splitbelow
set splitright

" Enable vim-tmux-navigator in vim's terminal
tnoremap <silent> <C-j> <C-w>:TmuxNavigateDown<cr>
tnoremap <silent> <C-k> <C-w>:TmuxNavigateUp<cr>
tnoremap <silent> <C-h> <C-w>:TmuxNavigateLeft<cr>
tnoremap <silent> <C-l> <C-w>:TmuxNavigateRight<cr>

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" resize panes with arrow buttons
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

" Remove banner from file browser
let g:netrw_banner = 0
" Tree style
let g:netrw_liststyle = 3

" Code folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
" Other commands:
" zR: open all
" zM: close all
" zj: start of next fold
" zk: end of previous fold

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable all python syntax
let python_highlight_all = 1

" Use python omnicomplete
autocmd FileType python set omnifunc=python3complete#Complete
" Close preview window when leave insert mode
"autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" F4 to run linters
autocmd Filetype python nnoremap
    \ <buffer> <F4> <Esc>:w<CR>:!clear; pylint %
    \ && mypy --ignore-missing-imports %
    \ && pycodestyle --config=.pycodestyle %<CR>

" Set the compiler for Python files to pylint
" Use :make % to lint
autocmd FileType python compiler pylint

" F5 to run python script
autocmd Filetype python nnoremap <buffer> <F5> <Esc>:w<CR>:!clear;python3 %<CR>
" Same, but for visual selection
autocmd Filetype python xnoremap <buffer> <F5> :w !python3<CR>

" F6 to run python script interactively
" autocmd Filetype python nnoremap <silent>
"     \ <buffer> <F6> <Esc>:w<CR>:terminal++close python3 -i %<CR>

" Wrap comments
autocmd FileType python set textwidth=72
autocmd FileType python set formatoptions-=t

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PyDoc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:pydoc_cmd='python3 -m pydoc'
let g:pydoc_detect_version=0
let g:pydoc_open_cmd = 'new'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ALE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" To check everything is working, call :ALEInfo
let g:ale_linters = {'python': ['pylint', 'mypy', 'pycodestyle', 'pydocstyle']}
let g:ale_python_mypy_show_notes = 0
let g:ale_python_mypy_options = '--ignore-missing-imports --show-error-codes'
" let g:ale_python_pycodestyle_options = '--config=.pycodestyle'
" Leave languge server protocol to coc.nvim
let g:ale_disable_lsp = 1
" Lint error navigation
nmap <silent> ]e :ALENext <CR>
nmap <silent> [e :ALEPrevious <CR>
" Enable basic fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mu complete
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=menuone,popup,longest
" Don't show completion messages at bottom of screen
set shortmess+=c
" Auto suggestions popup in Python
autocmd FileType python set completeopt-=longest
autocmd FileType python set completeopt+=noselect
autocmd FileType python silent MUcompleteAutoOn
autocmd FileType * if &ft!="python"|silent MUcompleteAutoOff|endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim repl
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:repl_program = {
            \   'python': 'ipython3',
            \   'python-debug': 'ipdb3',
            \   'default': 'zsh',
            \   }
" Enable execute visual selection
let g:repl_sendvariable_template = {
            \ 'python': '<input>',
            \ 'ipython': '<input>',
            \ }
" Send code to REPL
let g:sendtorepl_invoke_key = '<leader>e'
" Toggle REPL
nnoremap <leader>t :REPLToggle<Cr>
" Hack to make ipython work properly
let g:repl_ipython_version = '7'
" Copy repl output to register 't'
let g:repl_output_copy_to_register = 't'
" Run entire file
autocmd Filetype python nnoremap <silent>
    \ <buffer> <expr> <leader>r repl#REPLIsVisible() ? ':REPLSendAll<CR>' 
    \ : ':REPLToggle<CR> :REPLSendAll<CR>'
" Set breakpoint at current line and run script
autocmd Filetype python nnoremap <leader>b <Esc>:REPLDebugStopAtCurrentLine<Cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-pydocstring
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType python nmap <buffer> <silent> <leader>d <Plug>(pydocstring)
let g:pydocstring_templates_path = '~/.vim/pydocstring_templates'
let g:pydocstring_enable_mapping = 0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_ctags_bin = "/opt/local/bin/uctags"
nnoremap <leader>n :TagbarToggle<CR>
