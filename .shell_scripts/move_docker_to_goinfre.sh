#######################################################
##### Verifie si les dossiers necessaire a docker #####
########################################################
if [ -d "$HOME/goinfre" ]; then
   rm -rf -v ~/Library/Containers/com.docker.docker
   rm -rf -v ~/.docker
   rm -rf -v /goinfre/${USER}/docker /goinfre/${USER}/agent
   mkdir -p -v /goinfre/${USER}/docker /goinfre/${USER}/agent
   ln -s -v /goinfre/${USER}/agent ~/Library/Containers/com.docker.docker
   ln -s -v /goinfre/${USER}/docker ~/.docker
fi
