autoload colors; colors

if (( $+commands[dircolors] )); then
    eval $(dircolors ~/.dircolors)
fi

for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
    eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
    eval PR_LIGHT_$COLOR='%{$fg[${(L)COLOR}]%}'
    export PR_$COLOR PR_BOLD_$COLOR PR_LIGHT_$COLOR
done

eval RESET='$reset_color'

unset LSCOLORS
export CLICOLOR=1
export LS_COLORS=exfxcxdxbxegedabagacad
export LSCOLORS=$LS_COLORS
