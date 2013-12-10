set number

set nocompatible

execute pathogen#infect()

filetype off

set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'msanders/snipmate.vim'

Bundle 'flazz/vim-colorschemes'
colorscheme wombat256

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
" gitk for vim
Bundle 'gregsexton/gitv'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/nerdtree'
" Bundle 'ervandew/supertab'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'Raimondi/delimitMate'
Bundle 'mattn/emmet-vim'
Bundle 'vim-scripts/IndexedSearch'
Bundle 'plasticboy/vim-markdown'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tomtom/tcomment_vim'
" Bundle 'Yggdroot/indentLine'
" Bundle 'git://git.wincent.com/command-t.git'
Bundle 'bronson/vim-trailing-whitespace'
Bundle 'tpope/vim-unimpaired'
Bundle 'majutsushi/tagbar'
Bundle 'chrisbra/NrrwRgn'
Bundle 'Shougo/neocomplcache.vim'
" Vim plugin for the_silver_searcher, 'ag'
Bundle 'rking/ag.vim'
" to interact with tmux
Bundle 'benmills/vimux'
" tmux syntax
Bundle 'zaiste/tmux.vim'
" Format and validate JSON files
Bundle 'alfredodeza/jacinto.vim'
Bundle 'zaiste/VimClojure'
Bundle 'Shougo/unite.vim'

set runtimepath+=~/git/vim-addon-manager/
call vam#ActivateAddons(['powerline'], {'auto_install' : 0})

Bundle 'mattn/webapi-vim'
Bundle 'mattn/gist-vim'

Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "garbas/vim-snipmate"

" Optional:
Bundle "honza/vim-snippets"

syntax on
filetype plugin indent on

