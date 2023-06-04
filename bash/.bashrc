# .bashrc

## (For Mac) Set softwares that are installed by Homebrew as default, e.g, Bash
## After `brew install bash`, following setting would be enabled.
# export PATH="/usr/local/bin:$PATH"

## [Alias]
## ls (Color)
## After `brew install coreutils`, following setting would be enabled.
## This module allows you to use GNU/Linux versioned ls command
# export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -laG'
alias ls='ls -F --color=auto'

## [history]
## All terminal windows share command history data.
function share_history {
    history -a
    history -c
    history -r
}
PROMPT_COMMAND='share_history'
shopt -u histappend
export HISTSIZE=9999

## [git]
source /usr/local/etc/bash_completion.d/git-prompt.sh
source /usr/local/etc/bash_completion.d/git-completion.bash
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWSTASHSTATE=1
export PS1='\[\033[00m\][\t] \[\e[34m\]\w \[\033[31m\]$(__git_ps1 [%s])\[\033[00m\]\n\$ '
export HOMEBREW_CASK_OPTS='--appdir=/Applications'
export PATH=$HOME/.nodebrew/current/bin:$PATH
export NODEBREW_ROOT=$HOME/.nodebrew

## [Python]
## For pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
## For pipx
export PATH="$PATH:$HOME/.local/bin"
eval "$(register-python-argcomplete pipx)"
. "$HOME/.cargo/env"
## For pipenv
## Create a virtual environment (.venv) under the project directry.
export PIPENV_VENV_IN_PROJECT=true

## [Kubernetes}
## aliases
alias kc='kubectl'
alias watch='watch '
## For krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

## [AWS}
complete -C '/usr/local/bin/aws_completer' aws

## [MySQL}
export PATH=$PATH:/usr/local/mysql/bin

## [direnv]
eval "$(direnv hook bash)"

## [Vim]
## Following setting depends on LunarVim.
#alias vim='lvim'

## [Fuzzy Finding]
## Following setting depends on fzf.
## After `brew install fzf`, following would be enabled.
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
