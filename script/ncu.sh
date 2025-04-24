
#!/bin/bash
file_path="$1"

#swift
cd ../src

sudo ncu --set full -o prof_c-48 ./test -d 0 $file_path/c-48.mtx
sudo ncu --set full -o prof_rajat22 ./test -d 0 $file_path/rajat22.mtx
sudo ncu --set full -o prof_HEP-th ./test -d 0 $file_path/HEP-th.mtx
sudo ncu --set full -o prof_RFdevice ./test -d 0 $file_path/RFdevice.mtx
sudo ncu --set full -o prof_bundle1 ./test -d 0 $file_path/bundle1.mtx
#aspt

cd ../SOTA_methods/build/ASpT_SpMM_GPU

sudo ncu --set full -o aspt_c-48 ./ASpT_spmm_f64_n32 $file_path/c-48.mtx 32
sudo ncu --set full -o aspt_rajat22 ./ASpT_spmm_f64_n32 $file_path/rajat22.mtx 32
sudo ncu --set full -o aspt_HEP-th ./ASpT_spmm_f64_n32 $file_path/HEP-th.mtx 32
sudo ncu --set full -o aspt_RFdevice ./ASpT_spmm_f64_n32 $file_path/RFdevice.mtx 32
sudo ncu --set full -o aspt_bundle1 ./ASpT_spmm_f64_n32 $file_path/bundle1.mtx 32

cd ../eval

#rode #cusparse  #spuntiki

sudo ncu --set full -o rode_c-48 ./eval_spmm_f64_n32 $file_path/c-48.mtx
sudo ncu --set full -o rode_rajat22 ./eval_spmm_f64_n32 $file_path/rajat22.mtx
sudo ncu --set full -o rode_HEP-th ./eval_spmm_f64_n32 $file_path/HEP-th.mtx
sudo ncu --set full -o rode_RFdevice ./eval_spmm_f64_n32 $file_path/RFdevice.mtx
sudo ncu --set full -o rode_bundle1 ./eval_spmm_f64_n32 $file_path/bundle1.mtx





