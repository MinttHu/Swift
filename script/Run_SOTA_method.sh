#!/bin/bash
DATA_PATH1=$1
OUTPATH1=$2
OUTPATH2=$3

cd ../SOTA_methods/script

./ASpT_eval_64.sh $1 $2
./ASpT_eval.sh $1 $3
./eval_64.sh $1 $2
./eval.sh $1 $3

