if type __git_ps1 > /dev/null 2>&1 ; then
  PROMPT_COMMAND="__git_ps1 '\u@\h:\w' '\$ '; "
  GIT_PS1_SHOWDIRTYSTATE=true
  GIT_PS1_SHOWSTASHSTATE=true
  GIT_PS1_SHOWUNTRACKEDFILES=true
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_SHOWCOLORHINTS=true
fi
