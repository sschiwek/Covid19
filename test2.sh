Rscript test.R > test2.log 2>&1 &
echo 'finished first'
nohup Rscript test.R
echo 'finished second'
nohup Rscript test.R > test.log 2>&1 &
nohup Rscript test.R > test1.log 2>&1 &
echo 'finished all'