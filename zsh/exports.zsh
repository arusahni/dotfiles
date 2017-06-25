export TERM="xterm-256color"
export PATH="$HOME/bin:/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin:$PATH"
export TZ="America/New_York"
export HOSTNAME="$(hostname)"
export PAGER=less
export EDITOR=nvim

export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_CTYPE=C

# Display the `time` command output for a command if takes longer than this number of seconds
export REPORTTIME=10

export ANSIBLE_NOCOWS=1

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
    platform='linux'
elif [[ "$unamestr" == 'FreeBSD' ]]; then
    platform='freebsd'
elif [[ "$unamestr" == 'Darwin' ]]; then
    platform='osx'
fi
export $platform
