vim.cmd([[
let g:airline_powerline_fonts = 1
let g:airline_detect_modified = 1
let g:airline_theme="base16"
" Required for CtrlSpace integration
let g:airline_exclude_preview = 1
" End CtrlSpace integration
let g:airline#extensions#branch#format = 1
let g:airline#extensions#branch#displayed_head_limit = 10
let g:airline#extensions#whitespace#enabled=0
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'x', 'z', 'warning', 'error' ]
    \ ]
]])
