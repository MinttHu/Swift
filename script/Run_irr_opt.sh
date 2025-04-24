#!/bin/bash
file_path="$1"

cd ../test/k-32/irr_opt
./eval_spmm.sh $file_path

cd data
mv *.txt ../../../../DataProcess/irr_opt

cd ../../../k-128/irr_opt-128
./eval_spmm.sh $file_path

cd data
mv *.txt ../../../../DataProcess/irr_opt