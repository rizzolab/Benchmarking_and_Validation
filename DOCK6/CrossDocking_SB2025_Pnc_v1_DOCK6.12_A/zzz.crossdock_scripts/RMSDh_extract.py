# This script assesses the outcome of each crossdocking result for a given family. 
# The minimization output mol2 is the first arguement and the dock output mol2 is the second argument. 
# Written by: C Corbo
# Affiliation: Rizzo Lab, Stony Brook University
# Last Edit Date: 02/2025
# Last Edit by: C Corbo

import sys
minfilename = sys.argv[1]                                                                                                                                             
file_name = 'minfilename'

with open(minfilename) as min_object:
   min_lines = min_object.readlines()

for min_line in min_lines:
        if "RMSDh" in min_line:
                RMSDh_min = min_line.split()
                RMSDh_min_float = float((RMSDh_min[2]))
        if "Grid_Score" in min_line:
                Grid_score = min_line.split()
                Grid_score_float = float((Grid_score[2]))
#min_status checks if minimization was successful, and if so check docking outcome
min_status=1
# If the cartesian minimized molecule moved by more than 2 A RMSD from crystal structure the crossdocking pair is incompatible
try:
   if RMSDh_min_float > 2.0:
       print("0") #Steric Incompatible
       min_status=0
   elif Grid_score_float > 0.0:
       print("0") #Positive score in minimization
       min_status=0
except NameError:
   print("0") #Did not minimize, likely doesnt fit in grid box
   min_status=0
##################################
if min_status==1:
### If the minimized mol2 deviated by less than 2.0 RMSDh the docked output mol2 is checked for its outcome
    try:
       inputfilename = sys.argv[2]

       file_name = 'inputfilename'

       with open(inputfilename) as file_object:
          lines = file_object.readlines()
       my_list=[]
       for line in lines:
           if "RMSDh" in line:
               RMSDh = line.split()
               RMSDh_float = float((RMSDh[2]))
               my_list.append(RMSDh_float)
       # If the first ranked pose has RMSD less than 2 A its a success
       if my_list[0] < 2.0:
           print("3") #Success
       # Otherwise sort the results on RMSD and check the lowest RMSD that was found
       else:
           my_list.sort()
           if my_list[0] < 2.0:
               print("2") #Score Failure
           else:
               print("1") #Sample Failure
    except IndexError:  # IF docking did not run successfully there will be no file
       print("1") #Sample Failure    
