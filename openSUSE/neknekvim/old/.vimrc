" TODO:
"  - fix whichkey colors
"  - refactor/document
"  - fix flutter whichkey
"  - test coc-flutter


" NOTES:
" In which key the <CR> is equal to ENTER key
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Initialize vim-plug
call plug#begin()
  "  example plugin
  " Plug 'tpope/vim-sensible'                                                 

  "  File browser
  Plug 'preservim/nerdtree'                                                 
  
  "  fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }                       
  Plug 'junegunn/fzf.vim'

  "  Startup screen
  Plug 'mhinz/vim-startify'                                                 

  "  git
  Plug 'tpope/vim-fugitive'                                                 

  " Statusline
  " Plug 'itchyny/lightline.vim'                                              
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Which key
  Plug 'liuchengxu/vim-which-key' ", { 'on': ['WhichKey', 'WhichKey!'] }

  " Terminal
  Plug 'voldikss/vim-floaterm'

  " Lsp
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  " Plug 'prabirshrestha/asyncomplete.vim'
  " Plug 'prabirshrestha/asyncomplete-lsp.vim'

  " Dart/Flutter
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'thosakwe/vim-flutter'

  " Code completion
  Plug 'neoclide/coc.nvim', {'branch': 'release'}


  " Colorschemes
  Plug 'tyrannicaltoucan/vim-deep-space'
  Plug 'ajmwagar/vim-deus'
  Plug 'morhetz/gruvbox'
  Plug 'whatyouhide/vim-gotham'
  Plug 'jaredgorski/spacecamp'
  Plug 'glepnir/oceanic-material'
  Plug 'nikolvs/vim-sunbather'
  Plug 'kristijanhusak/vim-hybrid-material'
  Plug 'Badacadabra/vim-archery'




call plug#end()



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure vim-startify
let g:startify_custom_header = [
    \ '   ',
    \ '███╗   ██╗███████╗██╗  ██╗ ██████╗ ██╗   ██╗██╗███╗   ███╗',
    \ '████╗  ██║██╔════╝██║ ██╔╝██╔═══██╗██║   ██║██║████╗ ████║',
    \ '██╔██╗ ██║█████╗  █████╔╝ ██║   ██║██║   ██║██║██╔████╔██║',
    \ '██║╚██╗██║██╔══╝  ██╔═██╗ ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║',
    \ '██║ ╚████║███████╗██║  ██╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║',
    \ '╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝',
    \ '',
    \ '   For help, press ":h startify"',
    \ ]

" Optionally, you can set a list of recently opened files
let g:startify_lists = [
    \ { 'type': 'files', 'header': ['   Recent Files'] },
    \ ]




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" airline config
" let g:airline_theme='deus'
" let g:airline_theme='gruvbox'
let g:airline_theme='gotham'
" let g:airline_theme = 'hybrid'
" let g:airline_theme = 'archery'

" Automatically displays all buffers when there's only one tab open
let g:airline#extensions#tabline#enabled = 1

" This require powerline fonts
" Patched font installation:
" Download powerline
"  wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
"  wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
" Move the patched font to a valid X font path. Valid font paths can be listed with xset q:
"  mv 'SomeFont for Powerline.otf' ~/.local/share/fonts/
" Update font cache for the path the font was moved to (root privileges may be needed for updating font cache for some paths):
" fc-cache -vf ~/.local/share/fonts/
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" powerline symbols
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' ℅:'
let g:airline_symbols.readonly = ''
let g:airline_symbols.dirty='⚡'

let g:airline_section_b = '%-0.12{getcwd()}'
let g:airline_section_c = '%t'
" Simplified
" let g:airline_section_z = '%3p%% %l:%c'
let g:airline_section_z = '%3p%% ㏑%l/%L ☰ %c '

" let g:airline_symbols.colnr = ' ㏇:'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = 'Ξ'



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-fugitive keybindings
" nnoremap <leader>gs :Gstatus<CR>  " Git status
" nnoremap <leader>gd :Gdiff<CR>    " Git diff
" nnoremap <leader>gc :Gcommit<CR>  " Git commit
" nnoremap <leader>gp :Gpush<CR>    " Git push
" nnoremap <leader>gl :Gpull<CR>    " Git pull



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lsp
" copied (almost) directly from the vim-lsp docs:
" function! s:on_lsp_buffer_enabled() abort
"     setlocal omnifunc=lsp#complete
"     setlocal signcolumn=yes
"     if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
" 
"     let g:lsp_format_sync_timeout = 1000
"     autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
" endfunction
" 

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled (set the lsp shortcuts) when an lsp server
    " is registered for a buffer.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" Dart
" dart auto format on save
let g:dart_format_on_save = v:true


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" keybindings
" By default timeoutlen is 1000 ms
set timeoutlen=500

" Set the leader and local leader keys
let g:mapleader = "\<Space>"
"let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
"nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
"vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>

" Basic mappings using Vim-Which-Key syntax
let g:which_key_map = {}

" Set the minimum horizontal space between the displayed columns.
" let g:which_key_hspace = 1

" Set the maximum height/width of the guide window. Set to 0 for unlimited size.
" let g:which_key_max_size = 3

" If set to a value other than 0, the guide buffer will pop up in vertical split window. Possible value: {0, 1}.
" let g:which_key_vertical = 1

" Set the direction from which the guide-buffer should pop up. Possible value: 'botright', 'topleft'.
" let g:which_key_position = 'botright'

" let g:which_key_sort_horizontal = 2

" let g:which_key_align_by_seperator = 0

" let g:which_key_centered = 1

" Remove default highlight links
highlight link WhichKey          Function
highlight link WhichKeySeperator DiffAdded
highlight link WhichKeyGroup     Keyword
highlight link WhichKeyDesc      Identifier

"highlight default link WhichKeyFloating Pmenu

" Define custom highlight groups for which-key
"highlight WhichKey          guifg=#FFD700 gui=bold       " Gold and bold for main keys
"highlight WhichKeySeperator guifg=#FF4500 gui=bold       " Orange red and bold for separators
"highlight WhichKeyGroup     guifg=#87CEEB gui=bold       " Sky blue and bold for groups
"highlight WhichKeyDesc      guifg=#ABB2BF gui=bold       " Light gray and bold for descriptions
"highlight WhichKeyFloating  guibg=#282C34                " Dark gray background for floating window



" Windows management
let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : [':resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : [':resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }

" File management
let g:which_key_map.o = [':NERDTreeFocus<CR>', 'focus-nerdtree']
let g:which_key_map['f'] = {
      \ 'name' : '+file',
      \ 'n' : [':call NERDTreeCreateNewFile()', 'new-file'],
      \ 'o' : [':call NERDTreeFocus()', 'focus-nerdtree'],
      \ 'e' : [':call feedkeys(":NERDTreeToggle\<CR>")<CR>', 'toggle-nerdtree'],
      \ 'f' : [':call feedkeys(":Files\<CR>")<CR>', 'fzf-files'],
      \ 's' : [':call feedkeys(":w\<CR>")<CR>', 'save-file'],
      \ 'd' : [':call feedkeys(":e $MYVIMRC\<CR>")<CR>', 'open-vimrc'],
      \ }
     " \ 'q' : [':copen<CR>', 'open-quickfix'],
     " \ 'l' : [':lopen<CR>', 'open-locationlist'],
     " \ }

" Buffer management
let g:which_key_map['b'] = {
      \ 'name' : '+buffers',
      \ 'd' : [':call feedkeys(":bd\<CR>")<CR>', 'delete-buffer'],
      \ 'f' : [':call feedkeys(":bfirst\<CR>")<CR>', 'first-buffer'],
      "\ 'h' : [':call feedkeys(":Startify\<CR>")<CR>', 'home-buffer'],
      \ 'l' : [':call feedkeys(":blast\<CR>")<CR>', 'last-buffer'],
      \ 'n' : [':call feedkeys(":bnext\<CR>")<CR>', 'next-buffer'],
      \ 'p' : [':call feedkeys(":bprevious\<CR>")<CR>', 'previous-buffer'],
      \ '?' : [':call feedkeys(":Buffers\<CR>")<CR>', 'fzf-buffer'],
      \ }

" Terminal management
let g:which_key_map['t'] = {
      \ 'name' : '+terminal',
      \ 'f' : [':call feedkeys(":FloatermNew\<CR>")<CR>', 'Floaterm float'],
      \ 'h' : [':call feedkeys(":below terminal\<CR>")<CR>', 'horizontal split terminal'],
      \ 'v' : [':call feedkeys(":vertical terminal\<CR>")<CR>', 'vertical split terminal'],
      \ }

" TODO:
" LSP commands
" Enable Flutter menu
" call FlutterMenu()
let g:which_key_map['l'] = {
      \ 'name' : '+lsp',
      \ 'S' : ['<cmd>call spacevim#lang#util#WorkspaceSymbol()<CR>', 'workspace-symbol'],
      \ 'f' : {
            \ 'name': '+flutter',
            \ 'f' : [':call feedkeys(":DartFmt\<CR>")<CR>', 'Flutter Format'],
            \ 'a' : [':call feedkeys(":FlutterRun\<CR>")<CR>', 'Flutter Run'],
            \ 'q' : [':call feedkeys(":FlutterQuit\<CR>")<CR>', 'Flutter Quit'],
            \ 'r' : [':call feedkeys(":FlutterHotReload\<CR>")<CR>', 'Flutter Hot Reload'],
            \ 'R' : [':call feedkeys(":FlutterHotRestart\<CR>")<CR>', 'Flutter Hot Restart'],
            \ 'D' : [':call feedkeys(":FlutterVisualDebug\<CR>")<CR>', 'Flutter Visual Debug'],
            \ },
      \ 'g' : {
            \ 'name': '+goto',
            \ 'd' : [':call spacevim#lang#util#Definition()<CR>', 'definition'],
            \ 't' : [':call spacevim#lang#util#TypeDefinition()<CR>', 'type-definition'],
            \ 'i' : [':call spacevim#lang#util#Implementation()<CR>', 'implementation'],
            \ },
      \ }

" TODO:
"let g:which_key_map['/'] = [ '<Plug>NERDCommenterToggle','commenter' ]

let g:which_key_map['h'] = [ ':call feedkeys(":Startify\<CR>")<CR>', 'home']

" vim-fugitive keybindings
" nnoremap <leader>gd :Gdiff<CR>    " Git diff
" nnoremap <leader>gc :Gcommit<CR>  " Git commit
" nnoremap <leader>gp :Gpush<CR>    " Git push
" nnoremap <leader>gl :Gpull<CR>    " Git pull
let g:which_key_map.g = {
      \ 'name' : '+git',
      \ 's' : [':call feedkeys(":Git\<CR>")<CR>', 'git-status'],
      \ 'a' : [':call feedkeys(":Gwrite\<CR>")<CR>', 'git-add'],
      \ 'p' : [':call feedkeys(":Git push\<CR>")<CR>', 'git-push'],
      \ }

" Quit and open commands
" let g:which_key_map.q = {
"       \ 'name' : '+quit',
"       \ 'q' : [':call feedkeys(":q\<CR>")<CR>', 'quit'],
"       \ }
let g:which_key_map.q = [ ':call feedkeys(":q\<CR>")<CR>', 'quit']
"nnoremap <silent> <leader>q :q<CR>
"let g:which_key_map.q = 'quit'


call which_key#register('<Space>', "g:which_key_map")

" Map 'jk' to <Esc> in Insert mode with a timeout
" `^ = moves the cursor back to its position before the last change or jump, effectively keeping the cursor in place after exiting Insert mode.
" inoremap jk <Esc>`^                                                         " change exit mode keybinding
inoremap jk <Esc>`^

" Key mappings for window navigation
" Close window with Ctrl + q
nnoremap <C-q> :close<CR>
" Switch windows with Ctrl + hjkl
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer navigation
nnoremap <silent>]b :bnext<CR>
nnoremap <silent>[b :bprevious<CR>
"nnoremap <Leader>d :bd<CR>



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start NERDTree and put the cursor back in the other window.
" autocmd VimEnter * NERDTree | wincmd p                                      

" Keybindings for NERDTree
" Toggle NERDTree
"nnoremap <leader>e :NERDTreeToggle<CR>                                      

" Focus NERDTree
" Function to toggle focus between NERDTree and the previous window
" function! ToggleNERDTreeFocus()
"   if exists("t:nerdtree_winid") && win_gotoid(t:nerdtree_winid)
"    wincmd p
"  elseif bufname('%') =~ 'NERD_tree_'
"    wincmd p
"  else
"    NERDTreeFind
"  endif
" endfunction

" Keybinding to toggle focus with leader + o
" nnoremap <leader>o :call ToggleNERDTreeFocus()<CR>

" YOU CAN USE THIS INSTEAD THE FUNCTION ABOVE
" This code does the same thing as the ToggleNERDTreeFocus function
"nnoremap <leader>o :NERDTreeFocus<CR>  
" When in NERDTree, change focus back to the code with leader + o
"autocmd FileType nerdtree nnoremap <buffer> <leader>o :wincmd p<CR>         

" Keybinding to open fzf file search within NERDTree
"nnoremap <leader>f :Files<CR>




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set relative numbers
set number
set relativenumber
" Disable compatibility with vi which can cause unexpected issues.
set nocompatible
" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on
" Load an indent file for the detected file type.
filetype indent on
" Turn on syntax highlighting
syntax on
" Set tabstop to 4 spaces
set tabstop=4
" Convert tabs to spaces
set expandtab
" Set shiftwidth to 2 spaces
set shiftwidth=2
" Ignore capital letters during search
set ignorecase
" copy to systems clipboard
set clipboard=unnamed

" change cursor
" Set terminal insert mode start sequence
let &t_SI = "\e[6 q"
" Set terminal insert mode end sequence
let &t_EI = "\e[2 q"
" Ps = 0  -> blinking block.
" Ps = 1  -> blinking block (default).
" Ps = 2  -> steady block.
" Ps = 3  -> blinking underline.
" Ps = 4  -> steady underline.
" Ps = 5  -> blinking bar (xterm).
" Ps = 6  -> steady bar (xterm).

" Display a status line and a tab line in Vim
set showtabline=2
set laststatus=2


" code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=2



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" colorscheme

" Set the background to dark
set background=dark

" habamax theme
" colorscheme habamax

" monokai theme
" colorscheme monokai

" deep-space theme
" colorscheme deep-space

" deus theme
" colorscheme deus

" gruvbox theme
" colorscheme gruvbox

" gotham theme
colorscheme gotham

" spacecamp theme
" colorscheme spacecamp
" lighter spacecamp
" colorscheme spacecamp_lite

" oceanic theme
" colorscheme oceanic_material

" sunbather theme
" colorscheme sunbather

" hybrid material theme
" If you would like some of the code to be bolded, like functions and language controls, uncomment this
" let g:enable_bold_font = 1
" If you want comments to be in italic, uncomment this
" let g:enable_italic_font = 1
" To use transparent background, uncomment this
" let g:hybrid_transparent_background = 1
" colorscheme hybrid_material
" colorscheme hybrid_reverse

" archery theme
" colorscheme archery


" enable true colors support
 set termguicolors
" set opacity
" hi Normal guibg=NONE ctermbg=NONE




""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" lightline config
" let g:lightline = {
"       \ 'colorscheme': 'darcula',
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ],
"       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
"       \ },
"       \ 'component_function': {
"       \   'gitbranch': 'FugitiveHead'
"       \ },
"       \ }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Show the mode you are on the last line
" set showmode

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
" set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Enable plugins and load plugin for the detected file type.
" filetype plugin on
