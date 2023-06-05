alias sudo='nocorrect sudo'
alias man='LC_ALL=C LANG=C man'
alias ll='ls -al'

if [[ $platform == 'linux' ]]; then
    alias ls='ls --color=auto -Gp '
elif [[ $platform == 'osx' ]]; then
    alias ls='ls -Gp'
fi

# Never offer to correct vim to .vim
alias vim='nocorrect vim '

# Alias neovim to vim if available
if (( $+commands[nvim] )); then
    alias vim='nocorrect nvim '
fi

# I never don't want to SSH
alias ssh='nocorrect ssh '

# Handy git shortcuts
if (( $+commands[git] )); then
  alias git='nocorrect git '
  alias gst='nocorrect git status '
  alias gco='nocorrect git commit '
  # Auto clone a repo URL
  alias -s git="git clone"
fi

if (( $+commands[aptitude] )); then
  alias aptitude='nocorrect aptitude '
fi

# On Ubuntu/Debian systems, the Ack I care about is packaged as ack-grep
if (( $+commands[ack-grep] )); then
  alias ack='ack-grep'
fi

# Always pipe ag results through less
if (( $+commands[ag] )); then
  alias ag='ag --pager="less -FRSX"'
fi

if (( $+commands[xclip] )); then
  alias xclip='nocorrect xclip -sel clip'
fi

# Default to the shared clipboard
if (( $+commands[xclip] )); then
  alias xclip='nocorrect xclip -sel clip'
fi

if (( $+commands[poetry] )); then
    alias pvenv='source $(poetry env info --path)/bin/activate'
fi
