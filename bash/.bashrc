## [Alias]
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -laG'
alias ls='ls -F --color=auto'

## [history] 全ターミナル間で履歴共有
function share_history {
    history -a
    history -c
    history -r
}
shopt -u histappend
export HISTSIZE=9999

## [Git]
source "$HOME/.git-completion.bash"
source "$HOME/.git-prompt.sh"
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUPSTREAM=auto

## [Prompt 統合]
function custom_prompt_command() {
    _direnv_hook
    share_history
    __git_ps1 "\[\033[32m\]\u@\h \[\033[33m\]\w" "\[\033[0m\]\n\$ " " [%s]"
}
PROMPT_COMMAND=custom_prompt_command
unset PS1  # __git_ps1 が PS1 を自動設定するので不要

## [Homebrew (Mac)]（WSLでは無視される）
# export PATH="/usr/local/bin:$PATH"
# export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

## [Node.js - nodebrew]
export PATH="$HOME/.nodebrew/current/bin:$PATH"
export NODEBREW_ROOT="$HOME/.nodebrew"

## [Python]
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
export PATH="$PATH:$HOME/.local/bin"
eval "$(register-python-argcomplete pipx)"
. "$HOME/.cargo/env"
export PIPENV_VENV_IN_PROJECT=true

## [Kubernetes]
alias kc='kubectl'
alias watch='watch '
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

## [AWS]
complete -C '/usr/local/bin/aws_completer' aws

## [MySQL]
export PATH="$PATH:/usr/local/mysql/bin"

## [direnv]
eval "$(direnv hook bash)"

## [fzf]
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

## [peco]
function peco_search_history() {
  local l=$(HISTTIMEFORMAT= history | \
  sort -r | sed -E s/^\ *[0-9]+\ +// | \
  peco --query "$READLINE_LINE")
  READLINE_LINE="$l"
  READLINE_POINT=${#l}
}
bind -x '"\C-r": peco_search_history'

