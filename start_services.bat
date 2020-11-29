echo 'installing packages'
Rscript installPackages.R
echo 'finished installing packages (or all needed packages were already installed)'
echo 'start first import of data and image creation'
Rscript createImagefromR.R
echo 'starting app'
Rscript app.R
echo 'all processes are running'