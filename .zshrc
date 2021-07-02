# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .zshrc                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: charmstr <charmstr@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/26 19:21:18 by charmstr          #+#    #+#              #
#    Updated: 2021/07/02 13:36:52 by charmstr         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

###############################################################################
##	CONFIG TERMINAL
###############################################################################

export SHELL=/bin/zsh

# NEW VIM INSTALLED IN /USR/LOCAL/BIN/VIM WITH HOMEBREW -> GOOD LANGUAGE
if [ `basename ${HOME}` = "charmstr" ]
then
	export LC_ALL="en_US.UTF-8"
fi

# TURN OFF ALL BEEPS
unsetopt BEEP
# Turn off autocomplete beeps or history beeps
# unsetopt LIST_BEEP
# unsetopt HIST_BEEP

# IF AT 42
if [ `basename ${HOME}` = "charmstr" ]
then
	export PATH=$HOME/.brew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/munk

	#SOURCES SHELL FUNCTIONS IN .SHELL_LIB
	source ~/.shell_lib/*
	#SOURCES SHELL SCRIPTS IN .SHELL_SCRIPT
	source ~/.shell_scripts/*
fi
#SOURCES SHELL FUNCTIONS IN .SHELL_LIB
source ~/.shell_lib/display_colors.lib
source ~/.shell_lib/grepvim.lib

###############################################################################

###############################################################################
##	GENERAL
###############################################################################

#EDIT .ZSHRC
alias vzsh='vim ~/.zshrc'

#SOURCE
alias so='source'

# CDS = CD + LS
alias cd=CDLS
alias cd..='cd ..'
alias cd-='cd  -'

function CDLS
{
	\cd $1
	if [ $? -eq "0" ]
	then
	    /bin/ls
	fi
}

# for intercept-build to work.
alias intercept='intercept-build --override-compiler make re CC=intercept-cc CXX=intercept-c++ all'

# COMMON
alias la='ls -la'
alias grep='grep -n --colour=auto'

#kbernetes
alias kc='kubectl'

#GCC FLAGS
alias gcc-W='gcc -Wall -Wextra -Werror'

#Leaks
alias leaks='leaks -atExit --'

#ENV VARIABLE
export MAIL=$USER'@student.42.fr'
###############################################################################

###############################################################################
#TO ADD DEFAULT INCLUDE AND LIBRARY SEARCH PATHS
###############################################################################
#source: https://gcc.gnu.org/onlinedocs/gcc/Environment-Variables.html

#FOR INCLUDE PATHS:
# note: for Cpp includes, for Cppunit (installed with brew) found easily
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/usr/local/Cellar/cppunit/1.15.1/include/
#export CPATH=$CPATH:... #to affect any langage
#export C_INCLUDE_PATH=$C_INCLUDE_PATH:...
#export OBJC_INCLUDE_PATH=$C_INCLUDE_PATH:...

#FOR LIBRARY PATHS
#export LIBRARY_PATH=...
###############################################################################

###############################################################################
#NORMINETTE NORM
###############################################################################
# usefull so that we can use the correct version of ruby, something like that.
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

alias norminette="~/.norminette/norminette.rb"
alias norm='norminette'
###############################################################################


###############################################################################
#GIT
###############################################################################

alias gcl='git clone'
alias gti='git'

function gitm
{
	git commit -m "$1";
}

###############################################################################


###############################################################################
##	DISPLAY
###############################################################################

_GREEN="\033[38;5;76m"
_GREY="\033[38;5;250m"
_RESET_COLOR="\033[m"


#PROMPT
#PROMPT="%{$_GREY%} 🕓  %t  %{$_GREEN%}DIR% --> %d  %{$_RESET_COLOR%}"
#export PS1=`echo ${PROMPT}`
PROMPT="%{$_GREY%}%t %{$_GREEN%}%d ➜ %{$_RESET_COLOR%}"
export PS1=`echo ${PROMPT}`


#export PS1=$'\n\e[48;5;237m\e[38;5;242m%t \e[m\e[m\e[38;5;159m • \e[m %d\e[38;5;159m -->\e[m'
# %n myname %x la version du terminal. %$4 --> 4 %$f --> f
# %d le path %w le jour de la semaine et du calendrier %t ou T forme du temps 
export PS2='🚀`'

#COLOR ls OUTPUT IN TERMINAL
export CLICOLOR=1
export LSCOLORS="ExHxcxdxbxegedabagacad"
###############################################################################


###############################################################################
##	PROJECTS/PLACES/WEBSITES
###############################################################################

alias GNL='cd ~/Projects/get_next_line_git/get_next_line_binary'
alias LIB='cd ~/Projects/libft_git/libft'
alias PRF='cd ~/Projects/ft_printf_git'
alias C3D='cd ~/Projects/cube3d'
alias FTS='cd ~/Projects/ft_server'
alias FTSS='cd ~/Projects/ft_services'
alias ASM='cd ~/Projects/libasm'
alias MINI='cd ~/Projects/minishell'
alias PHIL='cd ~/Projects/philosophers'
alias CONT='cd ~/Projects/ft_containers'
alias WEBS='cd ~/Projects/webserver_git'
alias PUSH='cd ~/Projects/push_swap'
alias TRAN='cd ~/Projects/ft_transcendence'

alias SAN='cd ~/Sandbox'

alias CPP0='cd ~/Projects/piscine_cpp42/cpp00'
alias CPP1='cd ~/Projects/piscine_cpp42/cpp01'
alias CPP2='cd ~/Projects/piscine_cpp42/cpp02'
alias CPP3='cd ~/Projects/piscine_cpp42/cpp03'
alias CPP4='cd ~/Projects/piscine_cpp42/cpp04'
alias CPP5='cd ~/Projects/piscine_cpp42/cpp05'
alias CPP6='cd ~/Projects/piscine_cpp42/cpp06'
alias CPP7='cd ~/Projects/piscine_cpp42/cpp07'
alias CPP8='cd ~/Projects/piscine_cpp42/cpp08'


# IF AT Remercille
if [ `basename ${HOME}` = "Remercille" ]
then
alias WEBS='cd ~/Charlie/webserver_git'
fi

# IF AT HOME
if [ `basename ${HOME}` = "user42" ]
then
	XDG_PREFIX="xdg-"
fi

#OPEN WEBSITES
alias intra='${XDG_PREFIX}open https://profile.intra.42.fr/'
alias miam='${XDG_PREFIX}open https://steakoverflow.42.fr/'
alias github='${XDG_PREFIX}open https://github.com/'
alias gitlab='${XDG_PREFIX}open https://gitlab.com/'
alias youtube='`${XDG_PREFIX}open https://www.youtube.com`'
alias charlie='`${XDG_PREFIX}open https://mail.google.com/mail/u/0/#inbox`'
alias karlos='`${XDG_PREFIX}open https://mail.google.com/mail/u/2/#inbox`'

#PLUGINS-VIM
alias plugin='cd ~/.vim/plugin/'

###############################################################################


###############################################################################
#FUNCTIONS
###############################################################################

function see
{
	if [ ! -f $(echo ~/Projects/libft_git/libft/ft_$1.c) ]
	then	
		clear
		printf "\033[31mERROR:\033[38;5;255m ft_$1.c\033[0m does not exist\n"
		ls ~/Projects/libft_git/libft/
		return
	fi
	echo  ''
	for i in `seq 3 0`
	do
		echo "\e[1A\e[38;5;10m$i\e[m"
		sleep 0.2
	done
	echo "\e[1A "
	clear
	echo "  ===>  ft_$1.c "
	#sleep 0.5
	printf "\e[38;5;195m%s\n\t\t\t\t\t--------\n\e[m" "$(cat ~/Projects/libft_git/libft/ft_$1.c)";
}


function spy
{
	${XDG_PREFIX}open https://profile.intra.42.fr/users/$1
}

#count the extensions of the files in the current directory and displays result
function count_extensions
{
	for j in *;
	do echo ${j##*.};
	done | sort | uniq -c
}

#copies the absolute path in printboard
function cpwd
{
	echo -n `pwd` | pbcopy
}

# USAGE:example -->  change_extension .c .cpp
change_extension()
{
	FROM=$1
	TO=$2
	echo "renaming file(s) *${FROM} into file(s) *${TO}"
	for i in *$FROM
	do
		j=`basename ${i} ${FROM}`
		mv ${j}${FROM} ${j}${TO}
	done
}

# IF AT 42
if [ `basename ${HOME}` = "charmstr" ]
then
	#IT SAVES IN THE PASTEBIN MY CURRETN POSITION
	function here
	{
		printf  " -->  $HOST" | cut -d . -f 1 ;
		printf " -->  \e[38;5;133mDo ctrl + V anywhere ...\e[m\n";
		echo "Im here ✌️: $HOST" | cut -d . -f 1 | tr -d '\n' | pbcopy;
		open -a slack
	}

	function stud
	{
		if [ $# -eq "0" ]
		then
			FLOOR=$(echo $HOST | cut -c2)
		else
			if [ $1 -le 3 ] && [ $1 -ge 1 ]
			then
				FLOOR=$1
			else
				echo "Error: you must enter a number between 1 and 3 for the floor"
				return 1
			fi
		fi
		${XDG_PREFIX}open https://stud42.fr/clusters/${FLOOR}
	}

	#MOVE MINIKUBE TO GOINFRE
	set_minikube()
	{
		if [ -d $HOME/.minikube ]
		then
			rm -rf $HOME/.minikube
		fi
		MINIKUBE_FOLDER="/Volumes/Storage/goinfre/$USER/.minikube"
		if [ ! -d $MINIKUBE_FOLDER ]
		then
			mkdir -p $MINIKUBE_FOLDER
		fi
		ln -s $MINIKUBE_FOLDER $HOME/.minikube
		echo "\033[38;5;46msetting the vm-driver to virtualbox\033[0m"
		minikube config set vm-driver virtualbox
	}

	set_docker()
	{
		sh  ~/.shell_scripts/move_docker_to_goinfre.sh
	}

	#MAKE SPACE
	function clean_caches
	{
		rm -rf ~/Library/**.42_cache_bak_**
		rm -rf ~/**.42_cache_bak_**
		brew cleanup
	}
fi
###############################################################################
