# This script sorts crossdocking families by the score of each receptor on all of its results (success = 3, score fail = 2, sample fail = 1)
# Written by: Christopher Corbo
# Affiliation: Rizzo Lab, Stony Brook University
# Last Edit Date: 02/2021
# Last Edit by: Christopher Corbo
import sys
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.colors import ListedColormap

# Input argument list of PDB code in family
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
   filename = (filelist[i] + ".outcomeh.txt")
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
# This function sums the score for all results on each receptor by moving the max score to the top row, and then starting the scan on the next lowest row after 
# each round.
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
