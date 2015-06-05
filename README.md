## The dotvim for vim/bash/tmux/git settings

I use the dotvim repository to sync the `vim`, `bash`, [`tmux`](http://tmux.sourceforge.net/) and `git` settings. 

The vim plugins are managed by [vim-plug](https://github.com/junegunn/vim-plug)

### Installation
	
	cd ~
	git clone git@github.com:browny/dotvim.git ~/.vim

### Create symlinks

	ln -s ~/.vim/vimrc ~/.vimrc
	ln -s ~/.vim/gitsetting/gitconfig ~/.gitconfig
	ln -s ~/.vim/gitsetting/gitignore ~/.gitignore
	ln -s ~/.vim/tmux.conf ~/.tmux.conf
	cat bashrc_append >> ~/.bashrc

### Install plugins by vim-plug

	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	vim
	:PlugInstall

### Screenshot

![Image](https://raw.github.com/browny/dotvim/master/screenshot/vim-screenshot-20131104.png)

