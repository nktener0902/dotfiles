## lang
export LANG=ja_JP.UTF-8

# zsh-completions
if [ -e /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi


autoload -Uz compinit
compinit -u


# 直前コマンドの開始・終了時刻（安定版: add-zsh-hook）
autoload -Uz add-zsh-hook

typeset -g __ts_cmd_started_at=""
typeset -g __ts_cmd_running=0
typeset -g __ts_last_prompt_line=""

__ts_preexec() {
  __ts_cmd_running=1
  __ts_cmd_started_at="$(date '+%Y-%m-%d %H:%M:%S')"
  local time_hm="${__ts_cmd_started_at:11}"

  # PS1は2行構成（info行 + "$ "行）のため、Enter後のカーソルから2行上がinfo行
  # その行を (HH:MM:SS) 付きに上書きしてからカーソルを戻す
  printf '\e[2A\r\e[2K'
  print -Prn -- "${__ts_last_prompt_line} %F{yellow}(${time_hm})%f"
  printf '\e[2B\r'
}

__ts_precmd() {
  if (( __ts_cmd_running )); then
    local ended_at="$(date '+%Y-%m-%d %H:%M:%S')"
    if [[ -n "${__ts_cmd_started_at}" ]]; then
      print -r -- "[${__ts_cmd_started_at} -> ${ended_at}]"
    else
      print -r -- "[${ended_at}]"
    fi
    __ts_cmd_running=0
    __ts_cmd_started_at=""
  fi

  # PS1の$(...) はサブシェルなので変数代入が親に届かない。
  # precmd は親シェルで動くため、ここで更新する。
  local _git_raw=$(__git_ps1 '(%s)')
  _git_raw=${_git_raw%\%}
  __ts_last_prompt_line="%F{green}%n@%m%f: %F{cyan}%~%f %F{red}${_git_raw}%f"
}

add-zsh-hook preexec __ts_preexec
add-zsh-hook precmd  __ts_precmd


function __ts_first_prompt_line() {
  local git_raw=$(__git_ps1 '(%s)')
  git_raw=${git_raw%\%}
  print -r -- "%F{green}%n@%m%f: %F{cyan}%~%f %F{red}${git_raw}%f"
}

# Git status の自動更新（5秒ごと）
TMOUT=5

TRAPALRM() {
  [[ -o zle ]] || return 0
  case "$WIDGET" in
    complete-word|expand-or-complete|menu-complete|menu-select|reverse-menu-complete|list-choices|complete-word*|expand-or-complete* )
      return 0
      ;;
  esac
  zle reset-prompt
}

# peco
# 過去に実行したコマンドを選択。ctrl-rにバインド
function peco-select-history() {
  local _saved_tmout=$TMOUT
  TMOUT=0
  {
    BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
    CURSOR=$#BUFFER
  } always {
    TMOUT=$_saved_tmout
    zle reset-prompt
  }
}
zle -N peco-select-history
bindkey '^r' peco-select-history

# Ctrl-D を「入力があるときだけ delete-char」にする
function ctrl-d-safe() {
  if [[ -n $BUFFER ]]; then
    zle delete-char
  else
    # 何もしない（EOF を送らない）
    zle -M "Ctrl-D ignored (empty line)"
  fi
}
zle -N ctrl-d-safe
bindkey '^D' ctrl-d-safe
setopt IGNORE_EOF

# search a destination from cdr list
function peco-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  peco --query "$LBUFFER"
}

### 過去に移動したことのあるディレクトリを選択。ctrl-uにバインド
function peco-cdr() {
  local _saved_tmout=$TMOUT
  TMOUT=0
  {
    local destination="$(peco-get-destination-from-cdr)"
    if [ -n "$destination" ]; then
      BUFFER="cd $destination"
      zle accept-line
    else
      zle reset-prompt
    fi
  } always {
    TMOUT=$_saved_tmout
    zle reset-prompt
  }
}
zle -N peco-cdr
bindkey '^u' peco-cdr

# ブランチを簡単切り替え。git checkout lbで実行できる
alias -g lb='`git branch | peco --prompt "GIT BRANCH>" | head -n 1 | sed -e "s/^\*\s*//g"`'

# dockerコンテナに入る。deで実行できる
alias de='docker exec -it $(docker ps | peco | cut -d " " -f 1) /bin/bash'

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/yu.nakata/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust
### End of Zinit's installer chunk

# git-prompt
source ~/.zsh/git-prompt.sh

# git-completionの読み込み
fpath=(~/.zsh $fpath)
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
autoload -Uz compinit && compinit

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto


setopt PROMPT_SUBST
PS1='$(__ts_first_prompt_line)
$ '

# node
export PATH=$HOME/.nodebrew/current/bin:$PATH

# ls
alias ls='ls -G'

# ビープ音オフ
setopt no_beep

# Created by `pipx` on 2024-11-14 06:07:47
export PATH="$PATH:/Users/yu.nakata/.local/bin"

source ~/alias_bastion.sh
export PATH="/opt/homebrew/opt/mysql-client@8.0/bin:$PATH"

# Neovim
alias vim='nvim'

# asdf
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
autoload -Uz compinit && compinit

# Go
export GOPATH="$HOME/go"
export PATH="$HOME/.asdf/shims:$PATH"

# Kubernetes
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# WebAutoCLI
export PATH="$HOME/t4/WebAutoCLI_binary:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"

# history
HISTSIZE=100000
SAVEHIST=200000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

# gistalias completion
eval "$(_GISTALIAS_COMPLETE=zsh_source gistalias)"

# pnpm
export PNPM_HOME="/Users/yu.nakata/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm End
