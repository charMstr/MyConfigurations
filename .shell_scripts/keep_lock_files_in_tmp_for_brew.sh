#!/bin/sh

# HOMEBREW CONFIG

# CREAT A FOLDER IN THE /TMP
if [ ! -d /tmp/$USER ]
then
	mkdir -m 700 /tmp/$USER
	echo "\033[33;mdone creating the $USER folder in the /tmp\033[0m"
fi

# Set Homebrew temporary folders
export HOMEBREW_CACHE=/tmp/$USER/Homebrew/Caches
export HOMEBREW_TEMP=/tmp/$USER/Homebrew/Temp
mkdir -p $HOMEBREW_CACHE
mkdir -p $HOMEBREW_TEMP
HOMEBREW_LOCKS_TARGET=/tmp/$USER/Homebrew/Locks
HOMEBREW_LOCKS_FOLDER=$HOME/.brew/var/homebrew
mkdir -p $HOMEBREW_LOCKS_TARGET
mkdir -p $HOMEBREW_LOCKS_FOLDER
# Symlink to Locks target folders
# If not already a symlink
if ! [[ -L $HOMEBREW_LOCKS_FOLDER && -d $HOMEBREW_LOCKS_FOLDER ]]; then
  echo "Creating symlink for Locks folder"
  rm -rf $HOMEBREW_LOCKS_FOLDER
  ln -s $HOMEBREW_LOCKS_TARGET $HOMEBREW_LOCKS_FOLDER
fi
