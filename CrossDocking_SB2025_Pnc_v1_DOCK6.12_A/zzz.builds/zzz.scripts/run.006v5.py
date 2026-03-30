#Initial counts of 0 for each atom type in 2 files. If you add any atom types these must be identical. There is a problem with copying tuples
atom_list1=[('H',0),('C',0),('N',0),('O',0),('F',0),('P',0),('S',0),('Cl',0),('Se',0),('Si',0),('Br',0),('I',0),('Ca',0),('Na',0),('Mg',0),('Zn',0),('LP',0)]
atom_list2=[('H',0),('C',0),('N',0),('O',0),('F',0),('P',0),('S',0),('Cl',0),('Se',0),('Si',0),('Br',0),('I',0),('Ca',0),('Na',0),('Mg',0),('Zn',0),('LP',0)]

with open('tmp1.txt','r') as file1:
   for line in file1:
      linestrip=line.rstrip()
      for i in range(len(atom_list1)):
         if linestrip==atom_list1[i][0]:
            tmp=atom_list1[i][1]+1
            atom_list1[i]=(atom_list1[i][0],tmp)

with open('tmp2.txt','r') as file2:
   for line in file2:
      linestrip=line.rstrip()
      for i in range(len(atom_list2)):
         if linestrip==atom_list2[i][0]:
            tmp=atom_list2[i][1]+1
            atom_list2[i]=(atom_list2[i][0],tmp)

#Before doing anything else combine Zn and LP and remove LP count
#Dont assume Zn and LP wll maintain index as this initial script
for i in range(len(atom_list1)):
   if atom_list1[i][0]=="Zn":
      Zn_ind=i
      Zn_cnt1=atom_list1[i][1]
      Zn_cnt2=atom_list2[i][1]
   if atom_list1[i][0]=="LP":
      LP_ind=i
      LP_cnt1=atom_list1[i][1]
      LP_cnt2=atom_list2[i][1]

#Balance by adding and substracting LP
#Zn = Zn + LP
atom_list1[Zn_ind][1]=Zn_cnt1+LP_cnt1
atom_list2[Zn_ind][1]=Zn_cnt2+LP_cnt2

#LP = LP - LP = 0   
atom_list1[LP_ind][1]=0
atom_list2[LP_ind][1]=0

#Atom formula
formula=""
for i in range(len(atom_list1)):
   if atom_list1[i][1] > 0:
      formula += (atom_list1[i][0] + str(atom_list1[i][1]) + " " )
print(formula)

difference_val=0
difference=""
#Atom differences
for i in range(len(atom_list1)):
   if atom_list1[i][1]!=atom_list2[i][1]:
      if i != 0:
         tmp_val=(atom_list1[i][1] - atom_list2[i][1])
         difference_val +=  tmp_val
      difference += (atom_list1[i][0]+" " + str(atom_list1[i][1] - atom_list2[i][1]) + " #")
print(difference)
print(difference_val)

