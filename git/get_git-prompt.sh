curl -LO https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
mv git-completion.bash .git-completion.bash
mv .git-completion.bash $HOME
curl -LO https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
mv git-prompt.sh .git-prompt.sh
mv .git-prompt.sh $HOME
cat <<EOF >> $HOME/.bash_profile
source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh
export PS1='\[\033[32m\]\u@\h \[\033[33m\]\w\[\033[36m\]$(__git_ps1)\[\033[0m\]\n$ '
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUPSTREAM=auto
EOF
