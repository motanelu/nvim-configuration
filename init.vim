call plug#begin('~/.vim/plugged')
  source ~/.config/nvim/vimplug.vim
call plug#end()

syntax on
if (has("termguicolors"))
 set termguicolors
endif
colorscheme OceanicNext

" Generic config
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set list                        " Show problematic spaces
set guioptions-=T               " Remove the toolbar
set nobackup                    " no backup - use git like a normal person
set noswapfile                  " no swap file
set splitbelow                  " horizontal windows always split below
set splitright                  " vertical windows always split right
set completeopt-=preview        " auto complete menu
set title                       " show window title
set autoindent                  " autoindent when pressing Enter
set background=dark             " use a dark scheme
set tabstop=2                   " use 4 spaces for tabs
set shiftwidth=2
set softtabstop=2
set expandtab
set incsearch
set ignorecase
set smartcase
set ls=2
set ruler
set showtabline=2
set formatoptions=qroct
set vb                          " kill sounds
set showcmd
set clipboard=unnamed           " save to system's clipboard
set mouse=a                     " allow mouse usage for all modes (a)
set spelllang=en_us             " current language
set cursorline                  " highlight the current line
set fileformat=unix             " unix file format by default
set fileformats=unix,dos,mac    " available formats
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set autoread                    " auto reload changed files

" StriTrailingWhitespace - taken from http://spf13.com
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

augroup omnifuncs
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end

" Remove whitespace on write
autocmd BufWritePre * call StripTrailingWhitespace()

tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

let g:python_host_prog = '/Users/tudor/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/tudor/.pyenv/versions/neovim3/bin/python'

" {{{ Utility mappings
    " Avoid typos
    noremap :W :w
    noremap :Q :q

    " Yank 'till the end of the line
    nnoremap Y y$

    " Find merge conflict marker
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " need sudo?
    cmap w!! w !sudo tee % >/dev/null

    " reset the search
    nmap <silent> ,/ :nohlsearch<CR>

    " Remap the leader to something more comfortable
    let mapleader=","

    " select previously pasted text
    nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

    " using tabs
    noremap tn :tabnew<cr>      " tn to open a new tab
    noremap tc :tabclose<cr>    " tc to close the current tab
    noremap ¬ :tabnext<cr>      " ALT + l next tab
    noremap ˙ :tabprevious<cr>  " ALT + h previous tab
    noremap to :tabonly<cr>     " close all other tabs

    " go back after a gf
    noremap gb <C-o>
" }}}
"
" {{{ Plugin configurations
  " ctrlpvim/ctrlp.vim
  let g:ctrlp_working_path_mode = 'ra'
  let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git|coverage'

  " dhruvasagar/vim-table-mode
  let g:table_mode_corner_corner   = "+"
  let g:table_mode_header_fillchar = "="

  " Lokaltog/vim-easymotion
  hi link EasyMotionTarget ErrorMsg
  hi link EasyMotionShade  Comment

  " matze/vim-move
  let g:move_key_modifier = 'C'

  function! Multiple_cursors_after()
      let b:deoplete_disable_auto_complete = 0
  endfunction

  " posva/vim-vue
  autocmd BufEnter *.vue :syntax sync fromstart
  autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css

  " moll/vim-node
  nmap gF <Plug>NodeVSplitGotoFile

  " vim-airline/vim-airline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#show_splits = 0
  let g:airline#extensions#tabline#show_tabs = 1
  let g:airline#extensions#tabline#show_tab_nr = 0
  let g:airline#extensions#tabline#show_tab_type = 0
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline_theme='oceanicnext'

  " scrooloose/nerdtree
  nmap <C-b> :NERDTreeToggle<CR>

  " ternjs/tern_for_vim
  let g:tern#command = ['tern']
  let g:tern_show_signature_in_pum = 1
  let g:tern#arguments = ['--persistent']
" }}}


