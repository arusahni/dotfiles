set t_Co=256
colorscheme zenburn
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set clipboard=unnamedplus
" call pathogen#infect()
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmaarik/vundle'

Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-surround'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'groenewege/vim-less'
Bundle 'jnurmine/Zenburn'
Bundle 'vim-scripts/FuzzyFinder'

inoremap jj <Esc>
nnoremap ,m :w <BAR> !lessc %:t:r.css<CR><space>

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 
