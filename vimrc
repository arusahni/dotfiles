set t_Co=256
colorscheme zenburn
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set clipboard=unnamedplus
set showcmd

" call pathogen#infect()
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmaarik/vundle'

Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'jasoncodes/ctrlp-modified.vim'
Bundle 'tpope/vim-surround'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'vim-scripts/taglist.vim'
Bundle 'groenewege/vim-less'
Bundle 'jnurmine/Zenburn'
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/FuzzyFinder'

filetype plugin indent on

inoremap jj <Esc>
nnoremap ,m :w <BAR> !lessc %:t:r.css<CR><space>
nnoremap <F5> :buffers<CR>:buffer<Space>
nmap <leader>ne :NERDTree<cr>
nmap <leader>nt :NERDTree<cr>

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 
