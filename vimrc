" Plugins
" - ale
" - commentary
" - jedi-vim
" - vim-mucomplete
" - vim-python-pep8-indent
" - vim-repl
" - vim-tmux-navigator

" Pretty editor
syntax enable
filetype on
filetype plugin indent on
set autoindent

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


" Default to UTF-8
set encoding=utf-8

" Toggle line numbers with F2
set number
set relativenumber
nnoremap <F2> :set invnumber invrelativenumber<CR>

" Line under cursor
set cursorline

" Match braces
set showmatch

" Enable backspace
set backspace=indent,eol,start

" Status bar with column
set laststatus=2
set ruler

" Disable backups (otherwise get tilde files everywhere)
set nobackup

" Save undo history to disk
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "", 0700)
endif
set undodir=~/.vim/undo
set undofile

" Quicker window movement
" Now taken care of by vim-tmux-navigator
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-h> <C-w>h
" nnoremap <C-l> <C-w>l
" Quicker window movement with terminal
" tnoremap <C-j> <C-w>j
" tnoremap <C-k> <C-w>k
" tnoremap <C-h> <C-w>h
" tnoremap <C-l> <C-w>l

" Enable vim-tmux-navigator in vim's terminal
tnoremap <silent> <C-j> <C-w>:TmuxNavigateDown<cr>
tnoremap <silent> <C-k> <C-w>:TmuxNavigateUp<cr>
tnoremap <silent> <C-h> <C-w>:TmuxNavigateLeft<cr>
tnoremap <silent> <C-l> <C-w>:TmuxNavigateRight<cr>

" Make searching better
set ignorecase
set smartcase
set hlsearch
"set incsearch

" Use enter to create new lines w/o entering insert mode
nnoremap <CR> o<Esc>
" Below is to fix issues with the ABOVE mapping in quickfix window
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix nnoremap <CR> <CR>

" Enable all python syntax
let python_highlight_all = 1

" F4 to run pycodestyle
autocmd Filetype python nnoremap
    \ <buffer> <F4> <Esc>:w<CR>:!clear; pylint %
    \ && mypy --ignore-missing-imports %
    \ && pycodestyle --config=.pycodestyle %<CR>

" Set the compiler for Python files to pylint
" Use :make % to lint
autocmd FileType python compiler pylint
" F4 to run pylint
" autocmd Filetype python nnoremap
"     \ <buffer> <F4> <Esc>:w<CR>:!clear<CR>:make %<CR>

" F5 to run python script
autocmd Filetype python nnoremap <buffer> <F5> <Esc>:w<CR>:!clear;python3 %<CR>
" Same, but for visual selection
autocmd Filetype python xnoremap <buffer> <F5> :w !python3<CR>

" F6 to run python script interactively
" Using vim-repl
autocmd Filetype python nnoremap <silent>
    \ <buffer> <expr> <F6> repl#REPLIsVisible() ? ':REPLSendAll<CR>' 
    \ : ':REPLToggle<CR> :REPLSendAll<CR>'
" autocmd Filetype python nnoremap <silent>
"     \ <buffer> <F6> <Esc>:w<CR>:terminal++close python3 -i %<CR>

" Python omnicompletion (ctrl-x ctrl-o)
" (not needed with jedi)
"autocmd FileType python set omnifunc=python3complete#Complete

" code folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

" When editing a file, always jump to the last known cursor position.
" Don't do it for commit messages, when the position is invalid, or when
" inside an event handler (happens when dropping a file on gvim).
autocmd BufReadPost *
  \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

" resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :resize +5<cr>
nnoremap <silent> <Down> :resize -5<cr>

""" ALE Options
let g:ale_linters = {'python': ['pylint', 'mypy', 'pycodestyle']}
let g:ale_python_mypy_show_notes = 0
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_python_pycodestyle_options = '--config=.pycodestyle'

""" mu-complete options
" Show menu even if there is only one match
set completeopt+=menuone
" Close preview window after completion
autocmd CompleteDone * pclose
" Open preview window split at bottom
set splitbelow

""" Jedi options
let g:jedi#popup_on_dot = 0
let g:jedi#use_tabs_not_buffers = 1
" Show function signature popup
" let g:jedi#show_call_signatures = 1
" Show function signature instead of mode
autocmd Filetype python set noshowmode
let g:jedi#show_call_signatures = 2

""" Pydocstring options
" Pydocstring to add docstring automatically
" autocmd Filetype python nnoremap <buffer> <leader>D <Plug>(pydocstring)
" let g:pydocstring_enable_mapping = 0
" autocmd Filetype python nmap <silent> <leader>D <Plug>(pydocstring)

""" Doge options
let g:doge_mapping = "<leader>D"

""" vim-repl options
let g:repl_program = {
            \   'python': 'python3',
            \   'default': 'zsh',
            \   }

" Send code to REPL
let g:sendtorepl_invoke_key = "<leader>e"
" Toggle REPL
nnoremap <leader>t :REPLToggle<Cr>
