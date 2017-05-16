# source .bashrc.local so we can add local customization per environment
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

# some ruby gem thing, making locally installed gems runnable
export PATH=$PATH:~/bin

# basic aliases
alias ll="ls -lh --color=auto"
# alias vim="vimx"
alias json_pp="python -m json.tool"
alias pyvim="source venv/bin/activate && vim"
alias ackvim=ackvimfunc
# alias dockerbash="docker exec -it local_app_1 bash"
ackvimfunc(){
    vim $(ack -l $@)
}

# For git tab completion. first linux, then mac
if [ -f '/etc/bash_completion.d/git' ]; then
    source /etc/bash_completion.d/git
fi
if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
    source `brew --prefix`/etc/bash_completion.d/git-completion.bash
fi

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

export NVM_DIR="/home/dlinnemeyer/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
