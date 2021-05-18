# .bashrc

# Non-interactive shells
if [[ $- != *i* ]] ; then
	return
fi

# Global definitions
shopt -s checkwinsize
shopt -s no_empty_cmd_completion
shopt -s histappend

if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH:$HOME/go/bin"
fi
export PATH

# User exports
if [ -f $HOME/.config/exports_bash ]
then
	source $HOME/.config/exports_bash
fi

# Local exports
if [ -f $HOME/.config/exports_bash.local ]
then
	source $HOME/.config/exports_bash.local
fi

rightPrompt() {
	local RCol='\[\e[0m\]'

	local Red='\[\e[0;31m\]'
	local Gre='\[\e[0;32m\]'
	local Yel='\[\e[1;33m\]'
	local Pur='\[\e[0;35m\]'

	local GitCompete=""
	local ColorCompensate=0
	# Right side of prompt
	# 1. git stuff
	local GSP="$(git status --porcelain --branch 2>/dev/null)"

	# Modified files
	local GSPm="$(grep -c "^ M" <<< "${GSP}")"
	if [ "${GSPm}" -gt "0" ]; then
		GitString+="${Yel}!"
		ColorCompensate=$((${ColorCompensate}+${#Yel}))
	fi

	# Staged and Tracked files
	local GSPs="$(grep -c "^[AM] " <<< "${GSP}")"
	if [ "${GSPs}" -gt "0" ]; then
		GitString+="${Gre}+"
		ColorCompensate=$((${ColorCompensate}+${#Gre}))
	fi

	# Deleted files
	local GSPd="$(grep -c "^ D" <<< "${GSP}")"
	if [ "${GSPd}" -gt "0" ]; then
		GitString+="${Red}d"
		ColorCompensate=$((${ColorCompensate}+${#Red}))
	fi


	# Untracked files
	local GSPu="$(grep -c "^?" <<< "${GSP}")"
	if [ "${GSPu}" -gt "0" ]; then
		GitString+="${Red}?"
		ColorCompensate=$((${ColorCompensate}+${#Red}))
	fi

	# Branch
	local Branch="$(awk '/##/ {print $2}' <<< "${GSP}")"
	GitString+=" ${Pur}${Branch}"
	ColorCompensate=$((${ColorCompensate}+${#Pur}))

	local Columns=$COLUMNS
	printf "%*s" "$((${Columns}+${ColorCompensate}))" "${GitString} "
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
