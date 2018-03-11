wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh
mv git-prompt.sh .git-prompt.sh
mv .git-prompt.sh $HOME
cat <<EOF
EOF >> ~/.bash_profile
if type __git_ps1 > /dev/null 2>&1 ; then
  PROMPT_COMMAND="__git_ps1 '\h:\W \u' '\\\$ '; $PROMPT_COMMAND"
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_SHOWCOLORHINTS=true
fi
EOF
