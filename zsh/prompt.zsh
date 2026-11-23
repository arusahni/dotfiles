setopt prompt_subst
autoload -Uz add-zsh-hook

# Add a newline between prompts
_precmd_newline_between_prompts() {
  $funcstack[1]() {
    echo
  }
}

add-zsh-hook precmd _precmd_newline_between_prompts
# Remove the old hook when reloading this file in an existing shell.
add-zsh-hook -d precmd vcs_info

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

get_jujutsu_prompt() {
    local jj_status line bookmark dirty ahead
    local -i ahead_count=0
    local -a revisions
    # Pick the closest bookmarked ancestor; break merge ties by timestamp.
    # Include it and all commits ahead of it in one read-only query.
    # Ahead excludes undescribed commits with no described descendant.
    jj_status=$(command jj log --ignore-working-copy --no-graph --color never --no-pager \
        --config 'revset-aliases."prompt_base()"="latest(heads(::@ & bookmarks()))"' \
        --config 'revset-aliases."prompt_ahead()"="prompt_base()..@ & ::(prompt_base()..@ ~ description(exact:\"\"))"' \
        -r '(coalesce(prompt_base(), @)..@) | coalesce(prompt_base(), @)' \
        -T 'if(current_working_copy && !empty && !description, "D", "-") ++ if(!empty && self.contained_in("prompt_ahead()"), "A", "-") ++ "\t" ++ if(self.contained_in("prompt_base()"), bookmarks.join(" ")) ++ "\n"' \
        2> /dev/null) || return
    revisions=("${(@f)jj_status}")
    for line in "${revisions[@]}"; do
        [[ ${line[1]} == D ]] && dirty=$_git_modified
        # Empty commits (including the usual empty @) do not count as ahead.
        [[ ${line[2]} == A ]] && (( ++ahead_count ))
        [[ -n ${line#*$'\t'} ]] && bookmark=${line#*$'\t'}
    done
    # Without an ancestor bookmark, show @ and just the description marker.
    if [[ -n $bookmark ]]; then
        (( ahead_count > 0 )) && ahead="${_git_ahead}${ahead_count} "
    else
        bookmark=@
    fi
    print -r -- "${_git_symbol}${_gprefix}${ahead}%F{003}${bookmark//\%/%%}${dirty}${_gsuffix}"
}

git_prompt() {
    local root=$PWD git_dir
    # Find the nearest repository without spawning Git or jj outside one.
    while [[ ! -d "$root/.jj" && ! -e "$root/.git" ]]; do
        [[ $root == / ]] && return
        root=${root:h}
    done
    if [[ -d "$root/.jj" ]]; then
        get_jujutsu_prompt
        return
    fi

    # One read-only query supplies the branch, divergence and tracked changes.
    local git_status line branch oid ahead behind modified staged
    local -a gitstatus counts
    git_status=$(GIT_OPTIONAL_LOCKS=0 command git status --porcelain=v2 \
        --branch --untracked-files=no --ignore-submodules=dirty 2> /dev/null) || return
    for line in "${(@f)git_status}"; do
        case $line in
            '# branch.head '*) branch=${line#\# branch.head } ;;
            '# branch.oid '*) oid=${line#\# branch.oid } ;;
            '# branch.ab '*)
                counts=(${=line})
                ahead=${counts[3]#+}
                behind=${counts[4]#-}
                ;;
            [12]' '*)
                [[ ${line[3]} != . ]] && staged=$_git_staged
                [[ ${line[4]} != . ]] && modified=$_git_modified
                ;;
            'u '*) staged=$_git_staged; modified=$_git_modified ;;
        esac
    done
    [[ $branch == '(detached)' ]] && branch=${oid[1,7]}
    (( ahead > 0 )) && gitstatus+=( "${_git_ahead}${ahead}" )
    (( behind > 0 )) && gitstatus+=( "${_git_behind}${behind}" )

    git_dir=$root/.git
    if [[ -f $git_dir ]]; then
        git_dir=$(< "$git_dir")
        git_dir=${git_dir#gitdir: }
        [[ $git_dir == /* ]] || git_dir=$root/$git_dir
    fi
    [[ -r "$git_dir/MERGE_HEAD" ]] && gitstatus+=( "$_git_merging" )
    print -r -- "${_git_symbol}${_gprefix}${(j: :)gitstatus} %F{003}${branch//\%/%%}${modified}${staged}${_gsuffix}"
}

# Set the left-hand prompt
export PS1=${_headerline}$'\n'${_inputline}
# Set the right-hand prompt
export RPS1='%{$(echotc UP 1)%}$(git_prompt) $_base_right_prompt%{$(echotc DO 1)%}'
