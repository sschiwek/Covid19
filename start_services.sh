echo 'installing packages'
nohup Rscript installPackages.R > loginstallPackages.log
echo 'finished installing packages (or all needed packages were already installed)'
echo 'start first import of data and image creation'
nohup Rscript createImage.R > logcreateimage.log
echo 'finished fist import, starting quasicronjob'
nohup Rscript myquasicronjob.R > logmyquasicronjob.log 2>&1 &
echo 'starting app'
nohup Rscript app.R > logapp.log 2>&1 &
echo 'all processes are running'