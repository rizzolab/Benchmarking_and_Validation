import sys
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.colors import ListedColormap


inputfilename = sys.argv[1]
filelist = []


#This will read a list of the actual lists containing data's names which will be used to call these individual files
file_name = 'inputfilename'
with open(inputfilename) as file_object:
   lines = file_object.readlines()
for line in lines:
   value = line.rstrip()
   filelist.append(value)

#This creates a list of all the individual sublists by appending individual lists first and then appending these inner lists to the outer list
megalist = []
for i in range(len(filelist)): # This loop specifies which list is being read
   datalist = []
   filename = (filelist[i] + ".outcome.txt")
   with open(filename) as file_object:
      lines = file_object.readlines()
   for line in lines:
      value = line.rstrip()
      value = int(value)
      datalist.append(value)
   megalist.append(datalist)


#######################################
N = len(megalist)
num = [0] * N
mat = megalist
mat = np.transpose(mat)
mat = mat.tolist()

def Matrix_Resort_Score(mat):
	for C in range(N):
		summat = [0]*N
		for i in range(C,N):
			summat[i] = sum(mat[i])
		num_max = summat.index(max(summat))
		(mat[num_max]), mat[C] = mat[C], (mat[num_max])
		(filelist[num_max]), filelist[C] = filelist[C], (filelist[num_max])
	return(filelist)
	


filelist = Matrix_Resort_Score(mat)
for i in range(N):
	print(filelist[i])
##########################################
