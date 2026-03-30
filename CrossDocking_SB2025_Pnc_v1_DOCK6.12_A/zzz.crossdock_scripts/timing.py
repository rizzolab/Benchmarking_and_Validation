import sys

file= sys.argv[1]
file1 = open(file,'r')
lines  =  file1.readlines()

file1.close()

for line in lines:
    line = line.rstrip()
    if "elapsed" in line:
        line = line.split()
        sec=line[3]
        print(sec)
