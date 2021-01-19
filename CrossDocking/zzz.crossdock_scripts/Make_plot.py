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
print(len(megalist))
mat = megalist
##########################################
N = len(megalist)

incomp = 0         
samp_f = 0
score_f = 0
succ = 0

cog_samp_f = 0
cog_score_f = 0
cog_succ = 0

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

      if i == j:
         if mat[i][j] == 1:
            cog_samp_f = cog_samp_f + 1
         if mat[i][j] == 2:
            cog_score_f = cog_score_f + 1
         if mat[i][j] == 3:
            cog_succ = cog_succ + 1

incomp_rate = incomp / ( N * N * 0.01)
samp_f_rate = samp_f / ( N * N * 0.01)
score_f_rate = score_f / ( N * N * 0.01)
succ_rate = succ / ( N * N * 0.01)

cog_samp_f_rate = cog_samp_f / ( N * 0.01)
cog_score_f_rate = cog_score_f / ( N * 0.01)
cog_succ_rate = cog_succ / ( N * 0.01)

print("The incompatible rate is " + "{:.2f}".format(incomp_rate) + "%")
print("The sample fail rate is " + "{:.2f}".format(samp_f_rate)+ "%")
print("The score fail rate is " + "{:.2f}".format(score_f_rate) + "%")
print("The success rate is " + "{:.2f}".format(succ_rate) + "%")

print("The cognate sample fail rate is " + "{:.2f}".format(cog_samp_f_rate)+ "%")
print("The cognate score fail rate is " + "{:.2f}".format(cog_score_f_rate) + "%") 
print("The cognate success rate is " + "{:.2f}".format(cog_succ_rate) + "%")

#########################################

cmap = ListedColormap(['#A0A0A0','r','g','b'])
if N < 18:
   fontsz = 12
   marksize = 6
elif N < 28:
   fontsz = 9
   marksize = 5
elif N < 38:
   fontsz = 8
   marksize = 4
else:
   fontsz = 6
   marksize = 3

line = mat

# Make a NxN grid...
nrows, ncols = N,N

image = np.array(line)
# Reshape things into a NxN grid.
image = image.reshape((nrows, ncols))
image = np.transpose(image)
row_labels = filelist
col_labels = filelist
plt.matshow(image,cmap=cmap,vmin=0,vmax=3)
plt.xticks(range(ncols), col_labels, rotation = 90, fontsize = fontsz)
plt.yticks(range(nrows), row_labels, fontsize = fontsz)
ax = plt.gca();
ax.set_xticks(np.arange(-.5, N, 1), minor=True);
ax.set_yticks(np.arange(-.5, N, 1), minor=True);
x=[]
y=[]
for i in range(N):
	x.append(i)
	y.append(i)
plt.plot(x, y, 'w.', markersize = marksize)
# Gridlines based on minor ticks
ax.grid(which='minor', color='k', linestyle='-', linewidth=1)
plt.savefig("heatmap.png")

