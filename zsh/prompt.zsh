setopt prompt_subst
autoload -Uz add-zsh-hook vcs_info

# Add a newline between prompts
_precmd_newline_between_prompts() {
  $funcstack[1]() {
    echo
  }
}

add-zsh-hook precmd _precmd_newline_between_prompts
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*+set-message:*' hooks set-git-metadata

export PR_NO_COLOR="%{$terminfo[sgr0]%}"
_headerline="${FG[006]}%n${PR_WHITE}@${PR_GREEN}%m${PR_NO_COLOR}[${PR_RED}%2c${PR_NO_COLOR}]"
_inputline="%(?..${FG[009]})%(!.#.$)${PR_NO_COLOR} "
_base_right_prompt="${FG[240]}%D{%m-%d %H:%M}$PR_NO_COLOR"

# Git prompt colors and symbols
local ahead_icon=$'\uf176 '
local behind_icon=$'\uf175 '
# Fallback icons for systems without nerdfonts
# ahead_icon="+"
# behind_icon="-"

local _git_symbol="%F{243}%f"
local _git_prefix="%{$fg[green]%}[%{$reset_color%}"
local _git_suffix="%{$fg[green]%}]%{$reset_color%}"
local _git_ahead="%{$fg[red]%}${ahead_icon}%{$reset_color%}"
local _git_behind="%{$fg[cyan]%}${behind_icon}%{$reset_color%}"
local _git_merging="%{$fg_bold[magenta]%}⚡︎%{$reset_color%}"
local _git_untracked="%{$fg_bold[red]%}?%{$reset_color%}"
local _git_modified="%{$fg_bold[yellow]%}*%{$reset_color%}"
local _git_staged="%{$fg_bold[green]%}+%{$reset_color%}"

local _gprefix=' '
local _gsuffix=' '

cond() {
    if [ "$1" ]; then
        echo "$2"
    else
        echo "$3"
    fi
}

zstyle ':vcs_info:*' unstagedstr "${_git_modified}"
zstyle ':vcs_info:*' stagedstr "${_git_staged}"
zstyle ':vcs_info:git:*' formats "${_git_symbol}${_gprefix}%m%F{003}%b%u%c${_gsuffix}"

# Show different symbols as appropriate for various Git repository states
function +vi-set-git-metadata() {
    local ahead behind merging
    local -a gitstatus
    ahead="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
    (( $ahead )) && gitstatus+=( "${_git_ahead}${ahead}" )
    behind="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
    (( $behind )) && gitstatus+=( "${_git_behind}${behind}" )
    local git_dir="$(git rev-parse --git-dir 2> /dev/null)"
    if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
        gitstatus+=( "$_git_merging" )
    fi

    hook_com[misc]+="${(j: :)gitstatus} "
}

get_jujutsu_bookmark() {
    jj log --ignore-working-copy -n 1 --no-graph --color never \
        -r "ancestors(present(@)) & bookmarks()" \
        -T 'bookmarks.join(" ")'
}

git_prompt() {
    jj_bookmark=$(get_jujutsu_bookmark 2> /dev/null)
    if [[ -n "$jj_bookmark" ]]; then
        echo "${_git_symbol}${_gprefix}%F{003}${jj_bookmark}${_gsuffix}"
    else
        echo "${vcs_info_msg_0_}"
    fi
}

# Set the left-hand prompt
export PS1=${_headerline}$'\n'${_inputline}
# Set the right-hand prompt
export RPS1='%{$(echotc UP 1)%}$(git_prompt) $_base_right_prompt%{$(echotc DO 1)%}'
