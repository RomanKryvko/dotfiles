" Get the defaults
source $VIMRUNTIME/defaults.vim

" map <Leader>
let g:mapleader = " "

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Text wrapping
set wrap
set linebreak

" Plugins
call plug#begin()

Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdcommenter'
Plug 'morhetz/gruvbox'
Plug 'itchyny/vim-gitbranch'

call plug#end()

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

syntax on

" Line numbers
set number relativenumber

" Colorscheme settings
colorscheme gruvbox
set bg=dark
hi Normal guibg=NONE ctermbg=NONE

" Tabs and indents
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

" X clipboard support
set clipboard=unnamedplus 

" Jump centering
nnoremap <C-d> <C-d>zz0
nnoremap <C-u> <C-u>zz0

" Hide search highlight on ESC
nnoremap <Esc> <cmd>nohlsearch<CR>

" Insert newline without leaving normal mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

set splitright
set splitbelow

set cursorline

set list listchars=tab:>-,trail:·,extends:>,precedes:<,nbsp:␣

" Statusline
set laststatus=2
set noshowmode
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'Gitbranch'
      \ },
      \ }
function Gitbranch()
  let head = gitbranch#name()
  if head != ""
    let head = "\ue0a0 " .. head
  endif
  return head
endfunction
