#include <iostream>
#include <vector>
#include "sys/time.h"
//#include "absl/random/random.h"

#include "coo2csc.h"
#include "Swift_cpu.h"
#include "gpu_csr2csc.h"
#include "gpu_cusparse_spmm.h"
#include "Swift_gpu_row_major.h"
#include "Swift_gpu_col_major.h"
#include "Swift.h"

#include "balance.h"
#include "block_catgory.h"

#include "ColSort_cuda.h"
#include "formatTransform_cuda.h"
#define BN 32

#ifndef VERIFYCSC
#define VERIFYCSC 1
#endif


int main(int argc, char ** argv)
{
    if(argc <2)
    {
        printf("error order\n");
        return 0;
    }

   int device_id = 0;
    // "Usage: ``./spmv -d 0 mtx A.mtx'' for Ax=y on device 0"
    int argi = 1;

    // load device id
    char *devstr;
    if(argc > argi)
    {
        devstr = argv[argi];
        argi++;
    }

    if (strcmp(devstr, "-d") != 0) return 0;

    if(argc > argi)
    {
        device_id = atoi(argv[argi]);
        argi++;
    }



    cudaSetDevice(device_id);
    cudaDeviceProp deviceProp;
    cudaGetDeviceProperties(&deviceProp, device_id);


    printf("---------------------------------------------------------------------------------------------\n");
    printf("Device [ %i ] %s @ %4.2f MHz\n", device_id, deviceProp.name, deviceProp.clockRate * 1e-3f);


	char  *filename;
    filename = argv[3];


    int rowA,colA,nnz;
    int isSymmetricA;
    double *csrval;
    int *csrrowptr;
    int *csrcolidx;

    mmio_allinone(&rowA, &colA, &nnz, &isSymmetricA, &csrrowptr, &csrcolidx, &csrval ,filename);

//|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-
    std::string filePath(filename);

    size_t pos = filePath.find_last_of("/\\");

    std::string fileName;
    if (pos != std::string::npos) {
        fileName = filePath.substr(pos + 1);
    } else {
        fileName = filePath;
    }
    size_t dotPos = fileName.find_last_of('.');
    if (dotPos != std::string::npos) {
        fileName = fileName.substr(0, dotPos);
    }
    filename = new char[fileName.length() + 1];
    std::strcpy(filename, fileName.c_str());
//|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-|-

    printf("read success,input matrix A :(%i,%i) nnz =%i  width=%d \n",rowA,colA,nnz,BN);
  

    double *dense_matrix = (double *)malloc(sizeof(double) * colA*BN);
    memset(dense_matrix,0, sizeof(double) * colA*BN);

    unsigned seed;
    seed = time(0);
    srand(seed);
    for (int i=0; i<colA*BN; i++) 
    {
        dense_matrix[i] = double(rand() %100 - 50)/100;
    }

    for (int i=0; i<nnz; i++) 
    {
        csrval[i] = double(rand() %1000 - 500)/1000;
        //csrval[i] = i % 10 + 1;
    }


    double *golden_matrix_c = (double *)malloc(sizeof(double)*rowA *BN);
    memset(golden_matrix_c,0, sizeof(double) * rowA*BN);  



    for(int i=0; i<rowA;i++)
    {
      for(int j=csrrowptr[i]; j<csrrowptr[i+1]; j++)
      {
        for(int k=0; k<BN; k++)
        {
          int dense_index = csrcolidx[j] *  BN;
          golden_matrix_c[i*BN + k] += csrval[j] * dense_matrix[dense_index + k];
        }
      }
    }

    double *result_cusparse_spmm = (double *)malloc(sizeof(double)*rowA *BN);
    memset(result_cusparse_spmm,0, sizeof(double) * rowA*BN);
    double *result_cusparse_spmm1 = (double *)malloc(sizeof(double)*rowA *BN);
    memset(result_cusparse_spmm1,0, sizeof(double) * rowA*BN);
    double *dense_matrix1 = (double *)malloc(sizeof(double) * colA*BN);
    memset(dense_matrix1,0, sizeof(double) * colA*BN);

    dense_mtx2dense_mtx_spmm(colA, BN, dense_matrix, dense_matrix1);

    float time_cusparse_spmm = 0;
    float time_cusparse_spmm_pre=0;
    cusparse_spmm(time_cusparse_spmm_pre, time_cusparse_spmm, 
                  rowA, colA, nnz,
                  colA, BN, 
                  csrrowptr, csrcolidx, csrval,
                  dense_matrix1,
                  result_cusparse_spmm1);
    dense_mtx2dense_mtx_spmm(BN, rowA, result_cusparse_spmm1, result_cusparse_spmm);
#if VERIFYCSC
    int error_cusparse_spmm=0;
    ResultVerify(result_cusparse_spmm, golden_matrix_c, rowA*BN, error_cusparse_spmm);
    if(error_cusparse_spmm !=0)
    {
        printf("error cuSPARSE SpMM, error = %d\n", error_cusparse_spmm); 
        time_cusparse_spmm = -1111;
        time_cusparse_spmm_pre = -1111;
    }
    else
    {
        printf("success cuSPARSE SpMM,Time pre: %f ms, process:%f ms\n", time_cusparse_spmm_pre,time_cusparse_spmm);
    }
#endif



    int *cscrowidx = (int *)malloc(sizeof(int) * (nnz));
    memset(cscrowidx, 0, sizeof(int)*(nnz));


    int *csccolptr = (int *)malloc(sizeof(int) * (colA +1));
    memset(csccolptr, 0, sizeof(int)*(colA+1));

    int *nnzpercol=(int *)malloc(sizeof(int)*(colA));
    memset(nnzpercol, 0 ,sizeof(int)*(colA));


    double *cscval= (double *)malloc(sizeof(double)* (nnz));   
    memset(cscval, 0, sizeof(double)*(nnz));

    double csr2cscTime = 0;
    csr_to_csc(csr2cscTime, rowA, colA, nnz, csrval, csrrowptr, csrcolidx, cscval, cscrowidx, csccolptr, nnzpercol);

    double *testcsc_matrix_c = (double *)malloc(sizeof(double)*rowA *BN);
    memset(testcsc_matrix_c,0, sizeof(double) * rowA*BN); 

    for(int i=0; i<colA; i++)
    {
      for(int j=csccolptr[i]; j<csccolptr[i+1]; j++)
      {
        for(int k=0; k<BN; k++)
        {
          int row_index = cscrowidx[j];
          int dense_index = i * BN;
          testcsc_matrix_c[row_index *BN +k] += cscval[j] * dense_matrix[i *BN+k];
        }
      }
    }


#if VERIFYCSC
    int errorCSC=0;
    ResultVerify(testcsc_matrix_c, golden_matrix_c, rowA*BN, errorCSC);
    if(errorCSC !=0)
    {
        printf("error format csc, error = %d\n", errorCSC); 
    }
    else
    {
        printf("success format csc\n");
    }
#endif


    slide_matrix *matrixA = (slide_matrix *)malloc(sizeof(slide_matrix));

    int *sortrowidx_tmp = (int *)malloc(sizeof(int)*nnz);

    double *sortval_tmp = (double *)malloc(sizeof(double)*nnz);

    int *sortnnz_tmp= (int *)malloc(sizeof(int)*(colA+1));

    double *sort_dense_mtx = (double *)malloc(sizeof(double)*colA * BN);  
    memset(sort_dense_mtx,0,sizeof(double)*colA*BN);

double time_colsort = 0;

timeval tcolsort1, tcolsort2;

gettimeofday(&tcolsort1, NULL);

    col_sort(colA,
             BN,
             nnzpercol,
             csccolptr,
             cscrowidx,
             cscval,
              
             sortrowidx_tmp,
             sortval_tmp,
             sortnnz_tmp,
             
             dense_matrix,
             sort_dense_mtx);  


gettimeofday(&tcolsort2, NULL);  
time_colsort = (tcolsort2.tv_sec - tcolsort1.tv_sec) * 1000.0 + (tcolsort2.tv_usec - tcolsort1.tv_usec) / 1000.0;



double time_transform = 0;
double time_irrepart = 0;
timeval ttransform1, ttransform2;
gettimeofday(&ttransform1, NULL);
    
    double reside_ratio=0;
    formattransation(time_irrepart,
                     matrixA,
                     sortrowidx_tmp,
                     sortval_tmp,
                     sortnnz_tmp,
                     
                     nnz,
                     rowA,
                     colA,
                     reside_ratio);

    double shuffle_ratio = 0;
    block_catgory(matrixA,shuffle_ratio);

gettimeofday(&ttransform2, NULL); 
time_transform = (ttransform2.tv_sec - ttransform1.tv_sec) * 1000.0 + (ttransform2.tv_usec - ttransform1.tv_usec) / 1000.0;




    double *result_mtx = (double *)malloc(sizeof(double) * rowA*BN);
    memset(result_mtx,0, sizeof(double) * rowA*BN);
    double time_fastload_cpu=0;
    FastLoad_cpu(time_fastload_cpu,
                 matrixA,
                 nnz,
                 rowA,
                 colA,
                 BN,

                 sort_dense_mtx,
                 result_mtx);

#if VERIFYCSC
    int errorCPU=0;
    ResultVerify(result_mtx, golden_matrix_c, rowA*BN, errorCPU);
    if(errorCPU !=0)
    {
        printf("error FastLoad CPU, error = %d\n", errorCPU); 
    }
    else
    {
        printf("success FastLoad CPU time: %f ms\n",time_fastload_cpu);
    }
#endif




    float time_fastload_gpu=0;
    double gflops_fastload_gpu=0;

    float time_fastload_gpu1=0;
    double gflops_fastload_gpu1=0;

    float time_fastload_gpu2=0;
    double gflops_fastload_gpu2=0;
    memset(result_mtx,0, sizeof(double) * rowA*BN);     

    double *sort_dense_mtx1 = (double *)malloc(sizeof(double)*colA * BN);  
    memset(sort_dense_mtx1,0,sizeof(double)*colA*BN);
    dense_mtx2dense_mtx_spmm(colA, BN, sort_dense_mtx, sort_dense_mtx1);



    Swift_gpu1(filename,
               time_fastload_gpu,
               gflops_fastload_gpu,
               matrixA,
               rowA,
               colA,
               BN,
               nnz,
               sort_dense_mtx1,
               result_mtx,
               golden_matrix_c);

    memset(result_mtx,0, sizeof(double) * rowA*BN);

    int reside_n = matrixA->reside_col;
    int reside_nnz = matrixA->reside_nnz;
    int *reside_ptr = matrixA->reside_cscptr;
    int *reside_rowidx = matrixA->reside_cscrowidx;

double time_balance = 0;
timeval tbalance1, tbalance2;
gettimeofday(&tbalance1, NULL);

    balance(matrixA,
             rowA, reside_n, reside_nnz,
             reside_ptr,
             reside_rowidx);

gettimeofday(&tbalance2, NULL); 
time_balance = (tbalance2.tv_sec - tbalance1.tv_sec) * 1000.0 + (tbalance2.tv_usec - tbalance1.tv_usec) / 1000.0;



    Swift_gpu2(filename,
                  time_fastload_gpu1,
                  gflops_fastload_gpu1,
                  matrixA,
                  rowA,
                  colA,
                  BN,
                  nnz,
                  sort_dense_mtx,
                  result_mtx,
                  golden_matrix_c);

    memset(result_mtx,0, sizeof(double) * rowA*BN);


    Swift_GPU(filename,
              time_fastload_gpu2,
              gflops_fastload_gpu2,
              matrixA,
              rowA,
              colA,
              BN,
              nnz,
              sort_dense_mtx1,
              result_mtx,
              golden_matrix_c);



    float time_final;
    result_check(time_fastload_gpu, time_fastload_gpu1, time_fastload_gpu2, time_final);
  
    if (time_final != -1)
    {
     
        FILE *fout = fopen("data/results_spmm_32.txt", "a");
        if (fout == NULL)
            printf("Writing results fails.\n");
        fprintf(fout, "%s m %d n %d width %d nnz %d reside_ratio %f shuffle_ratio %f cuSPARSE: %f final %f \n",
            filename,rowA, colA, BN, nnz,reside_ratio,shuffle_ratio, time_cusparse_spmm,time_final);
        fclose(fout);
        
    }
    else
    {
        printf("FastLoad GPU SpMM Check NO PASS!\n");
        FILE *fout = fopen("data/results_spmm_32.txt", "a");
        if (fout == NULL)
            printf("Writing results fails.\n");
        fprintf(fout, "erro Swift (dense mtx col-major)%s \n",
                       filename );
        fclose(fout);
    }




    free(dense_matrix);
    free(dense_matrix1);
    free(golden_matrix_c);
    free(result_cusparse_spmm);
    free(result_cusparse_spmm1);
    free(cscrowidx);
    free(csccolptr);
    free(nnzpercol);
    free(cscval);
    free(testcsc_matrix_c);
    free(sortrowidx_tmp);
    free(sortval_tmp);
    free(sortnnz_tmp);
    //free(result_mtx);
    free(sort_dense_mtx); 
}