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

rightPrompt() {
	local RCol='\[\e[0m\]'

	local Red='\[\e[0;31m\]'
	local Gre='\[\e[0;32m\]'
	local Yel='\[\e[1;33m\]'
	local Pur='\[\e[0;35m\]'

	local GitCompete=""
	local compensate=13
	# Right side of prompt
	# 1. git stuff
	local GSP="$(git status --porcelain=2 --branch 2>/dev/null)"

	# Modified files
	local GSPm="$(grep -c "^[12] .M" <<< "${GSP}")"
	if [ "${GSPm}" -gt "0" ]; then
		GitComplete+="${Yel}!"
		compensate=$((${compensate}+10))
	fi

	# Deleted files
#	local GSPd="$(grep -c "^[12] D" <<< "${GSP}")"
#	if [ "${GSPd}" -gt "0" ]; then
#		GitComplete+="${Red}D"
#		compensate=$((${compensate}+11))
#	fi

	# Added files
	local GSPa="$(grep -c "^[12] A" <<< "${GSP}")"
	if [ "${GSPa}" -gt "0" ]; then
		GitComplete+="${Gre}+"
		compensate=$((${compensate}+5))
	fi

	# Renamed files
#	local GSPr="$(grep -c "^[12] R" <<< "${GSP}")"
#	if [ "${GSPr}" -gt "0" ]; then
#		GitComplete+="${Red}r"
#		compensate=$((${compensate}+11))
#	fi

	# Untracked files
	local GSPu="$(grep -c "^?" <<< "${GSP}")"
	if [ "${GSPu}" -gt "0" ]; then
		GitComplete+="${Red}?"
		compensate=$((${compensate}+12))
	fi

	# Branch
	local Branch="$(awk '/branch.head/ {print $3}' <<< "${GSP}")"
	GitComplete+=" ${Pur}${Branch}"

	printf "%*s" "$(($COLUMNS+${compensate}))" "${GitComplete}"
}

PROMPT_COMMAND=__prompt_command # Func to gen PS1 after CMDs

__prompt_command() {
	local EXIT="$?"			# This needs to be first
	PS1=""

	local RCol='\[\e[0m\]'

	local Red='\[\e[0;31m\]'
	local Gre='\[\e[0;32m\]'
	local BYel='\[\e[1;33m\]'
	local BBlu='\[\e[1;34m\]'
	local Pur='\[\e[0;35m\]'
	local Cyan='\[\e[0;36m\]'

	# printing Right Side of prompt and putting cursor back at start
	PS1+="\[$(tput sc; rightPrompt; tput rc)\]"

	# Left side of prompt
	# 1. exit code color
	# 2. current working directory
	if [ $EXIT != 0 ]; then
		PS1+="${Red}>${RCol}"	# Add red if exit code non 0
	else
		PS1+="${Gre}>${RCol}"
	fi

	PS1+=" ${Cyan}\W${RCol} "


}
