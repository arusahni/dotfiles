source ~/.zsh/colors.zsh
source ~/.zsh/setopt.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/prompt.zsh
source ~/.zsh/completion.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/bindkeys.zsh
source ~/.zsh/history.zsh
source ~/.zsh/hooks.zsh
source ~/.zsh/virtualenv.zsh
source ~/.zsh/fzf.zsh
source ~/.zsh/blur.zsh

if [[ -e "$HOME/.zsh/local.zsh" ]]; then
    source ~/.zsh/local.zsh
fi
