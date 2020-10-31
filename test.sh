#!/usr/bin/env bash

nohup Rscript test.R  > test.log 2>&1 &
nohup Rscript test.R  > test1.log 2>&1 &

echo 'finished v.2a'