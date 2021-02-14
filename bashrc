# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH:$HOME/go/bin"
fi
export PATH

# RESTORE=$(echo -en '\033[0m')
# RED=$(echo -en '\033[00;31m')
# GREEN=$(echo -en '\033[00;32m')
# YELLOW=$(echo -en '\033[00;33m')
# BLUE=$(echo -en '\033[00;34m')
# MAGENTA=$(echo -en '\033[00;35m')
# PURPLE=$(echo -en '\033[00;35m')
# CYAN=$(echo -en '\033[00;36m')
# LIGHTGRAY=$(echo -en '\033[00;37m')
# LRED=$(echo -en '\033[01;31m')
# LGREEN=$(echo -en '\033[01;32m')
# LYELLOW=$(echo -en '\033[01;33m')
# LBLUE=$(echo -en '\033[01;34m')
# LMAGENTA=$(echo -en '\033[01;35m')
# LPURPLE=$(echo -en '\033[01;35m')
# LCYAN=$(echo -en '\033[01;36m')
# WHITE=$(echo -en '\033[01;37m')

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

__prompt_command() {
    local EXIT="$?"             # This needs to be first
    PS1=""

    local RCol='\[\e[0m\]'

    local Red='\[\e[0;31m\]'
    local Gre='\[\e[0;32m\]'
    local BYel='\[\e[1;33m\]'
    local BBlu='\[\e[1;34m\]'
    local Pur='\[\e[0;35m\]'
    local Cyan='\[\e[0;36m\]'

    if [ $EXIT != 0 ]; then
        PS1+="${Red}>${RCol}"      # Add red if exit code non 0
    else
        PS1+="${Gre}>${RCol}"
    fi

    PS1+=" ${Cyan}\W${RCol} "
}
