# keep things consistent between bashrc and bash_profile. remember, bash_profile is sourced for 
# login shells; bashrc on every new terminal instance. this keeps everything in line.
[ -f ~/.bashrc ] && source ~/.bashrc

##
# Your previous /Users/dlinnemeyer/.bash_profile file was backed up as /Users/dlinnemeyer/.bash_profile.macports-saved_2017-06-02_at_10:47:57
##

# MacPorts Installer addition on 2017-06-02_at_10:47:57: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


# MacPorts Installer addition on 2017-06-02_at_10:47:57: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH="/opt/local/share/man:$MANPATH"
# Finished adapting your MANPATH environment variable for use with MacPorts.


# added by Snowflake SnowSQL installer v1.0
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH
