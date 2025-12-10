vim.cmd([[
hi Search ctermfg=237 ctermbg=13
hi MatchParen cterm=underline
hi SyntasticWarning ctermbg=yellow ctermfg=black
hi ALEWarning ctermbg=yellow ctermfg=black
hi SyntasticError ctermbg=red ctermfg=black
hi ALEError ctermbg=red ctermfg=black
hi CocUnderline term=undercurl
hi DiagnosticError ctermfg=red guifg=red term=undercurl cterm=undercurl
hi DiagnosticUnderlineError guisp=red
hi DiagnosticWarn ctermfg=yellow guifg=yellow term=undercurl cterm=undercurl
hi DiagnosticUnderlineWarn guisp=yellow
hi CocInlayHint guibg=NONE guifg=#6F7378 ctermbg=NONE ctermfg=DarkGray
hi LspInlayHint guibg=NONE guifg=#6F7378 ctermbg=NONE ctermfg=DarkGray

hi CtrlSpaceSelected term=reverse ctermfg=187  ctermbg=23  cterm=bold
hi CtrlSpaceNormal   term=NONE    ctermfg=244  ctermbg=232 cterm=NONE
hi CtrlSpaceSearch   ctermfg=220  ctermbg=NONE cterm=bold
hi CtrlSpaceStatus   ctermfg=230  ctermbg=234  cterm=NONE
]])
