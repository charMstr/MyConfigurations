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

#create the folder where we place the vim plugins, filetype detections,
# autoloads, etc
[ -d .vim ] || mkdir -p .vim
cp -r MyConfigurations/.vim/* .vim/

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
#			compile it:
#			- first make sure  homebrew is installed/install it
#			- brew install cmake
#			- brew install vim (or macvim...).
#		5) finally call the install.py script  ~/.vim/bundle/YouCompleteMe folder
[ -d .vim/bundle ] || ( mkdir .vim/bundle && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim )
vim -c PluginInstall -c qall

#HOMEBREW CHECK/INSTALL
brew help >/dev/null 2>&1
if [ $? != 0 ]
then
	echo "brew: \033[31mneed to be installed!\033[m"
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	if [ $? ]
	then
		echo "brew: \033[31mfailed installing through curl, EXIT\033[0m"
		exit 1
	else 
		echo "\033[32mbrew is installed.\033[m"
	fi
else
	echo "\033[32mbrew is installed.\033[m"
fi

brew install cmake 
if [ $? != 0 ]
then
	echo "\033[31mfailed to \"brew install cmake\"\033[m"
	exit 1
fi

#brew install python 
#if [ $? != 0 ]
#then
#	echo "\033[31mfailed to \"brew install python\"\033[m"
#	exit 1
#fi

#brew install mono
#if [ $? != 0 ]
#then
#	echo "\033[31mfailed to \"brew install mono\"\033[m"
#	exit 1
#fi
#
#brew install go 
#if [ $? != 0 ]
#then
#	echo "\033[31mfailed to \"brew install go\"\033[m"
#	exit 1
#fi
#
#brew install nodejs
#if [ $? != 0 ]
#then
#	echo "\033[31mfailed to \"brew install nodejs\"\033[m"
#	exit 1
#fi
#
#brew install vim
#if [ $? != 0 ]
#then
#	echo "\033[31mfailed to \"brew install vim\"\033[m"
#	exit 1
#fi

cd ~/.vim/bundle/YouCompleteMe
python3 install.py
if [ $? != 0 ]
then
	echo "\033[31mfailed to compile YCM with all our options.\033[m"
	exit 1
fi

#note:	need to install scan-build so that we can use its subfunction
#		intercept-build. (aliased in the vimrc) Just use "intercept" next to
#		the location of your makefile.
# pip install scan-build
which pip3 >/dev/null 2>&1
if [ $? != 0 ]
then
	echo "\033[32minstalling pip from python3(already installed through homebrew)\033[m"
	python3 -m pip install --upgrade setuptools
	if [ $? != 0 ]
	then
		echo "\033[mfailed to install pip with homebrew\033[m"
		exit
	fi
fi

# SCAN-BUILD
pip3 install scan-build
if [ $? != 0 ]
then
	echo "\033[31mfailed to \"pip3 install scan-build\"\033[m"
	exit 1
fi
### VIM END ################################################################### 
###############################################################################
