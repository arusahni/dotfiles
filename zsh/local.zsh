function setjdk() {
    if [ $# -ne 0 ]; then
        removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'
        if [ -n "${JAVA_HOME+x}" ]; then
            removeFromPath $JAVA_HOME
        fi
        export JAVA_HOME=`/usr/libexec/java_home -v $@`
        export PATH=$JAVA_HOME/bin:$PATH
    fi
}
function removeFromPath() {
    export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")
}

export PROJECT_HOME=$HOME/Devel
export CFLAGS=-Qunused-arguments
export CPPFLAGS=-Qunused-arguments
export HOMEBREW_GITHUB_API_TOKEN=51fab0590078b756dda1a54bfe1107ffc6eef98a
export JAVA_HOME="$(/usr/libexec/java_home)"
source /usr/local/share/zsh/site-functions/_aws
# export AWS_ACCESS_KEY="AKIAJCO3CYTLM3DF2GHQ"
# export AWS_SECRET_ACCESS_KEY="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"
export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.6.13.0/libexec"
export WMATA_API_KEY="9m3wkmu8crcqp27r6nmnyc2n"
setjdk 1.8

# DCTC specific configuration
# export MAVEN_OPTS="-Xmx1024m -XX:MaxPermSize=512m"
# export CONFIG_DIR="/opt/bedrock/config"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:/opt/puppetlabs/bin:$PATH"

### Added by RVM
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

source ~/.zsh/git-flow-completion.zsh

# eval "$(pyenv init -)"
# export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"

export HTML_TIDY=~/code/dotfiles/htmltidy5.config.txt

export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"
