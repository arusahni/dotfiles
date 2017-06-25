bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey "^[[3~" delete-char
bindkey "^[3;5~" delete-char
bindkey "^[[2~" overwrite-mode
bindkey "^?" backward-delete-char
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^r" history-incremental-search-backward

# also do history expansion on space
bindkey ' ' magic-space

# complete on tab, leave expansion to _expand
bindkey '^I' complete-word

# Default to standard emacs bindings, regardless of editor string
bindkey -e

if [[ "$platform" == 'osx' ]]; then
    bindkey "^[[1;5C" forward-word
    bindkey "^[[1;5D" backward-word
    bindkey "^A" beginning-of-line
    bindkey "^E" end-of-line
    bindkey "^[[3~" delete-char
    bindkey "^[[H" beginning-of-line
    bindkey "^[[F" end-of-line
fi

# Disable ^S suspensio
stty -ixon
