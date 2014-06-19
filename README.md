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

### Plugins

* [vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator)
  
  This makes seamlessly navigate vim and tmux splits, refer to [Seamlessly Navigate Vim And Tmux Splits](http://robots.thoughtbot.com/seamlessly-navigate-vim-and-tmux-splits) 
  
  整合 tmux pane 和 vim 本身的 splited window 的切換行為, 讓你用 Ctrl+j/k/h/l 就可以在 tmux pane 和 vim splited window 中跳轉 

* [vim-json](https://github.com/elzr/vim-json)
  
  A better JSON for Vim: distinct highlighting of keywords vs values, JSON-specific (non-JS) warnings, quote concealing
  
  在 vim 中編輯 JSON 的好幫手

* [supertab](https://github.com/ervandew/supertab)
  
  Perform all your vim insert mode completions with Tab
  
  什麼都可以用 `<Tab>` 自動完成, 即使沒有開 Omni-Completion 他也會根據該檔案的上下文進行自動補完

* [minibufexpl.vim](https://github.com/fholgado/minibufexpl.vim)
  
  Elegant buffer explorer - takes very little screen space

  像是瀏覽器的頁籤, 當你開啟多個檔案的時候, 可以一目瞭然並且快速跳轉每個開啟的檔案

* [tabular](https://github.com/godlygeek/tabular)

  Text filtering and alignment

  自動對齊套件, 適合代碼清潔重度潔癖者使用

* [ctrlp.vim](https://github.com/kien/ctrlp.vim)
  
  Fuzzy file, buffer, mru, tag, etc finder

  必裝, 有了他幾乎不需要 nerdtree 了. 讓你快速打開檔案的利器

* [vim-easymotion](https://github.com/Lokaltog/vim-easymotion)

  Vim motions on speed!

  快速將鼠標移到精準至`字元`的神奇玩意
  
* [ack.vim](https://github.com/mileszs/ack.vim)
  
  Vim plugin for the Perl module / CLI script 'ack'

  直接在 vim 裡面用 [Ack](http://beyondgrep.com/) 進行搜尋

* [vim-markdown](https://github.com/plasticboy/vim-markdown)
  
  Markdown Vim Mode http://plasticboy.com/markdown-vim-mode/

  用 vim 編輯 markdown 的人必裝, 語法高亮和 html 生成

* [nerdtree](https://github.com/scrooloose/nerdtree)
  
  A tree explorer plugin for vim

  不多說, 就是個檔案總管

* [tcomment](https://github.com/tomtom/tcomment_vim)
  
  An extensible and universal comment vim-plugin

  支援各式各樣語言的快速註解區塊, 不用在手動打 `/*...*/` 了

* [vim-autoclose](https://github.com/Townk/vim-autoclose)
  
  This plugin for Vim enable an auto-close chars feature for you 

  你打了左括號, vim 自動幫你打右括號, 並且跳到 insert mode
  
* [vim-fugitive](https://github.com/tpope/vim-fugitive)
  
  A Git wrapper so awesome, it should be illegal

  必裝, vim 和 git 整合的第一把交椅. [請看 fugitive 教學](http://vimcasts.org/episodes/fugitive-vim---a-complement-to-command-line-git/)

* [vim-repeat](https://github.com/tpope/vim-repeat)
  
  Enable repeating supported plugin maps with "."

* [vim-surround](https://github.com/tpope/vim-surround)
  
  Quoting/parenthesizing made simple
  
  快速把 vim object 放到 `""` 或 `()` 當中的神之套件. [請看 vim-surround 教學](http://net.tutsplus.com/tutorials/other/vim-essential-plugin-surround/)

* [dbext.vim](http://www.vim.org/scripts/script.php?script_id=356)
  
  This plugin contains functions/mappings/commands to enable Vim to access several databases

  直接在 vim 當中連接資料庫, 並且下 SQL command 把輸出導到 vim 的工具. 對於編寫 database patch 的效率提昇很有幫助

* [omincompletion](http://vim.wikia.com/wiki/Omni_completion)
  
  Omni completion provides smart autocompletion for programs

  不多說, 全能補齊

* [seoul256.vim](https://github.com/junegunn/seoul256.vim)
  
  A low-contrast Vim color scheme based on Seoul Colors
  
  目前使用的 color scheme, 但我不喜歡白白的背景, 所以把 `call s:hi('Normal', [252, 239], [s:dark_bg, s:light_bg])` 註解掉了
