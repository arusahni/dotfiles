# export FZF_DEFAULT_COMMAND='ag -g ""'

FILE=/usr/share/fzf/key-bindings.zsh && test -f $FILE && source $FILE
FILE=/usr/share/fzf/completions.zsh && test -f $FILE && source $FILE
FILE=~/.fzf.zsh && test -f $FILE && source $FILE

export FZF_DEFAULT_COMMAND='rg --files --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
