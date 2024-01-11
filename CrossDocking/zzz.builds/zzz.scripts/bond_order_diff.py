import mol2
import sys

list_1=[]
list_2=[]

filename=sys.argv[1]
mola=mol2.read_Mol2_file(filename)
for i in range(len(mola[0].bond_list) ):
   
   a1=(mola[0].bond_list[i].a1_num)-1
   a2=(mola[0].bond_list[i].a2_num)-1
   bt=(mola[0].bond_list[i].type)

   tmp_list=[]
   tmp_list.append(mola[0].atom_list[a1].name)
   tmp_list.append(mola[0].atom_list[a2].name)
   tmp_list.append(bt)
   list_1.append(tmp_list)

filename=sys.argv[2]
molb=mol2.read_Mol2_file(filename)
for i in range(len(molb[0].bond_list) ):

   a1=(molb[0].bond_list[i].a1_num)-1
   a2=(molb[0].bond_list[i].a2_num)-1
   bt=(molb[0].bond_list[i].type)

   tmp_list=[]
   tmp_list.append(molb[0].atom_list[a1].name)
   tmp_list.append(molb[0].atom_list[a2].name)
   tmp_list.append(bt)
   list_2.append(tmp_list)

if len(list_1) != len(list_2):
   print("NOT SAME NUMBER OF ATOMS")

for i in range(len(list_1)):
   match=0
   for j in range(len(list_2)):
      if list_1[i][0] == list_2[j][0] or list_1[i][0] == list_2[j][1]:
         if list_1[i][1] == list_2[j][0] or list_1[i][1] == list_2[j][1]:      
            match=1
            if(list_1[i][2] != list_2[j][2]):
               print(str(list_1[i]) + " " +  str(list_2[j]))
            #else:
            #   print("GOOD")
   if match == 0:
      print("No Match: " + str(list_1[i]))



 
