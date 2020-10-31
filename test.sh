#!/usr/bin/env bash

nohup Rscript test.R  > test.log 2>&1 &
Rscript test.R

echo 'finished v.2a'