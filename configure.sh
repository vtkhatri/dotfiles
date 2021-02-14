#!/bin/sh

user=`whoami`
if [ "$user" == "root" ]
then
	echo "Why are you running (as root)?"
	exit
fi


if [ ! -d /home/$user/.vim ]
then
	echo "~/.vim not found, making parent, backup and undo dirs"
	mkdir -p /home/$user/.vim/bkps /home/$user/.vim/undos
fi

if [ -f /home/$user/.vimrc ]
then
	echo "moving ~/.vimrc to ~/.vim/old_vimrc"
	mv /home/$user/.vimrc /home/$user/.vim/old_vimrc
fi

if [ -f /home/$user/.vim/vimrc ]
then
	if [ ! -L /home/$user/.vim/vimrc ]
	then
		echo "~/.vim/vimrc not a symlink, moving file and linking"
		mv /home/$user/.vim/vimrc /home/$user/.vim/old_vimrc
		ln -s $PWD/vimrc /home/$user/.vim/vimrc
	else
		echo "~/.vim/vimrc is already a symlink, updating"
		rm /home/$user/.vim/vimrc
		ln -s $PWD/vimrc /home/$user/.vim/vimrc
	fi
else
	ln -s $PWD/vimrc /home/$user/.vim/vimrc
fi

if [ -f /home/$user/.tmux.conf ]
then
	if [ ! -L /home/$user/.tmux.conf ]
	then
		echo "~/.tmux.conf not a symlink, moving file and linking"
		mv /home/$user/.tmux.conf /home/$user/.old_tmux.conf
		ln -s $PWD/tmux.conf /home/$user/.tmux.conf
	else
		echo "~/.tmux.conf is already a symlink, updating"
		rm /home/$user/.tmux.conf
		ln -s $PWD/tmux.conf /home/$user/.tmux.conf
	fi
else
	ln -s $PWD/tmux.conf /home/$user/.tmux.conf
fi

if [ -f /home/$user/.bashrc ]
then
	if [ ! -L /home/$user/.bashrc ]
	then
		echo "~/.bashrc not a symlink, moving file and linking"
		mv /home/$user/.bashrc /home/$user/.old_bashrc
		ln -s $PWD/bashrc /home/$user/.bashrc
	else
		echo "~/.bashrc is already a symlink, updating"
		rm /home/$user/.bashrc
		ln -s $PWD/bashrc /home/$user/.bashrc
	fi
else
	ln -s $PWD/bashrc /home/$user/.bashrc
fi

if [ ! -d /home/$user/.config ]
then
	echo "~/.config not found, making directory"
	ln -s $PWD/exports_bash /home/$user/.config/exports_bash
else
	if [ -f /home/$user/.config/exports_bash ]
	then
		if [ ! -L /home/$user/.config/exports_bash ]
		then
			echo "~/.config/exports_bash not a symlink, moving file and linking"
			mv /home/$user/.config/exports_bash /home/$user/.config/old_exports_bash
			ln -s $PWD/exports_bash /home/$user/.config/exports_bash
		else
			echo "~/.config/exports_bash is already a symlink, updating"
			rm /home/$user/.config/exports_bash
			ln -s $PWD/exports_bash /home/$user/.config/exports_bash
		fi
	else
		ln -s $PWD/exports_bash /home/$user/.config/exports_bash
	fi
fi
