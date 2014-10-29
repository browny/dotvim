## The dotvim for vim/bash/tmux/git settings

I use the dotvim repository to sync the `vim`, `bash`, [`tmux`](http://tmux.sourceforge.net/) and `git` settings. 

The vim plugins are managed by [vundle](https://github.com/gmarik/vundle)

### Installation
	
	cd ~
	git clone git@github.com:browny/dotvim.git ~/.vim

### Create symlinks

	ln -s ~/.vim/vimrc ~/.vimrc
	ln -s ~/.vim/gitsetting/gitconfig ~/.gitconfig
	ln -s ~/.vim/gitsetting/gitignore ~/.gitignore
	ln -s ~/.vim/tmux.conf ~/.tmux.conf
	cat bashrc_append >> ~/.bashrc

### Mount submodules managed by vundle

	git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	vim
	:BundleInstall

### Screenshot

![Image](https://raw.github.com/browny/dotvim/master/screenshot/vim-screenshot-20131104.png)

