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
	if [ -f $link_path ]
	then
		if [ ! -L $link_path ]
		then
			echo "$link_path not a symlink, moving file and linking"
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

if [ ! -d $HOME/.vim ]
then
	echo "~/.vim not found, making parent, backup and undo dirs"
	mkdir -p $HOME/.vim/bkps $HOME/.vim/undos
fi

if [ ! -d $HOME/.vim/bkps ]
then
	echo "~/.vim/bkps not found, making"
	mkdir $HOME/.vim/bkps
fi

if [ ! -d $HOME/.vim/undos ]
then
	echo "~/.vim/undos not found, making"
	mkdir $HOME/.vim/undos
fi

if [ -f $HOME/.vimrc ]
then
	echo "moving ~/.vimrc to ~/.vim/vimrc_old"
	mv $HOME/.vimrc $HOME/.vim/vimrc_old
fi

create_links config/vimrc $HOME/.vim/vimrc

# nvim config
if [ -d $HOME/.config/nvim ]
then
	echo "~/.config/nvim found, moving to ~/.config/nvim.bak"
	mv $HOME/.config/nvim $HOME/.config.bak
fi

create_links nvim $HOME/.config

# tmux and screen config

create_links config/tmux.conf $HOME/.tmux.conf
create_links config/screenrc $HOME/.screenrc

# config directory creation
if [ ! -d $HOME/.config ]
then
	echo "~/.config not found, making directory"
	mkdir -p $HOME/.config/fish/functions/
else
	if [ ! -d $HOME/.config/fish/functions/ ]
	then
		echo "~/.config found but ~/.config/fish/functions not found, making directory"
		mkdir -p $HOME/.config/fish/functions/
	fi
fi

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
