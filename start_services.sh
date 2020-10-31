echo 'start first import of data and image creation'
nohup Rscript test.R > createimage.log
echo 'finished fist import, starting quasicronjob'
nohup Rscript myquasicronjob.R > myquasicronjob.log 2>&1 &
echo 'starting app'
nohup Rscript app.R > app.log 2>&1 &
echo 'all processes are running'