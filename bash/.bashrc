# .bashrc

# エイリアスの設定
# ls（カラー表示）
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -laG'
alias ls='ls -F --color=auto'

# git
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
export PS1='\[\e[34m\]\w \[\033[31m\]$(__git_ps1 [%s])\[\033[00m\]\$ '
export HOMEBREW_CASK_OPTS='--appdir=/Applications'
export PATH=$HOME/.nodebrew/current/bin:$PATH
export NODEBREW_ROOT=$HOME/.nodebrew

# Python
## pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Kubernetes
## aliases
alias kc='kubectl'
alias watch='watch '
## krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Created by `pipx` on 2021-05-11 08:52:20
export PATH="$PATH:$HOME/.local/bin"

# pipx
eval "$(register-python-argcomplete pipx)"
. "$HOME/.cargo/env"

# AWS
complete -C '/usr/local/bin/aws_completer' aws
