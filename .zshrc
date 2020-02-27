# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .zshrc                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: charmstr <charmstr@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/26 19:21:18 by charmstr          #+#    #+#              #
#    Updated: 2020/02/27 17:07:18 by charmstr         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

###############################################################################
##	CONFIG TERMINAL
###############################################################################

export SHELL=/bin/zsh

# NEW VIM INSTALLED IN /USR/LOCAL/BIN/VIM WITH HOMEBREW -> GOOD LANGUAGE
if [ `basename ${HOME}` = "orson" ]
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
	export PATH=$HOME/.brew/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/munk

	#SOURCES SHELL FUNCTIONS IN .SHELL_LIB
	source ~/.shell_lib/display_colors.lib
	source ~/.shell_lib/install_python_42ai.lib
	#SOURCES SHELL SCRIPTS IN .SHELL_SCRIPT
	source ~/.shell_scripts/keep_lock_files_in_tmp_for_brew.sh
fi

###############################################################################

###############################################################################
##	GENERAL
###############################################################################

#EDIT .ZSHRC
alias vzsh='vim ~/.zshrc'

#SOURCE
alias so='source'

# CDS = CD + LS
alias cd..='CDLS ..'
alias cd-='CDLS -'
alias cd=CDLS
function CDLS
{
	\cd $1
	if [ $? -eq "0" ]
	then
	    ls
	fi
}

# COMMON
alias la='ls -la'
alias grep='grep -n --colour'

# IF AT 42
if [ `basename ${HOME}` = "charmstr" ]
then
	#NORMINETTE
	alias norm='norminette'
fi

#GCC FLAGS
alias gcc-W='gcc -Wall -Wextra -Werror'

#ENV VARIABLE
export MAIL=$USER'@student.42.fr'
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
PROMPT="%{$_GREY%} 🕓  %t  %{$_GREEN%}DIR% --> %d  %{$_RESET_COLOR%}"
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

# IF AT 42
if [ `basename ${HOME}` = "charmstr" ]
then
	#PROJECTS
	alias GNL='cd ~/Projects/get_next_line_git/get_next_line_binary'
	alias LIB='cd ~/Projects/libft_git'
	alias PRF='cd ~/Projects/ft_printf_42cursus'
	alias RT='cd ~/Projects/rt_git'
	alias C3D='cd ~/Projects/cube3d_git'
	alias FTS='cd ~/Projects/ft_server_git'
	alias FTSS='cd ~/Projects/ft_services_git'


	#PLACES
	alias AI='cd ~/42AI/Bootcamp_ai'
	alias TOO='cd ~/Toolbox'
	alias ELE='cd ~/Toolbox/Electronique_repo/Ethernic_Project'
	alias SAN='cd ~/Toolbox/Sandbox'
	alias SGO='cd /sgoinfre/goinfre/Perso/charmstr'
fi

# IF AT HOME
if [ `basename ${HOME}` = "orson" ]
then
	# TO PROJECTS
	alias LIB='cd ~/Projects/libft_git'
	alias ELE='cd ~/Projects/electronic/Ethernic_Project'

	# TO PLACES
	alias TOO='cd ~/Toolbox'
	alias SAN='cd ~/Toolbox/Sandbox'
fi


#OPEN WEBSITES
alias intra='open https://profile.intra.42.fr/'
alias miam='open https://steakoverflow.42.fr/'
alias github='open https://github.com/'
alias youtube='`open https://www.youtube.com`'
alias charlie='`open https://mail.google.com/mail/u/0/#inbox`'
alias karlos='`open https://mail.google.com/mail/u/2/#inbox`'

#PLUGINS-VIM
alias plugin='cd ~/.vim/plugin/'

###############################################################################


###############################################################################
#MAKE SPACE 
###############################################################################

function clean_caches
{
	rm -rf ~/Library/**.42_cache_bak_**
	rm -rf ~/**.42_cache_bak_**
	brew cleanup
}

###############################################################################


###############################################################################
#FUNCTIONS
###############################################################################

#add miniconda script...
export PATH=~/goinfre/miniconda3/bin:$PATH

function see
{
echo  ''
for i in `seq 3 0`
do
	echo "\e[1A\e[38;5;10m$i\e[m"
	sleep 0.2
done
echo "\e[1A "
echo "  ===>  $1 "
sleep 0.5
printf "\e[2A\e[38;5;195m%s\n\t\t\t\t\t--------\n\e[m" "$(cat ~/Projects/libft_git/libft/ft_$1.c)";
}

# IF AT 42
if [ `basename ${HOME}` = "charmstr" ]
then
	#IT SAVES IN THE PASTEBIN MY CURRETN POSITION
	function here
	{
		printf  " -->  $HOST" | cut -d . -f 1 ;
		printf " -->  \e[38;5;133mDo ctrl + V anywhere ...\e[m\n";
		echo "Im here ✌️ : $HOST" | cut -d . -f 1 | tr -d '\n' | pbcopy;
	}
fi

function spy
{
	open https://profile.intra.42.fr/users/$1
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
	open https://stud42.fr/clusters/${FLOOR}
}

function count_extensions
{
	for j in *;do echo ${j##*.}; done | uniq -c
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
###############################################################################
