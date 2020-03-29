"------------------------------------------------------------
" Vundle (this block must be on top)
"------------------------------------------------------------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'preservim/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'morhetz/gruvbox'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"------------------------------------------------------------
" Features
"------------------------------------------------------------
syntax on                   " enable syntax processing
colorscheme gruvbox         " best colorscheme ay
set background=dark

"------------------------------------------------------------
" Indentation options
"------------------------------------------------------------
set expandtab               "Use softtabstop spaces instead of tab characters for indentation
set shiftwidth=4            "Indent by 4 spaces when using >>, <<, == etc.
set softtabstop=4           "Indent by 4 spaces when pressing <TAB>
set autoindent              "Keep indentation from previous line
set smartindent             "Automatically inserts indentation in some cases
set cindent                 "Like smartindent, but stricter and more customisable

"------------------------------------------------------------
" Must Have options
"------------------------------------------------------------
set number                  " show line numbers
set showcmd                 " show command in bottom bar
set cursorline              " highlight current line
set wildmenu                " visual autocomplete for command menu
set showmatch               " highlight matching [{()}]
set incsearch               " search as characters are entered
set hlsearch                " highlight matches
set ruler                   " Display the cursor position

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

"------------------------------------------------------------
" Plugin stuff
"------------------------------------------------------------
set encoding=utf-8
set completeopt-=preview
set rtp+=~/.fzf

map <C-n> :NERDTreeToggle<CR>

if executable('fzf')
  " Remap ctrl-P to execute fzf :)
  nnoremap <silent> <C-p> :Files<CR>

  command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
endif

if executable('rg')
  " Space key will open up search.
  nnoremap <Space> :Rg<CR>
  nnoremap <leader><Space> :Rg!<CR> " Leader key is \ so \ and space

  " Use rg for :grep if available. But we should prefer to use :Rg.
  set grepprg=rg\ --vimgrep\ --color=never\ --no-heading\ --hidden

  let $FZF_DEFAULT_COMMAND = 'rg --hidden -l ""'

  " ripgrep preview. use ? to show if without bang
  command! -bang -nargs=* Rg
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
    \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
    \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
    \   <bang>0)
endif

"------------------------------------------------------------
" Mappings and Key Bindings
"------------------------------------------------------------
" Make double-<Esc> clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" Use <F2> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F2>

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Search and highlighting fix with gruvbox dark
nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>
nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?
