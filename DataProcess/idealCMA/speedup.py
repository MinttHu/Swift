#! /usr/bin/python3

#with open('ideal-cma.txt', 'r') as file:
with open('ideal-cma-128.txt', 'r') as file:
    lines = file.readlines()

new_lines = []
for line in lines:
    columns = line.split()
    

    column1 = float(columns[10])  #row


    column5 = float(columns[12]) #col
    

    column1_scaled = column1 * 1000000

    column5_scaled = column5 * 1000000
    

    if column5_scaled != 0:
        result1 = column1_scaled / column5_scaled #row / col
                   
    else:
        result1 = 'N/A'
            

    new_line = line.strip() + ' ' + str(result1) + '\n'
    new_lines.append(new_line)

with open('results_spmm_128_full.txt', 'w') as file:
    file.writelines(new_lines)
