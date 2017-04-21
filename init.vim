"
" Custom init.vim file
"
" This is in the public domain, so feel free to use / change / redistribute it
" You can check the complete repository at http://github.com/motanelu/vim-configuration
"
" Author: Tudor Barbu <hello@tudorbarbu.ninja>
" Blog: http://tudorbarbu.ninja
" License: LGPL
""

" {{{ Vundle config
    set nocompatible
    filetype off
    set rtp+=~/.config/nvim/bundle/Vundle.vim
    call vundle#begin()
    Plugin 'gmarik/Vundle.vim'

    source ~/.config/nvim/vundle.nvim

    call vundle#end()
    filetype plugin indent on
" }}}

syntax on

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
set tabstop=4                   " use 4 spaces for tabs
set shiftwidth=4
set softtabstop=4
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
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" color scheme
colorscheme solarized

" {{{ File configuration
    " Detect file types
    autocmd BufRead,BufNewFile *httpd*.conf setfiletype apache "Apache config files
    autocmd BufRead,BufNewFile .htaccess    setfiletype apache "htaccess files
    autocmd BufRead,BufNewFile *handlebars  setfiletype html "handlebars templates
    autocmd BufRead,BufNewFile *.vue        setfiletype vue.html.javascript.css
    autocmd FileType vue syntax sync fromstart

    " better autochdir
    autocmd BufEnter * silent! lcd %:p:h

    autocmd FileType python     set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html       set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css        set omnifunc=csscomplete#CompleteCSS noci
    autocmd FileType xml        set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType crontab    setlocal nobackup nowritebackup


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
" }}}

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

    nmap <leader>t :TagbarToggle<CR>     " toggle tagbar - Plugin: majutsushi/tagbar
    nmap <leader>r :UndotreeToggle<cr>   " toggle undotree - Plugin: mbbill/undotree

    " select last pasted text
    nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'

    " spellcheck toggle (on/off)
    nmap <silent> <leader>s :set spell!<CR>

    " CTRL + hjkl to move between windows
    nnoremap <C-J> <C-W><C-J>
    nnoremap <C-K> <C-W><C-K>
    nnoremap <C-L> <C-W><C-L>
    nnoremap <C-H> <C-W><C-H>

    " using tabs
    noremap tn :tabnew<cr>      " tn to open a new tab
    noremap tc :tabclose<cr>    " tc to close the current tab
    noremap ¬ :tabnext<cr>      " ALT + l next tab
    noremap ˙ :tabprevious<cr>  " ALT + h previous tab
    noremap to :tabonly<cr>     " close all other tabs

    inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

    " go back after a gf
    noremap gb <C-o>
" }}}

" {{{ Plugin configurations
    " {{{ ctrlpvim/ctrlp.vim
        let g:ctrlp_working_path_mode = 'ra'
        set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
        let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
    " }}}

    " {{{ tacahiroy/ctrlp-funky
        let g:ctrlp_extensions = ['funky']
        nnoremap <Leader>fu :CtrlPFunky<Cr>
        nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
    " }}}

    " {{{ kien/rainbow_parentheses.vim
        let g:rbpt_colorpairs = [
            \ ['blue',         '#FF6000'],
            \ ['cyan',         '#00FFFF'],
            \ ['darkmagenta',  '#CC00FF'],
            \ ['yellow',       '#FFFF00'],
            \ ['red',          '#FF0000'],
            \ ['darkgreen',    '#00FF00'],
            \ ['White',        '#c0c0c0'],
            \ ['blue',         '#FF6000'],
            \ ['cyan',         '#00FFFF'],
            \ ['darkmagenta',  '#CC00FF'],
            \ ['yellow',       '#FFFF00'],
            \ ['red',          '#FF0000'],
            \ ['darkgreen',    '#00FF00'],
            \ ['White',        '#c0c0c0'],
            \ ['blue',         '#FF6000'],
            \ ['cyan',         '#00FFFF'],
            \ ['darkmagenta',  '#CC00FF'],
            \ ['yellow',       '#FFFF00'],
            \ ['red',          '#FF0000'],
            \ ['darkgreen',    '#00FF00'],
            \ ['White',        '#c0c0c0'],
        \ ]
        au VimEnter * RainbowParenthesesToggle
        au Syntax * RainbowParenthesesLoadRound
        au Syntax * RainbowParenthesesLoadSquare
        au Syntax * RainbowParenthesesLoadBraces
    " }}}

    " {{{ godlygeek/tabular
        nmap <Leader>a=  :Tabularize /=<CR>
        vmap <Leader>a=  :Tabularize /=<CR>
        nmap <Leader>a=> :Tabularize /=><CR>
        vmap <Leader>a=> :Tabularize /=><CR>
        nmap <Leader>a:  :Tabularize /:<CR>
        vmap <Leader>a:  :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
    " }}}

    " {{{ SirVer/ultisnips
        let g:UltiSnipsExpandTrigger       = "<C-l>"
        let g:UltiSnipsJumpForwardTrigger  = "<C-l>"
        let g:UltiSnipsJumpBackwardTrigger = "<C-z>"
        let g:UltiSnipsEditSplit           = "vertical"
    " }}}

    " {{{ joonty/vdebug
        let g:vdebug_keymap = {
            \    "run"            : "<Leader>'",
            \    "run_to_cursor"  : "<Leader><Down>",
            \    "step_over"      : "<Leader><Up>",
            \    "step_into"      : "<Leader><Left>",
            \    "step_out"       : "<Leader><Right>",
            \    "close"          : "q",
            \    "detach"         : "x",
            \    "eval_visual"    : "<Leader>e",
            \    "sspellchcket_breakpoint" : "<Leader>p"
        \}

        let g:vdebug_options = {
            \    "break_on_open" : 0,
        \}
    " }}}

    " {{{ dhruvasagar/vim-table-mode
        let g:table_mode_corner_corner   = "+"
        let g:table_mode_header_fillchar = "="
    " }}}

    " {{{ scrooloose/syntastic
        let g:syntastic_always_populate_loc_list = 1
        let g:syntastic_auto_loc_list            = 0
        let g:syntastic_check_on_wq              = 1
        let g:syntastic_check_on_open            = 1
        let g:syntastic_javascript_checkers      = ['standard']
    " }}}

    " {{{ ternjs/tern_for_vim
        let g:tern_show_argument_hints='on_hold'
        let g:tern_map_keys = 1
    " }}}

    " {{{ Lokaltog/vim-easymotion
        hi link EasyMotionTarget ErrorMsg
        hi link EasyMotionShade  Comment
    " }}}

    let g:airline_powerline_fonts = 1   " bling/vim-airline
    let g:move_key_modifier = 'C'       " matze/vim-move
" }}}

" {{{ Javascript / HTML configuration
    au FileType javascript setl sw=2 sts=2 et
    au FileType html setl sw=2 sts=2 et
    au FileType css setl sw=2 sts=2 et
    au FileType vue setl sw=2 sts=2 et

    " {{{ 1995eaton/vim-better-javascript-completion
        let g:vimjs#smartcomplete = 1
    " }}}

    let g:deoplete#enable_at_startup = 1
    let g:deoplete#omni#functions = {}
    let g:deoplete#omni#functions.javascript = [
        \ 'tern#Complete',
        \ 'jspc#omni'
    \]
    let g:deoplete#sources = {}
    let g:deoplete#sources['javascript.jsx.vue'] = ['file', 'ultisnips', 'ternjs']
    let g:tern#filetypes = [
        \ 'jsx',
        \ 'javascript.jsx',
        \ 'vue'
    \]
    let g:tern#command = ['tern']
    let g:tern#arguments = ['--persistent']
" }}}

" {{{ PHP Configuration
    " PHP specials (next/previous variable)
    noremap L f$
    noremap H F$

    " PHP complete
    let g:phpcomplete_parse_docblock_comments = 1
    let g:phpcomplete_index_composer_command = '/usr/local/bin/composer'

    " php documentor
    inoremap <C-o> <ESC>:call PhpDocSingle()<CR>i
    nnoremap <C-o> :call PhpDocSingle()<CR>
    vnoremap <C-o> :call PhpDocRange()<CR>

    " configure tagbar to not show variables
    let g:tagbar_type_php  = {
        \ 'ctagstype' : 'php',
        \ 'kinds'     : [
            \ 'n:namespaces',
            \ 'i:interfaces',
            \ 'c:classes',
            \ 'd:constant definitions',
            \ 'f:functions'
        \ ]
    \ }

    let g:syntastic_php_checkers   = ['php', 'phpcs']        " do not run phpmd
    let g:syntastic_php_phpcs_args = '-s -n --standard=PSR2' " always check against PSR2

    " php code fixer
    let g:php_cs_fixer_level    = "symfony"  " which level ?
    let g:php_cs_fixer_config   = "default"  " configuration
    let g:php_cs_fixer_php_path = "php"      " Path to PHP
    let g:php_cs_fixer_verbose  = 1          " Return the output of
    let g:php_cs_fixer_enable_default_mapping = 1       " <leader>pcf

    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
" }}}


