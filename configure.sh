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
			ln -s $PWD/$current_dir_file $link_path
		else
			echo "$link_path is already a symlink, updating"
			rm $link_path
			ln -s $PWD/$current_dir_file $link_path
		fi
	else
		ln -s $PWD/$current_dir_file $link_path
	fi
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

create_links vimrc $HOME/.vim/vimrc

# tmux and screen config

create_links tmux.conf $HOME/.tmux.conf
create_links screenrc $HOME/.screenrc

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

create_links aliases $HOME/.config/aliases

# bash setup

create_links bash_profile $HOME/.bash_profile
create_links bashrc $HOME/.bashrc
create_links functions.bash $HOME/.config/functions.bash

# fish setup

create_links config.fish $HOME/.config/fish/config.fish
create_links functions.fish $HOME/.config/fish/functions/functions.fish
create_links fish_prompt.fish $HOME/.config/fish/functions/fish_prompt.fish
create_links fish_right_prompt.fish $HOME/.config/fish/functions/fish_right_prompt.fish

# xinitrc for dwm

if command -v dwm > /dev/null
then
	create_links xinitrc $HOME/.xinitrc
fi
