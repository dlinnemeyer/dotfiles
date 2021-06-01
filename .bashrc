# source .bashrc.local so we can add local customization per environment
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

export PATH=$PATH:~/.bin

# get ll working with color in both mac and linux
alias ll="ls -lhF --color=auto"
ll &> /dev/null || alias ll="ls -lhFG"

# alias vim="vimx"
alias json_pp="python -m json.tool"
# alias pyvim="source venv/bin/activate && vim"
alias ackvim=ackvimfunc
# alias dockerbash="docker exec -it local_app_1 bash"
ackvimfunc(){
    vim $(ack -l $@)
}

# For git tab completion. first linux, then mac. is the linux version needed?
if [ -f '/etc/bash_completion.d/git' ]; then
    source /etc/bash_completion.d/git
fi

# load all bash completion. must run `brew install bash-completion` for this
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
