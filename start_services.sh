echo 'installing packaages'
nohup Rscript installPackages.R > installPackages.log
echo 'finished installing packages (or all needed packages were already installed'
echo 'start first import of data and image creation'
nohup Rscript test.R > createimage.log
echo 'finished fist import, starting quasicronjob'
nohup Rscript myquasicronjob.R > myquasicronjob.log 2>&1 &
echo 'starting app'
nohup Rscript app.R > app.log 2>&1 &
echo 'all processes are running'