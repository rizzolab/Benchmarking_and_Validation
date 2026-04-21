import sys

system = sys.argv[1]
file=system + ".docking.noH.mol2"
	
file1 = open(file,'r')
lines  =  file1.readlines()

file1.close()

Var1 = []
Var2 = []

i = 0  
for line in lines:
    linesplit = line.split() #split on white space
    if (len(linesplit) == 1):
        if(linesplit[0] == "@<TRIPOS>ATOM"):
        	Var1.append(i)
    i = i + 1

i = 0  
for line in lines:
    linesplit = line.split() #split on white space
    if (len(linesplit) == 1):
        if(linesplit[0] == "@<TRIPOS>BOND"):
        	Var2.append(i)
    i = i + 1

i = 0
for line in lines:
    linesplit = line.split() #split on white space
    if (len(linesplit) == 1):
        if(linesplit[0] == "@<TRIPOS>SUBSTRUCTURE"):
                Var3.append(i)
    i = i + 1

file_ref=system + ".lig.gast.noH.mol2"
	
file1_ref = open(file_ref,'r')
lines_ref  =  file1_ref.readlines()

file1_ref.close()


i = 0  
for line_ref in lines_ref:
    linesplit_ref = line_ref.split() #split on white space
    if (len(linesplit_ref) == 1):
        if(linesplit_ref[0] == "@<TRIPOS>ATOM"):
        	Var1_ref = i
    i = i + 1

i = 0  
for line_ref in lines_ref:
    linesplit_ref = line_ref.split() #split on white space
    if (len(linesplit_ref) == 1):
        if(linesplit_ref[0] == "@<TRIPOS>BOND"):
        	Var2_ref = i
    i = i + 1
splitline_ref = []

for i in range(Var1_ref + 1,Var2_ref ,1):
	splitline_ref.append(lines_ref[i].split())


splitline = []


for j in range (len(Var1)):
	x= 0
	for i in range(Var1[j] + 1,Var2[j] ,1):
		splitline.append(lines[i].split())
		splitline[x+j*len(splitline_ref)][5] = splitline_ref[x][5]
		x = x + 1
info = lines_ref[2].split() 
bond_num = info[1]

x = 0
for j in range (len(Var1)):
	for i in range (0,Var1[0] ,1):
		print(lines[i].rstrip())
	print("@<TRIPOS>ATOM")
	for m in range (Var2_ref - Var1_ref - 1):
		print(splitline[x][0] + " " + splitline[x][1] + " " + splitline[x][2] + " " + splitline[x][3] + " " + splitline[x][4] + " " + splitline[x][5] + " " + splitline[x][6] + " " + splitline[x][7] + " " + splitline[x][8] )
		x = x + 1
	for i in range (Var2_ref,Var2_ref + int(bond_num) + 1):
		print(lines[i].rstrip())
	

