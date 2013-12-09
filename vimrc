set t_Co=256
colorscheme zenburn
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set clipboard=unnamedplus
set showcmd
set number
set hidden
autocmd Filetype html setlocal ts=4 noet sw=4
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype css setlocal ts=4 sts=4 sw=4
autocmd bufread *.less set ft=less

" call pathogen#infect()
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmaarik/vundle'

Bundle 'scrooloose/syntastic'
Bundle 'mileszs/ack.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'jasoncodes/ctrlp-modified.vim'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/taglist.vim'
Bundle 'bling/vim-bufferline'
Bundle 'hail2u/vim-css3-syntax'
Bundle 'groenewege/vim-less'
Bundle 'jnurmine/Zenburn'
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/FuzzyFinder'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'bling/vim-airline'
"set rtp+=~/code/dotfiles/powerline/powerline/bindings/vim
set laststatus=2

let g:zenburn_alternate_Visual=1
let g:zenburn_force_dark_Background=1

filetype plugin indent on

inoremap jj <Esc>
nnoremap ,m :w <BAR> !lessc %:t:r.css<CR><space>
nnoremap <F5> :buffers<CR>:buffer<Space>
nmap <leader>ne :NERDTree<cr>
nmap <leader>nt :NERDTree<cr>

let g:NERDTreeChDirMode = 2

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

let g:syntastic_check_on_open = 1

let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#bufferline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_detect_modified=1
let g:airline_theme="dark"

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
