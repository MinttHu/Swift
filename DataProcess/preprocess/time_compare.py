#! /usr/bin/python3

import numpy as np
import matplotlib.pyplot as plt



data_A = np.genfromtxt('SOTA_method_preprocess.txt', delimiter=' ')
data_B = np.genfromtxt('preprocess.txt', delimiter=' ')


colors1 = [(250/255, 130/255, 0/255, 1.0)]

colors2 = [(254/255, 183/255, 5/255, 1.0)]

colors3 = [ (33/255, 158/255, 188/255, 1.0)]

colors4 = [(2/255, 48/255, 74/255, 1.0)]

x_A = data_A[:, 3]  
  

y_B = data_A[:, 4] #ASpT
 
y_C = data_A[:, 5] #Sputnik

y_D = data_A[:, 6] #RoDe


x_C = data_B[:, 8]
y_A = data_B[:, 18]

threshold = 1.0 


x_A_log = np.log10(x_A)

x_C_log = np.log10(x_C)

y_A_log = np.log10(y_A)
y_B_log = np.log10(y_B)
y_C_log = np.log10(y_C)
y_D_log = np.log10(y_D)


plt.figure(figsize=(10, 5)) 

plt.scatter(x_A_log, y_B, c=colors2, s=45,marker = '>', label='ASpT')
plt.scatter(x_A_log, y_D, c=colors4, s=45,marker = '+', label='RoDe')
plt.scatter(x_A_log, y_C, c=colors3, s=45, marker = 's',label='Sputnik')
plt.scatter(x_C_log, y_A, c=colors1, s=45,marker = 'x',label='Swift')



plt.tick_params(labelsize=25)
plt.legend(loc='upper right', ncol=4 ,columnspacing=0.05,markerscale=2,bbox_to_anchor=(1.0, 1.18),prop = {'size':20}, facecolor='none', edgecolor='none')



plt.xlabel('nnz of sparse matrix (log10 scale)',fontsize=25)

plt.ylabel('Time (ms)',fontsize=25)


plt.savefig('time_preprocess_32.pdf',bbox_inches='tight')
