#!/bin/sh

user=`whoami`
if [ "$user" == "root" ]
then
	echo "Why are you running?"
	exit
fi

create_links ()
{
	if [ "$#" -ne 2 ]
	then
		echo "create_links used wrong for "$@
		echo "usage: create_links file full_path_to_link"
		return 1
	fi

	current_dir_file=$1
	link_path=$2
	dir_path=`dirname $link_path`

	if [ ! -d $dir_path ]
	then
		echo "$dir_path is not a directory, creating"
		mkdir -p $dir_path
	fi

	if [ -f $link_path ]
	then
		if [ ! -L $link_path ]
		then
			echo "$link_path not a symlink, moving and linking"
			mv $link_path ${link_path}_old
		else
			echo "$link_path is already a symlink, updating"
			rm $link_path
		fi
	else
		if [ -L $link_path ]
		then
			echo "$link_path is already a symlink, updating"
			rm $link_path
		fi
	fi
	ln -s $PWD/$current_dir_file $link_path
}

# vim config
create_links config/vimrc $HOME/.vim/vimrc

# nvim config (needs to create folder so that destructive replace code in create_links above does not constantly replace the config directory)
if [ -d $HOME/.config/nvim ]
then
	echo "~/.config/nvim found, moving to ~/.config/nvim.bak"
	mv $HOME/.config/nvim $HOME/.config.bak
fi

create_links nvim $HOME/.config

# terminal multiplexer configs
create_links config/tmux.conf $HOME/.tmux.conf
create_links config/screenrc $HOME/.screenrc
create_links config/herdr.config.toml $HOME/.config/herdr/config.toml

# aliases
create_links config/aliases $HOME/.config/aliases

# bash setup
create_links config/bash/bash_profile $HOME/.bash_profile
create_links config/bash/bashrc $HOME/.bashrc
create_links config/bash/functions.bash $HOME/.config/functions.bash

# fish setup
create_links config/fish/config.fish $HOME/.config/fish/config.fish
create_links config/fish/functions.fish $HOME/.config/fish/functions/functions.fish
create_links config/fish/fish_prompt.fish $HOME/.config/fish/functions/fish_prompt.fish
create_links config/fish/fish_right_prompt.fish $HOME/.config/fish/functions/fish_right_prompt.fish

# xinitrc for dwm
if command -v dwm > /dev/null
then
	create_links config/xinitrc $HOME/.xinitrc
fi
