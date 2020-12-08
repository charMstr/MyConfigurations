#!/bin/sh

cd

#create the folder where we place the vim plugins
[ -d .vim/plugin ] || mkdir -p .vim/plugin
cp MyConfigurations/.vim/plugin/* .vim/plugin/

#create the folder where we place the filetype recognition files.
[ -d .vim/ftdetect ] || mkdir -p .vim/ftdetect
cp MyConfigurations/.vim/ftdetect/* .vim/ftdetect/

#create the folder where i place the filetype plugin files.
[ -d .vim/ftplugin ] || mkdir -p .vim/ftplugin
cp MyConfigurations/.vim/ftplugin/* .vim/ftplugin/

#place the .vimrc
ln -sf MyConfigurations/.vimrc .vimrc

#place the .zshrc
ln -sf MyConfigurations/.zshrc .zshrc

#place the lldb.init
ln -sf MyConfigurations/.lldbinit .lldbinit

#shell functions and lib
[ -d .shell_lib ] || mkdir .shell_lib
[ -d .shell_scripts ] || mkdir .shell_scripts
cp MyConfigurations/.shell_lib/display_colors.lib .shell_lib/
cp MyConfigurations/.shell_lib/install_python_42ai.lib .shell_lib/
cp MyConfigurations/.shell_scripts/keep_lock_files_in_tmp_for_brew.sh .shell_scripts/
