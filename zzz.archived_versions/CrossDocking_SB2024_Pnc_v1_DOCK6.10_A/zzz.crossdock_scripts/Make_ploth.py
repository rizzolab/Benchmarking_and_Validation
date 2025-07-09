# This script makes a heatmap based on crossdocking results for a family and also prints out the docking statistics for cognate pairs in a family plus all
# off diagonal pairs
# Written by: Christopher Corbo
# Affiliation: Rizzo Lab, Stony Brook University
# Last Edit Date: 02/2021
# Last Edit by: Christopher Corbo
import sys
import matplotlib.pyplot as plt
import numpy as np
from matplotlib.colors import ListedColormap


inputfilename = sys.argv[1]
family = sys.argv[2]
print(family)
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

mat = megalist
##########################################
# Calculating statistics to be written out
# N is the size of the crossdocking family
N = len(megalist)

#Initializing the counters for all outcomes
incomp = 0         
samp_f = 0
score_f = 0
succ = 0

# This will keep track of cognate pair results
cog_samp_f = 0
cog_score_f = 0
cog_succ = 0

# Assesses every value in the matrix of crossdocking results
for i in range(N):
   for j in range(N):
      if mat[i][j] == 0:
         incomp = incomp + 1
      if mat[i][j] == 1:
         samp_f = samp_f + 1
      if mat[i][j] == 2:
         score_f = score_f + 1
      if mat[i][j] == 3:
         succ = succ + 1

      #Only assessing on diagonal cognate pairs
      if i == j:
         if mat[i][j] == 1:
            cog_samp_f = cog_samp_f + 1
         if mat[i][j] == 2:
            cog_score_f = cog_score_f + 1
         if mat[i][j] == 3:
            cog_succ = cog_succ + 1

Nred=(N*N)-incomp

#Calculate Percentage
incomp_rate = incomp / ( N * N * 0.01)
#samp_f_rate = samp_f / ( N * N * 0.01)
#score_f_rate = score_f / ( N * N * 0.01)
#succ_rate = succ / ( N * N * 0.01)
samp_f_rate = samp_f / ( Nred  * 0.01)
score_f_rate = score_f / ( Nred  * 0.01)
succ_rate = succ / ( Nred * 0.01)

#Calculate Percentage
cog_samp_f_rate = cog_samp_f / ( N * 0.01)
cog_score_f_rate = cog_score_f / ( N * 0.01)
cog_succ_rate = cog_succ / ( N * 0.01)

#Print out results
print("The size of is " + str(len(megalist)))
print(" ")

print("The matrix incompatible rate is " + "{:.2f}".format(incomp_rate) + "%")
print("The matrix sample fail rate is " + "{:.2f}".format(samp_f_rate)+ "%")
print("The matrix score fail rate is " + "{:.2f}".format(score_f_rate) + "%")
print("The matrix success rate is " + "{:.2f}".format(succ_rate) + "%")

print(" ")

print("The cognate sample fail rate is " + "{:.2f}".format(cog_samp_f_rate)+ "%")
print("The cognate score fail rate is " + "{:.2f}".format(cog_score_f_rate) + "%") 
print("The cognate success rate is " + "{:.2f}".format(cog_succ_rate) + "%")

print(" ")
print("+#+#+#+#+#+#+#+#+#+#+#+#+#+#+#+#+#+#+")
print(" ")
#########################################
# Formatting based on size of family
# Color map associated with results (blue success, green scoring failure, red sampling failure, gray incompatible)
cmap = ListedColormap(['#A0A0A0','r','g','b'])
if N < 18:
   # font size of labels
   fontsz = 12
   # bullet size on diagonal elements
   marksz = 5
   # size of grid lines
   linesz = 1.4
elif N < 28:
   fontsz = 9
   marksz = 4
   linesz = 1.2
elif N < 38:
   fontsz = 8
   marksz = 3
   linesz = 1
elif N < 48:
   fontsz = 6
   marksz = 2
   linesz = 0.8
else: 
   fontsz = 4
   marksz = 1
   linesz = 0.4
#########################################
# Making plots

# Make a NxN grid...
nrows, ncols = N,N

image = np.array(mat)
# Reshape things into a NxN grid.
image = image.reshape((nrows, ncols))
image = np.transpose(image)
row_labels = filelist
col_labels = filelist
plt.matshow(image,cmap=cmap,vmin=0,vmax=3)

# Uncomment following 2 lines if you want PDB Labels on x and y axis

#plt.xticks(range(ncols), col_labels, rotation = 90, fontsize = fontsz)
#plt.yticks(range(nrows), row_labels, fontsize = fontsz)

ax = plt.gca();
ax.set_xticks(np.arange(-.5, N, 1), minor=True);
ax.set_yticks(np.arange(-.5, N, 1), minor=True);
#Move ticks inside the graph for cleaner look
ax.tick_params(which='both',direction='in',width=0.01)

#Remove tick labels
ax.tick_params(labeltop=False,labelleft=False)

x=[]
y=[]
for i in range(N):
	x.append(i)
	y.append(i)
plt.plot(x, y, 'w.', markersize = marksz)
# Gridlines based on minor ticks
ax.grid(which='minor', color='k', linestyle='-', linewidth=linesz)
plt.savefig("heatmap.png")

