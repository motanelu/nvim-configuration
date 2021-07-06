call plug#begin('~/.vim/plugged')
  source ~/.config/nvim/vimplug.vim
call plug#end()

syntax on
if (has("termguicolors"))
 set termguicolors
endif

let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1
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
set nowritebackup
set nobackup                    " no backup - use git like a normal person
set noswapfile                  " no swap file
set splitbelow                  " horizontal windows always split below
set splitright                  " vertical windows always split right
set completeopt-=preview
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
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c                " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes


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

" Remove whitespace on write
autocmd BufWritePre * call StripTrailingWhitespace()

" Easy move between windows
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

let g:python3_host_prog = '~/.pyenv/versions/neovim3/bin/python'
let g:python_host_prog  = '~/.pyenv/versions/neovim2/bin/python'

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
    noremap to :tabonly<cr>     " close all other tabs
    " MacOSX hacks
    noremap ¬ :tabnext<cr>      " ALT + l next tab
    noremap ˙ :tabprevious<cr>  " ALT + h previous tab

    " go back after navigating to a definition
    noremap gb <C-o>
" }}}
"
" {{{ Plugin configurations
  " yuttie/comfortable-motion.vim
  let g:comfortable_motion_no_default_key_mappings = 1
  let g:comfortable_motion_scroll_down_key = "j"
  let g:comfortable_motion_scroll_up_key = "k"

  " dhruvasagar/vim-table-mode
  let g:table_mode_corner_corner   = "+"
  let g:table_mode_header_fillchar = "="

  " matze/vim-move
  let g:move_key_modifier = 'C'

  " vim-airline/vim-airline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#formatter = "unique_tail_improved"
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#show_splits = 0
  let g:airline#extensions#tabline#show_tabs = 1
  let g:airline#extensions#tabline#show_tab_nr = 0
  let g:airline#extensions#tabline#show_tab_type = 0
  let g:airline#extensions#tabline#show_close_button = 0
  let g:airline#extensions#ale#enabled = 1
  let g:airline_theme='oceanicnext'

  " CTRL+b to open scrooloose/nerdtree
  nmap <C-b> :NERDTreeToggle<CR>

  let g:javascript_plugin_jsdoc = 1

  " yuttie/comfortable-motion.vim
  " use ALT + j || k for fast in file movement
  let g:comfortable_motion_no_default_key_mappings = 1
  " macOS hack for ALT+j and ALT+k
  nnoremap <silent> ∆ :call comfortable_motion#flick(100)<CR>
  nnoremap <silent> ˚ :call comfortable_motion#flick(-100)<CR>
" }}}

" {{{
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  " <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
  if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current line.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Introduce function text object
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)

  " Introduce class/struct/interface text object
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ic <Plug>(coc-classobj-i)
  omap ac <Plug>(coc-classobj-a)

  " Use <TAB> for selections ranges.
  " NOTE: Requires 'textDocument/selectionRange' support from the language server.
  " coc-tsserver, coc-python are the examples of servers that support it.
  nmap <silent> <TAB> <Plug>(coc-range-select)
  xmap <silent> <TAB> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings using CoCList:
  " Show all diagnostics.
  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
  " press <esc> to cancel.
  nmap f <Plug>(coc-smartf-forward)
  nmap F <Plug>(coc-smartf-backward)
  nmap ; <Plug>(coc-smartf-repeat)
  nmap , <Plug>(coc-smartf-repeat-opposite)

  augroup Smartf
    autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#6638F0
    autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
  augroup end

  " CTRLP config
  let g:ctrlp_custom_ignore = '\v[\/]((\.(git|hg|svn))|node_modules)$'

" }}}
