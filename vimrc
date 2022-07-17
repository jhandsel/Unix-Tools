" Plugins
" - ale (linting)
" - commentary (commenting/uncommenting)
" - (removed) jedi-vim (autocompletion and definition navigation)
" - (removed) vim-mucomplete (remap autocomplete to tab)
" - vim-python-pep8-indent (auto-indenting when split line in parenthesis)
" - vim-pydocstring (auto python docstring)
" - vim-repl (open a repl)
" - vim-tmux-navigator (integrate vim and tmux navigation)
" - coc.nvim (autocompletion and optionally linting)
"   - coc-jedi (python autocomplete)
"   - coc-tabnine (machine learning autocomplete)
"   - coc-yaml
"   - coc-json
" - tagbar (class and method table)
" - vim-vinegar (not yet installed, may try later)

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

" Line under cursor
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

" When open a split, put it below or right
set splitbelow
set splitright

" " Save undo history to disk
" if !isdirectory($HOME."/.vim")
"     call mkdir($HOME."/.vim", "", 0770)
" endif
" if !isdirectory($HOME."/.vim/undo")
"     call mkdir($HOME."/.vim/undo", "", 0700)
" endif
" set undodir=~/.vim/undo
" set undofile

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

" Python wrap comments
autocmd FileType python set textwidth=72
autocmd FileType python set formatoptions-=t

" code folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za
" Other commands:
" zR: open all
" zM: close all
" zj: start of next fold
" zk: end of previous fold

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

""" ALE Options
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

""" mu-complete options
" Show menu even if there is only one match
" set completeopt+=menuone
" Don't show completion messages at bottom of screen
" set shortmess+=c

""" coc settings
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Symbol renaming.
nmap <leader>r <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"""" Jedi options
"let g:jedi#popup_on_dot = 0
"let g:jedi#use_tabs_not_buffers = 1
"" Show function signature popup
"" let g:jedi#show_call_signatures = 1
"" Show function signature instead of mode
"autocmd Filetype python set noshowmode
"let g:jedi#show_call_signatures = 2
"" Close preview window after completion
"autocmd CompleteDone * pclose

""" vim-repl options
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

""" Doge options
let g:doge_mapping = '<leader>d'

""" Pydocstring options
" autocmd FileType python nmap <buffer> <silent> <leader>d <Plug>(pydocstring)
" let g:pydocstring_templates_path = '~/.vim/pydocstring_templates'
" let g:pydocstring_enable_mapping = 0

""" Fix yaml formatting
autocmd FileType yaml,yml setlocal ts=2 sts=2 sw=2 expandtab

""" Tagbar options
let g:tagbar_ctags_bin = "/opt/local/bin/uctags"
nnoremap <leader>n :TagbarToggle<CR>
