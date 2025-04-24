#cmake_minimum_required(VERSION 3.10)
#project(DenseMatrix)

# 设置C++标准
#set(CMAKE_CXX_STANDARD 14)
#set(CMAKE_CXX_STANDARD 17)
# 找到Abseil库
#find_package(absl REQUIRED)



# 设置可执行文件
#add_executable(generate_matrix main.cpp)

#target_link_libraries(generate_matrix absl::random_random absl::base absl::status)

cmake_minimum_required(VERSION 3.10)

# 项目信息
project(TestProject LANGUAGES CXX CUDA)

# 设置编译器标志
set(NVCC_FLAGS -O3 -w -arch=compute_61 -code=sm_86 -gencode=arch=compute_61,code=sm_86)
# set(NVCC_FLAGS -w -arch=compute_61 -code=sm_86 -gencode=arch=compute_61,code=sm_86)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD 17)
find_package(absl REQUIRED)
message(STATUS "${NVCC_FLAGS}")
# 设置全局参数
set(MAT_VAL_TYPE double)

# 设置CUDA路径
set(CUDA_INSTALL_PATH /usr/local/cuda-12.2)

# 包含头文件路径
include_directories(${CUDA_INSTALL_PATH}/include /home/usr/NVIDIA_CUDA-11.1_Samples/common/inc)

# 链接库路径和库
link_directories(${CUDA_INSTALL_PATH}/lib64)
set(CUDA_LIBS cudart cusparse)

set(ABSL_LIBS absl::random_random absl::base absl::status)

# 选项
set(OPTIONS -Xcompiler -fopenmp)  # -std=c99 可以根据需要取消注释

# 添加可执行文件
add_executable(test main.cu)

# 设置编译选项
target_compile_options(test PRIVATE ${NVCC_FLAGS} ${OPTIONS})
target_compile_definitions(test PRIVATE MAT_VAL_TYPE=${MAT_VAL_TYPE})

# 链接库
target_link_libraries(test PRIVATE ${CUDA_LIBS})
target_link_libraries(test PRIVATE ${ABSL_LIBS})
