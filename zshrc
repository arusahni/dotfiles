######################################################################
#           jdong's zshrc file v0.2.1 , based on:
#		      mako's zshrc file, v0.1
#
#
######################################################################
# next lets set some enviromental/shell pref stuff up
# setopt NOHUP
#setopt NOTIFY
#setopt NO_FLOW_CONTROL
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
# setopt AUTO_LIST		# these two should be turned off
# setopt AUTO_REMOVE_SLASH
# setopt AUTO_RESUME		# tries to resume command of same name
unsetopt BG_NICE		# do NOT nice bg commands
setopt CORRECT			# command CORRECTION
setopt EXTENDED_HISTORY		# puts timestamps in the history
# setopt HASH_CMDS		# turns on hashing
#
setopt MENUCOMPLETE
setopt ALL_EXPORT

# Set/unset  shell options
setopt   notify #Report the status of background jobs immediately, rather than waiting until just before printing a prompt.
#setopt   globdots #Do not require a leading ‘.’ in a filename to be matched explicitly.
setopt   correct
setopt   pushdtohome
setopt   cdablevars
setopt   autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
    platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='osx'
fi

# Autoload zsh modules when they are referenced
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload zsh/zprof
zmodload -ap zsh/mapfile mapfile

if (( $+commands[dircolors] )); then
    eval $(dircolors ~/.dircolors)
fi

PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin/:/bin:/sbin:/usr/bin:/usr/sbin:$PATH"
TZ="America/New_York"
HISTFILE=$HOME/.zhistory
HISTSIZE=1000
SAVEHIST=1000
HOSTNAME="`hostname`"
PAGER='less'
EDITOR='vim'
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
   colors
fi
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
    eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
    eval PR_BOLD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
    eval PR_LIGHT_$COLOR='%{$fg[${(L)COLOR}]%}'
    export PR_$COLOR PR_BOLD_$COLOR PR_LIGHT_$COLOR
done
PR_NO_COLOR="%{$terminfo[sgr0]%}"
PS1="[$PR_BLUE%n$PR_WHITE@$PR_GREEN%m$PR_NO_COLOR:$PR_RED%2c$PR_NO_COLOR]%(!.#.$) "
RPS1="$PR_LIGHT_YELLOW(%D{%m-%d %H:%M})$PR_NO_COLOR"
#LANGUAGE=
LC_ALL='en_US.UTF-8'
LANG='en_US.UTF-8'
LC_CTYPE=C

REPORTTIME=10 # Display the `time` command output for a command if takes longer than this number of seconds

unsetopt ALL_EXPORT
# # --------------------------------------------------------------------
# # aliases
# # --------------------------------------------------------------------
alias sudo='nocorrect sudo'
alias man='LC_ALL=C LANG=C man'
alias ll='ls -al'
if [[ $platform == 'linux' ]]; then
    alias ls='ls --color=auto -Gp '
elif [[ $platform == 'osx' ]]; then
    alias ls='ls -Gp'
fi
autoload -U compinit
compinit

# if [[ $platform == 'linux' ]]; then
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
if [[ $platform == 'osx' ]]; then
    bindkey "^[[1;5C" forward-word
    bindkey "^[[1;5D" backward-word
    bindkey "^A" beginning-of-line
    bindkey "^E" end-of-line
    bindkey "^[[3~" delete-char
    bindkey "^[[H" beginning-of-line
    bindkey "^[[F" end-of-line
fi
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Completion Styles

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

# allow one error for every three characters typed in approximate completer
zstyle -e ':completion:*:approximate:*' max-errors \
    'reply=( $(( ($#PREFIX+$#SUFFIX)/2 )) numeric )'

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
# on processes completion complete all user processes
# zstyle ':completion:*:processes' command 'ps -au$USER'

## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

#zstyle ':completion:*:processes' command 'ps ax -o pid,s,nice,stime,args | sed "/ps/d"'
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:processes-names' command 'ps axho command'
#zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
#
#NEW completion:
# 1. All /etc/hosts hostnames are in autocomplete
# 2. If you have a comment in /etc/hosts like #%foobar.domain,
#    then foobar.domain will show up in autocomplete!
zstyle ':completion:*' hosts $(awk '/^[^#]/ {print $2 $3" "$4" "$5}' /etc/hosts | grep -v ip6- && grep "^#%" /etc/hosts | awk -F% '{print $2}')
# Filename suffixes to ignore during completion (except after rm command)
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns '*?.o' '*?.c~' \
    '*?.old' '*?.pro' '*?.pyc' '*?.py~'
# the same for old style completion
#fignore=(.o .c~ .old .pro)

# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
        named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs avahi-autoipd\
        avahi backup messagebus beagleindex debian-tor dhcp dnsmasq fetchmail\
        firebird gnats haldaemon hplip irc klog list man cupsys postfix\
        proxy syslog www-data mldonkey sys snort
# SSH Completion
zstyle ':completion:*:scp:*' tag-order \
   files users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:scp:*' group-order \
   files all-files users hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order \
   users 'hosts:-host hosts:-domain:domain hosts:-ipaddr"IP\ Address *'
zstyle ':completion:*:ssh:*' group-order \
   hosts-domain hosts-host users hosts-ipaddr
zstyle '*' single-ignored show

### ALIASES
alias vim='nocorrect vim '
if (( $+commands[nvim] )); then
    alias vim='nocorrect nvim '
fi
alias ssh='nocorrect ssh '
if (( $+commands[git] )); then
  alias git='nocorrect git '
  alias gst='nocorrect git status '
  alias gco='nocorrect git commit '
fi
if (( $+commands[aptitude] )); then
  alias aptitude='nocorrect aptitude '
fi
if (( $+commands[ack-grep] )); then
  alias ack='ack-grep'
fi
if (( $+commands[ag] )); then
  alias ag='ag --pager="less -FRSX"'
fi
if (( $+commands[xclip] )); then
  alias xclip='nocorrect xclip -sel clip'
fi

### ENV
SCRIPT_SOURCE=${0%/*}
#if [[ $SCRIPT_SOURCE -eq 'zsh' ]]; then
RELPATH="code/dotfiles"
if [[ $platform == 'linux' ]]; then
    SCRIPT_SOURCE=/home/aru/"$RELPATH"
elif [[ $platform == 'osx' ]]; then
    SCRIPT_SOURCE=/Users/aru/"$RELPATH"
fi
#fi
### PLUGINS
function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '['`basename $VIRTUAL_ENV`'] '
}
if [[ $platform == 'linux' &&  -e "$SCRIPT_SOURCE/blur_console.sh" ]]; then
    source $SCRIPT_SOURCE/blur_console.sh
fi
if [[ -e "$SCRIPT_SOURCE/local.sh" ]]; then
    source $SCRIPT_SOURCE/local.sh
fi
if [[ -n $+commands[virtualenvwrapper.sh] || -e "/usr/share/virtualenvwrapper/virtualenvwrapper.sh" ]]; then
    export WORKON_HOME=$HOME/.virtualenvs
    if [[ -e "/usr/share/virtualenvwrapper/virtualenvwrapper.sh" ]]; then
        source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
    else
        source /usr/local/bin/virtualenvwrapper.sh
    fi
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export PIP_RESPECT_VIRTUALENV=true
fi
# Adapted from code found at <https://gist.github.com/1712320>.

setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt

# Modify the colors and symbols in these variables as desired.
GIT_PROMPT_SYMBOL="%{$fg[blue]%}±"
GIT_PROMPT_PREFIX="%{$fg[green]%}[%{$reset_color%}"
GIT_PROMPT_SUFFIX="%{$fg[green]%}]%{$reset_color%}"
GIT_PROMPT_AHEAD="%{$fg[red]%}ANUM%{$reset_color%}"
GIT_PROMPT_BEHIND="%{$fg[cyan]%}BNUM%{$reset_color%}"
GIT_PROMPT_MERGING="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}●%{$reset_color%}"
GIT_PROMPT_MODIFIED="%{$fg_bold[yellow]%}●%{$reset_color%}"
GIT_PROMPT_STAGED="%{$fg_bold[green]%}●%{$reset_color%}"

# Show Git branch/tag, or name-rev if on detached head
parse_git_branch() {
    (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}

# Show different symbols as appropriate for various Git repository states
parse_git_state() {

    # Compose this value via multiple conditional appends.
    local GIT_STATE=""

    local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_AHEAD" -gt 0 ]; then
        GIT_STATE=$GIT_STATE${GIT_PROMPT_AHEAD//NUM/$NUM_AHEAD}
    fi

    local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    if [ "$NUM_BEHIND" -gt 0 ]; then
        GIT_STATE=$GIT_STATE${GIT_PROMPT_BEHIND//NUM/$NUM_BEHIND}
    fi

    local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
    if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_MERGING
    fi

    if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_UNTRACKED
    fi

    if ! git diff --quiet 2> /dev/null; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_MODIFIED
    fi

    if ! git diff --cached --quiet 2> /dev/null; then
        GIT_STATE=$GIT_STATE$GIT_PROMPT_STAGED
    fi

    if [[ -n $GIT_STATE ]]; then
        echo "$GIT_PROMPT_PREFIX$GIT_STATE$GIT_PROMPT_SUFFIX"
    fi
}

# If inside a Git repository, print its branch and state
git_prompt_string() {
    local git_where="$(parse_git_branch)"
    [ -n "$git_where" ] && echo "$GIT_PROMPT_SYMBOL$(parse_git_state)$GIT_PROMPT_PREFIX%{$fg[yellow]%}${git_where#(refs/heads/|tags/)}$GIT_PROMPT_SUFFIX"
}

# Set the right-hand prompt
_BASE_RPS1="$RPS1"
RPS1='$(git_prompt_string) $_BASE_RPS1'

if [[ $platform == 'linux' ]]; then
    export TERM="xterm-256color"
    stty -ixon
fi

export FZF_DEFAULT_COMMAND='ag -g ""'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
