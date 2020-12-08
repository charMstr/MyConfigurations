#!/bin/sh

cd

###############################################################################
### ZSH/SHELL START ########################################################### 

#place the .zshrc
ln -sf MyConfigurations/.zshrc .zshrc

#shell functions and lib
[ -d .shell_lib ] || mkdir .shell_lib
cp MyConfigurations/.shell_lib/* .shell_lib/
[ -d .shell_scripts ] || mkdir .shell_scripts
cp MyConfigurations/.shell_scripts/* .shell_scripts/

### ZSH/SHELL END ############################################################# 
###############################################################################


###############################################################################
### MISCELANEOUS ############################################################## 

#place the lldb.init
ln -sf MyConfigurations/.lldbinit .lldbinit


###############################################################################
### VIM START ################################################################# 

#create the folder where we place the vim plugins
[ -d .vim/plugin ] || mkdir -p .vim/plugin
cp MyConfigurations/.vim/plugin/* .vim/plugin/

#create the folder where we place the filetype detection files. (ftdetect)
[ -d .vim/ftdetect ] || mkdir -p .vim/ftdetect
#cp MyConfigurations/.vim/ftdetect/* .vim/ftdetect/

#create the folder where i place the vim filetype plugin files (ftplugin)
[ -d .vim/ftplugin ] || mkdir -p .vim/ftplugin
cp MyConfigurations/.vim/ftplugin/* .vim/ftplugin/

#place the .vimrc
ln -sf MyConfigurations/.vimrc .vimrc

# note: for using autocompletion, we will use YouCompleteMe.
# REQUIREMENTS: - install vundle: package manager For vim's plugins
#				- run the PluginInstall command
#				- having vim built with python, and latest versions.
#				- build the YouCompleteMe
#
# note: 1) install bundle For vim(package manager)
#		2) at the beginning of the vimrc should be the list of vundle plugins.
#		3) run inside vim the command ":PluginInstall"
#		4) now that the YouCompleteMe plugin has been downloaded, we need to
#			compile it.
[ -d .vim/bundle ] || git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim -c PluginInstall -c qall
cd ~/.vim/bundle/YouCompleteMe
#python3 install.py --all

### VIM END ################################################################### 
###############################################################################
