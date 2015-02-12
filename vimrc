set t_Co=256
syntax on
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif
set cursorline
set showcmd
set number
set hidden
set hlsearch
set backspace=2
let mapleader=","
autocmd Filetype html setlocal ts=4 sts=4 sw=4 omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType javascript setlocal ts=4 sts=4 sw=4
autocmd FileType python setlocal ts=4 sts=4 sw=4
autocmd FileType css setlocal ts=4 noet sw=4 omnifunc=csscomplete#CompleteCSS
autocmd bufread *.coffee set ft=coffee
autocmd bufread *.less set ft=less
autocmd bufread *.md set ft=markdown

" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    Bundle 'gmarik/vundle.vim'
    Bundle 'szw/vim-ctrlspace'
    Bundle 'myusuf3/numbers.vim'
    Bundle 'scrooloose/syntastic'
    Bundle 'mileszs/ack.vim'
    Bundle 'scrooloose/nerdtree'
    Bundle 'kien/ctrlp.vim'
    Bundle 'JazzCore/ctrlp-cmatcher'
    Bundle 'jasoncodes/ctrlp-modified.vim'
    Bundle 'tpope/vim-surround'
    Bundle 'tpope/vim-fugitive'
    Bundle 'tpope/vim-eunuch'
    Bundle 'vim-scripts/taglist.vim'
    Bundle 'hail2u/vim-css3-syntax'
    Bundle 'kchmck/vim-coffee-script'
    Bundle 'groenewege/vim-less'
    Bundle 'vim-scripts/L9'
    Bundle 'vim-scripts/FuzzyFinder'
    Bundle 'nathanaelkane/vim-indent-guides'
    Bundle 'bling/vim-airline'
    Bundle 'rstacruz/sparkup'
    Bundle 'tomtom/tcomment_vim'
    Bundle 'SirVer/ultisnips'
    Bundle 'honza/vim-snippets'
    Bundle 'vim-scripts/argtextobj.vim'
    Bundle 'vim-scripts/pydoc.vim'
    Bundle 'junegunn/vim-easy-align'
    Bundle 'bronson/vim-trailing-whitespace'
    Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif
" Setting up Vundle - the vim plugin bundler end

set laststatus=2

filetype plugin indent on

inoremap jj <Esc>
nnoremap <leader>m :w <BAR> !lessc %:t:r.css<CR><space>
nnoremap <F5> :buffers<CR>:buffer<Space>
nmap <leader>ne :NERDTree<cr>
nmap <leader>nt :NERDTree<cr>
nmap <leader>nq :NERDTreeClose<cr>
map <leader>n :bn<cr>
map <leader>p :bp<cr>
nmap <silent> <leader>l :set list!<CR>
map <silent> <leader>/ :let @/ = ""<CR>

set listchars=tab:▸\ ,eol:¬

let g:numbers_exclude = ['tagbar', 'gundo', 'minibufexpl', 'nerdtree']

let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore = ['\.pyc$']

hi MBEVisibleActive guifg=#a6db29 guibg=fg
hi MBEVisibleChangedActive guifg=#f1266f guibg=fg
hi MBEVisibleChanged guifg=#f1266f guibg=fg
hi MBEVisibleNormal guifg=#5dc2d6 guibg=fg
hi MBEChanged guifg=#cd5907 guibg=fg
hi MBENormal guifg=#808080 guibg=fg

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=238
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236
let &colorcolumn="110,".join(range(116,999),",")

let g:syntastic_check_on_open = 1

let g:syntastic_python_checkers = ['pylint']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

let g:airline_powerline_fonts = 1
let g:airline_detect_modified = 1
let g:airline_theme="dark"
" Required for CtrlSpace integration
let g:airline_exclude_preview = 1
" End CtrlSpace integration
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'x', 'z', 'warning' ]
    \ ]

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|site-packages|node_modules)$',
    \ 'file': '\v\.(exe|so|dll|pyc|debug\.js|simple\.js)$',
    \ 'link': 'some_bad_symbolic_links',
    \ }
let g:ctrlp_reuse_window = 'startify'

let g:clang_library_path = '/usr/lib/llvm-3.2/lib/'

let g:airline#extensions#default#layout = [
      \ [ 'a', 'b', 'c' ],
      \ [ 'x', 'z' ]
      \ ]

let g:ctrlspace_project_root_markers = [".git", ".hg", ".svn", ".bzr", "_darcs", "CVS", "proj.sln"]

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsEditSplit="vertical"
let g:ultisnips_python_style="sphinx"

set viminfo='100,n$HOME/.vim/files/info/viminfo

function! NumberOfWindows()
  let i = 1
  while winbufnr(i) != -1
  let i = i+1
  endwhile
  return i - 1
endfunction

function! DonotQuitLastWindow()
  if NumberOfWindows() != 1
    let v:errmsg = ""
    silent! quit
    if v:errmsg != ""
        "echohl ErrorMsg | echomsg v:errmsg | echohl NONE
        "echoerr v:errmsg
        echohl ErrorMsg | echo v:errmsg | echohl NONE
    endif
  else
     echohl Error | echo "Can't quit the last window..." | echohl None
  endif
endfunction

if has("gui_running")
    cnoreabbrev <expr> q getcmdtype() == ":" && getcmdline() == 'q' ? 'call DonotQuitLastWindow()' : 'q'
    cnoreabbrev <expr> qa getcmdtype() == ":" && getcmdline() == 'qa' ? 'call DonotQuitLastWindow()' : 'qa'
endif

set bg=dark
colorscheme Tomorrow-Night-Eighties
" let g:zenburn_alternate_Visual=1
" let g:zenburn_force_dark_Background=1

hi Search ctermfg=237 ctermbg=13
hi MatchParen cterm=underline
hi SyntasticWarning ctermbg=yellow ctermfg=black
hi SyntasticError ctermbg=red ctermfg=black

hi CtrlSpaceSelected term=reverse ctermfg=187  ctermbg=23  cterm=bold
hi CtrlSpaceNormal   term=NONE    ctermfg=244  ctermbg=232 cterm=NONE
hi CtrlSpaceSearch   ctermfg=220  ctermbg=NONE cterm=bold
hi CtrlSpaceStatus   ctermfg=230  ctermbg=234  cterm=NONE

