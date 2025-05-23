#compilers
CC=nvcc

#GLOBAL_PARAMETERS
MAT_VAL_TYPE = double
#双精度


NVCC_FLAGS = -O3 -w -arch=compute_61 -code=sm_86 -gencode=arch=compute_61,code=sm_86


#ENVIRONMENT_PARAMETERS
CUDA_INSTALL_PATH = /usr/local/cuda-12.2


#includes
INCLUDES = -I$(CUDA_INSTALL_PATH)/include -I/home/usr/NVIDIA_CUDA-12.2_Samples/common/inc

CUDA_LIBS = -L$(CUDA_INSTALL_PATH)/lib64  -lcudart -lcusparse
LIBS = $(CUDA_LIBS)

#options
OPTIONS = -Xcompiler -fopenmp -O3 #-std=c99

make:
	$(CC) $(NVCC_FLAGS) main.cu -o test  $(INCLUDES) $(LIBS) $(OPTIONS) -D MAT_VAL_TYPE=$(MAT_VAL_TYPE)
