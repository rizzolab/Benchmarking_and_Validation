### This script will determine each crossdocking pairing as incompatible, success, scoring failure or sample failure. The minimization output
### mol2 is the first arguement and the dock output mol2 is the second argument.

import sys
minfilename = sys.argv[1]                                                                                                                                             
file_name = 'minfilename'

with open(minfilename) as min_object:
   min_lines = min_object.readlines()

for min_line in min_lines:
        if "RMSDh" in min_line:
                RMSDh_min = min_line.split()
                RMSDh_min_float = float((RMSDh_min[2]))

if RMSDh_min_float > 2.0:
	print("0") #Incompatible
else:
###########
### If the minimized mol2 deviated by less than 2.0 RMSDh the docked output mol2 is checked for its outcome
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
	if my_list[0] < 2.0:
		print("3") #Success

	else:
		my_list.sort()
		if my_list[0] < 2.0:
			print("2") #Score Failure
		else:
			print("1") #Sample Failure
	
