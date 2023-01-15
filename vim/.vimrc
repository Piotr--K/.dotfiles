set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'yantze/pt_black'
Plugin 'jpalardy/vim-slime'
Plugin 'vim-ruby/vim-ruby'
Plugin 'thoughtbot/vim-rspec'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-endwise'
Plugin 'luochen1990/rainbow'
Plugin 'tpope/vim-fugitive'
Plugin 'guns/vim-sexp'
Plugin 'tpope/vim-sexp-mappings-for-regular-people'
Plugin 'pangloss/vim-javascript'
Plugin 'w0rp/ale'
Plugin 'prettier/vim-prettier'
Plugin 'mileszs/ack.vim'
Plugin 'leshill/vim-json'
Plugin 'leafgarland/typescript-vim'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
if has('nvim')
  " NeoVim specific commands
	Plugin 'Olical/conjure'
else
    " Standard Vim specific commands
endif

call vundle#end()

filetype plugin indent on
set background=dark
syntax enable
set term=xterm-256color
colorscheme ir_black
set backspace=2

" vim-slime configuration
" 3-rd line default setting to not being prompted for each buffer, if needs to
" be reset call :SlimeConfig
let g:slime_target = "tmux"
let g:rspec_command = 'call Send_To_Tmux("rspec {spec}\n")'
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" vim-rainbow configuration
let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle

set nowrap	 " don't wrap lines
set tabstop=2	 " a tab is 2 spaces
set autoindent	 " always set autoindenting on
set number	 " always show line numbers
set shiftwidth=2 " number of spaces used for autoindenting
set showmatch	 " set show matching parenthesis
set ignorecase	 " ingore case when searching
set hlsearch	 " highlight sarch terms
set incsearch	 " show search matches as you type
set nobackup	 " don't let vim to backup files use git!
set noswapfile	 " as above
set splitbelow " by default new split is opened below
set termwinsize=6x0 " terminal window size
let mapleader = "/"


"Rspec.vim mappings
map <leader>t :call RunCurrentSpecFile()<CR>
map <leader>s :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>a :call RunAllSpecs()<CR>

highlight Cursor guifg=yellow guibg=black
set guicursor=n-v-c:block-Cursor

:hi CursorLine  cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi Cursor  cterm=NONE ctermbg=darkcyan ctermfg=white guibg=darkcyan guifg=white
:nnoremap <leader>c :set cursorline!<CR>
