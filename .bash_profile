# keep things consistent between bashrc and bash_profile. remember, bash_profile is sourced for 
# login shells; bashrc on every new terminal instance. this keeps everything in line.
[ -f ~/.bashrc ] && source ~/.bashrc
