# Swift

Swift

|- DataProcess

|- MTX

|- MTX-samples

|- script

|- SOTA_methods

|- src

|- test

compile.sh

Makefile

Readme

SOTA_method_compile.sh



## How to compile:

1 Modify Makefile file: change the install directory of CUDA

2 **Uncomment** the three lines of code in **compile.sh**

3 ./compile.sh

## How to compile SOTA method:

1 ./SOTA_method_compile.sh



## How to test:

1 cd script

2 ./Function_test.sh  

./ncu.sh                                     

./Run_CMA_compare.sh /Matrix Directory

./Run_FP32.sh /Matrix Directory

./Run_FP64.sh /Matrix Directory

./Run_idealCMA /Matrix Directory

./Run_irr_opt /Matrix Directory

./Run_irr_regular_ratio.sh /Matrix Directory

./Run_preprocess.sh /Matrix Directory

./Run_SOTA_method.sh  /Matrix Directory /FP64_storage_directory /FP32_storage_directory



## The function of the other script in script file:

./Function_test.sh                     (This script is used to test if the compilation is successful)

./ncu.sh                                      (This script is used to test the memory bandwidth  via the Nsight compute)

./Run_CMA_compare.sh         (This script is used to compare the Swift with or without coalesced memory access)

./Run_FP32.sh                          (This script is used to test the Swift with FP32)

./Run_FP64.sh                          (This script is used to test the Swift with FP64)

./Run_idealCMA                       (This script is used to test the ideal situation of matrix multiplication with or without coalesced memory access)

./Run_irr_opt                            (This script is used to compare the Swift with or without optimization of the regular part)

./Run_irr_regular_ratio.sh     (This script is used to categorize the ratio of regular and irregular parts of the sparse matrix after the pre-processing of Swift)

./Run_preprocess.sh              (This script is used to test the preprocess time of Swift)

./Run_SOTA_method.sh              (This script is used to test the SOTA methods)



## How to download matrices:

cd MTX

./Data_get.sh

