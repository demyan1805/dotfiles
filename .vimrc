syntax enable
filetype plugin indent on



"""""""""""
" PLUGINS "
"""""""""""

call plug#begin('~/.local/share/nvim/plugged')

" File types
Plug 'dag/vim-fish'
Plug 'chr4/nginx.vim'
Plug 'cespare/vim-toml'
Plug 'pangloss/vim-javascript'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'HerringtonDarkholme/yats.vim'

" Formatting
Plug 'godlygeek/tabular'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-surround'
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'

" Other
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/limelight.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/rainbow_parentheses.vim'

" With custom options
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Icons
Plug 'ryanoasis/vim-devicons'

call plug#end()

source ~/.vim/custom/ctrlp.vim
source ~/.vim/custom/fzf.vim



""""""""""""
" SETTINGS "
""""""""""""

colorscheme dracula

" IO
set undofile
set noswapfile
set encoding=utf-8

" Mappings
set pastetoggle=<F2>
let mapleader="\<SPACE>"

" UI behevior
set mouse=a
set scrolloff=5
set timeoutlen=2000
set updatetime=500
set guicursor=
      \n-v-c-sm:block,
      \i-ci-ve:ver25,
      \r-cr:hor20,
      \o:hor50,
      \a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,
      \sm:block-blinkwait175-blinkoff150-blinkon175

" Windows UI
set number
set cursorline
set splitbelow
set splitright
set signcolumn=yes

" Indentation
set tabstop=4
set expandtab
set autoindent
set shiftwidth=4

" Foldings
set foldcolumn=1
set foldmethod=indent

" Text
set wrap
set list
set linebreak
set listchars=tab:▸\ ,trail:↔,nbsp:+

" Search
set hlsearch
set incsearch
set smartcase
set ignorecase

" Tags
set tags=./.ctags,.ctags

" Variables
let g:airline_theme='dracula'
let g:airline_powerline_fonts = 1

" use error & warning count of diagnostics form coc.nvim
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" create a part for server status.
function! GetServerStatus()
  return get(g:, 'coc_status', '')
endfunction
call airline#parts#define_function('coc', 'GetServerStatus')
function! AirlineInit()
  let g:airline_section_a = airline#section#create(['coc'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

" exclude overwrite statusline of list filetype
let g:airline_exclude_filetypes = ["list"]

let g:coc_node_path = '/Users/lastdanmer/.config/nvm/11.13.0/bin/node'

let g:dracula_colorterm = 1

let g:peekaboo_compact = 1

let g:python_host_prog  = '/usr/local/bin/python2'
let g:python3_host_prog = '/Users/lastdanmer/.pyenv/versions/3.7.2/bin/python'

let g:webdevicons_enable_ctrlp = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

" ENV
let $PYTHONPATH = '/Users/lastdanmer/.pyenv/versions/jedi/lib/python3.7/site-packages'

" Conditional settings
if !has('nvim')
  set t_Co=256
  set guicursor+=a:blinkon0
  "set mouse=nicr

  let &t_SI.="\e[5 q" " insert
  let &t_SR.="\e[4 q" " replace
  let &t_EI.="\e[1 q" " normal
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Highlights
hi CursorLine ctermbg=NONE guibg=#303241



"""""""""""""""""
" ABBREVIATIONS "
"""""""""""""""""

iab {{ {{ }}<Left><Left><Left>
inorea <expr> #!! "#!/usr/bin/env" . (empty(&filetype) ? '' : ' '.&filetype)



""""""""""""""""
" AUTOCOMMANDS "
""""""""""""""""

au BufNewFile,BufRead flake8 setf dosini
function! PythonHighlights()
    hi semshiImported gui=NONE cterm=NONE
    hi semshiSelected guibg=#990045
endfunction
au FileType python call PythonHighlights()

" coc.nvim root_patterns
au FileType go let b:coc_root_patterns = ['go.mod', 'go.sum']
au FileType python let b:coc_root_patterns = ['Pipfile', 'pyproject.toml', 'requirements.txt']
au FileType javascript let b:coc_root_patterns = ['package.json', 'node_modules']

au! CompleteDone * if pumvisible() == 0 | pclose | endif



""""""""""""
" COMMANDS "
""""""""""""

command! DirFiles Files %:h
command! CopyPath let @+ = expand('%:p')
command! Delallmarks delmarks A-Z0-9\"[]
command! FormatJSON %!python -m json.tool
command! -nargs=0 Format :call CocAction('format')
command! -range FormatSQL <line1>,<line2>!sqlformat --reindent --keywords upper --identifiers lower -
command! SortImports %!isort -



""""""""""""
" MAPPINGS "
""""""""""""

" One-key (with or w/o modifier) mappigns
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

nnoremap { gT
nnoremap } gt

nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

nnoremap <C-p> "0p
vnoremap <C-p> "0p

inoremap <silent><expr> <c-x> coc#refresh()
" tnoremap <Esc> <C-\><C-n>

" Two-key (with or w/o modifier) mappigns
nmap <silent> [q :cp<CR>
nmap <silent> ]q :cn<CR>

nmap <silent> [h :Semshi goto name prev<CR>
nmap <silent> ]h :Semshi goto name next<CR>
nmap <silent> [H :Semshi goto name first<CR>
nmap <silent> ]H :Semshi goto name last<CR>

nmap <silent> [d <Plug>(coc-diagnostic-prev)<CR>
nmap <silent> ]d <Plug>(coc-diagnostic-next)<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gl <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Tab & S-Tab for completion menu navigation
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Documentation preview
nnoremap <silent> Y :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Delete item form QuickFix list
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  if len(qfall) > 0
    execute curqfidx + 1 . "cfirst"
    :copen
  else
    :cclose
  endif
endfunction
command! RemoveQFItem :call RemoveQFItem()
autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>

" Messages cleanup
nmap <silent> <Leader><BS> :echo ''<CR>
nmap <silent> <Leader><CR> :noh<CR>:echo ''<CR>

" One-key popup lists
nmap <Leader>b :Buffers<CR>
nmap <Leader>e :CtrlP<CR>
nmap <Leader>f :Files<CR>
nmap <Leader>` :Marks<CR>
nmap <Leader>t :Tags<CR>

" (G)oTo keys
nmap <silent> <Leader>gn :tabnew<CR>
nmap <silent> <Leader>gs :tab split<CR>

" (V)iew keys
nmap <silent> <Leader>vl :Limelight!!<CR>
nmap <silent> <Leader>vr :RainbowParentheses!!<CR>
nmap <silent> <Leader>vs :syntax sync fromstart<CR>

"
" Coc-related stuff
"
" Diagonostics
nmap <leader>dl :CocList diagnostics<CR>
nmap <leader>di <Plug>(coc-diagnostic-info)<CR>

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)

" QuickFix related mappings
nmap <silent> <leader>qo :copen<CR>
nmap <silent> <leader>qc :cclose<CR>
" Fix autofix problem of current line
nmap <leader>qf <Plug>(coc-fix-current)
"
" Remap for format selected region
nmap <leader>rf <Plug>(coc-format-selected)
vmap <leader>rf <Plug>(coc-format-selected)
