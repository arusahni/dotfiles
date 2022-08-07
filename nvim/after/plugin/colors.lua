local hi = vim.highlight.create

vim.cmd([[
let base16colorspace=256
colorscheme base16-onedark

hi Search ctermfg=237 ctermbg=13
hi MatchParen cterm=underline
hi SyntasticWarning ctermbg=yellow ctermfg=black
hi ALEWarning ctermbg=yellow ctermfg=black
hi SyntasticError ctermbg=red ctermfg=black
hi ALEError ctermbg=red ctermfg=black
hi CocUnderline term=undercurl
hi CocErrorHighlight ctermfg=red term=undercurl
hi CocWarningHighlight ctermfg=yellow term=undercurl

hi CtrlSpaceSelected term=reverse ctermfg=187  ctermbg=23  cterm=bold
hi CtrlSpaceNormal   term=NONE    ctermfg=244  ctermbg=232 cterm=NONE
hi CtrlSpaceSearch   ctermfg=220  ctermbg=NONE cterm=bold
hi CtrlSpaceStatus   ctermfg=230  ctermbg=234  cterm=NONE
]])
