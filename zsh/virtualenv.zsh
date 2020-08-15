function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '['$(basename $VIRTUAL_ENV)'] '
}

if [[ -n $+commands[virtualenvwrapper.sh] || -e "/usr/share/virtualenvwrapper/virtualenvwrapper.sh" ]]; then
    export WORKON_HOME=$HOME/.virtualenvs
    if [[ -e "/usr/share/virtualenvwrapper/virtualenvwrapper.sh" ]]; then
        source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
    elif [[ -e "/usr/bin/virtualenvwrapper.sh" ]]; then
        source /usr/bin/virtualenvwrapper.sh
    else
        source /usr/local/bin/virtualenvwrapper.sh
    fi
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    export PIP_RESPECT_VIRTUALENV=true
fi

if [[ -n $+commands[virtualenvwrapper.sh] ]]; then
    if [[ -n $+commands[pyenv] ]]; then
        export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
        eval "$(pyenv init -)"
    fi
fi
