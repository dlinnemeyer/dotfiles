# basic aliases
alias ll="ls -l --color=auto"
alias pvim=$'xargs -I {} -L 20 bash -c \'</dev/tty vim {}\''
alias json_pp="python -m json.tool"

# For git tab completion
source /etc/bash_completion.d/git
source /etc/bash_completion.d/git-flow
source ~/bash-completion/bash_completion

function parse_git_branch {
 git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
 local   HOST_NAME="dev.ccb"
 local        BLUE="\[\033[0;34m\]"
 local         RED="\[\033[0;31m\]"
 local   LIGHT_RED="\[\033[1;31m\]"
 local       GREEN="\[\033[0;32m\]"
 local LIGHT_GREEN="\[\033[1;32m\]"
 local       WHITE="\[\033[0;37m\]"  
 local  LIGHT_GRAY="\[\033[0;37m\]"
 local   END_COLOR="\[\e[m\]"
 case $TERM in
    xterm*)
 	TITLEBAR='\[\033]0;\u@\h:\w\007\]'
	;;
	*)
	TITLEBAR=""
	;;
esac

PS1="${TITLEBAR}\
\u@\h:\w$GREEN\$(parse_git_branch)$END_COLOR\
\$ "
PS2='> '
PS4='+ '
}
proml
