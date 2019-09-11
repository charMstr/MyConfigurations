###############################################################################
##	CONFIG TERMINAL
###############################################################################

export SHELL=/bin/zsh

# TURN OFF ALL BEEPS
unsetopt BEEP
# Turn off autocomplete beeps or history beeps
# unsetopt LIST_BEEP
# unsetopt HIST_BEEP

# IF AT 42
if [ `basename ${HOME}` = "charmstr" ]
then
	export PATH=/Users/charmstr/.brew/bin/:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/munki
fi
###############################################################################

###############################################################################
##	GENERAL
###############################################################################

#EDIT .ZSHRC
alias vzsh='vim ~/.zshrc'

# CDS = CD + LS
alias cd..='CDLS ..'
alias cd-='CDLS -'
alias cd=CDLS
function CDLS
{
	\cd $1
	ls
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
_RESET_COLOR="\033[m"

#PROMPT
PROMPT=" 🕓 %t  %{$_GREEN%}DIR%{$_RESET_COLOR%} --> %{$_GREEN%}%d  %{$_RESET_COLOR%}"
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
	alias GNL='cd ~/Projects/get_next_line/GNL/;ls'
	alias LIB='cd ~/Projects/libft/libft_git/;ls'
	alias FIL='cd ~/Projects/fillit/;ls'
	alias INI='cd /Users/charmstr/Projects/init/init_git;ls'
	
	#PLACES
	alias TOO='cd ~/Toolbox;ls'
	alias ELE='cd ~/Toolbox/Electronique_repo/Ethernic_Project;ls'
	alias SAN='cd ~/Toolbox/Sandbox;ls'
	alias SGO='cd /sgoinfre/goinfre/Perso/charmstr;ls'
fi

# IF AT HOME
if [ `basename ${HOME}` = "orson" ]
then
	# TO PROJECTS
	alias LIB='cd ~/Projects/libft_git;ls'
	alias ELE='cd ~/Projects/electronic/Ethernic_Project;ls' 

	# TO PLACES
	alias SAN='cd ~/Projects/sandbox;ls'
fi


#OPEN WEBSITES
alias intra='open https://profile.intra.42.fr/'
alias miam='open https://steakoverflow.42.fr/'
alias github='open https://github.com/'
alias stud='`open https://stud42.fr/clusters`'
alias youtube='`open https://www.youtube.com`'
alias charlie='`open https://mail.google.com/mail/u/0/#inbox`'
alias karlos='`open https://mail.google.com/mail/u/2/#inbox`'

#PLUGINS-VIM
	alias plu='PLU'
function PLU()
{
	cd ~/.vim/plugin/
		ls
}

###############################################################################


###############################################################################
#FUNCTIONS
###############################################################################

function see
{
# echo  ''
for i in `seq 3 0`
do
	echo "\e[1A\e[38;5;10m$i\e[m"
	sleep 0.5
done
echo "  ===>  $1 "
sleep 0.5
printf "\e[2A\e[38;5;195m%s\n\t\t\t\t\t--------\n\e[m" "$(cat ~/Projects/libft/libft_git/ft_$1.c)";
}

# IF AT 42
if [ `basename ${HOME}` = "charmstr" ]
then
	function here
	{
		printf  " -->  $HOST" | cut -d . -f 1 ;
		printf " -->  \e[38;5;133mDo ctrl + V anywhere ...\e[m\n";
		echo "Im here 🤠 : $HOST" | cut -d . -f 1 | tr -d '\n' | pbcopy;
	}
fi

function spy
{
	open https://profile.intra.42.fr/users/$1
}

function stud
{
	floor=$(echo $HOST | cut -c2)
		open https://stud42.fr/clusters/$floor
}

function count.extension
{
	for j in *;do echo ${j##*.}; done | uniq -c
}

changeExtension()
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
###############################################################################
