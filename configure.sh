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

if [ ! -d /home/$user/.vim ]
then
	echo "~/.vim not found, making parent, backup and undo dirs"
	mkdir -p /home/$user/.vim/bkps /home/$user/.vim/undos
fi

if [ ! -d /home/$user/.vim/bkps ]
then
	echo "~/.vim/bkps not found, making"
	mkdir /home/$user/.vim/bkps
fi

if [ ! -d /home/$user/.vim/undos ]
then
	echo "~/.vim/undos not found, making"
	mkdir /home/$user/.vim/undos
fi

if [ -f /home/$user/.vimrc ]
then
	echo "moving ~/.vimrc to ~/.vim/vimrc_old"
	mv /home/$user/.vimrc /home/$user/.vim/vimrc_old
fi

create_links vimrc /home/$user/.vim/vimrc

# tmux config

create_links tmux.conf /home/$user/.tmux.conf

# config directory creation
if [ ! -d /home/$user/.config ]
then
	echo "~/.config not found, making directory"
	mkdir /home/$user/.config/
fi

# aliases

create_links aliases /home/$user/.config/aliases

# bash setup

create_links bash_profile /home/$user/.bash_profile
create_links bashrc /home/$user/.bashrc
create_links functions.bash /home/$user/.config/functions.bash

# fish setup

create_links config.fish /home/$user/.config/fish/config.fish
create_links functions.fish /home/$user/.config/fish/functions/functions.fish

# xinitrc for dwm

if command -v dwm > /dev/null
then
	create_links xinitrc /home/$user/.xinitrc
fi
