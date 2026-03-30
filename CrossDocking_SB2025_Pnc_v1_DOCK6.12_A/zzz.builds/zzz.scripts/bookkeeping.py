#Initial counts of 0 for each atom type in 2 files. If you add any atom types these must be identical. There is a problem with copying tuples
atom_dict1={"H" : 0, "C" : 0, "N" : 0, "O" : 0, "F" : 0, "P" : 0, "S" : 0 , "Cl" : 0, "Se" : 0, "Br" : 0, "I" : 0, "Ca" : 0, "Na" : 0, "Mg" : 0, "Zn" : 0, "LP" : 0}
atom_dict2={"H" : 0, "C" : 0, "N" : 0, "O" : 0, "F" : 0, "P" : 0, "S" : 0 , "Cl" : 0, "Se" : 0, "Br" : 0, "I" : 0, "Ca" : 0, "Na" : 0, "Mg" : 0, "Zn" : 0, "LP" : 0}

with open('tmp1.txt','r') as file1:
   for line in file1:
      linestrip=line.rstrip()
      for key in atom_dict1:
         if linestrip == key:
            tmp=atom_dict1[key]+1
            atom_dict1[key]=tmp

with open('tmp2.txt','r') as file2:
   for line in file2:
      linestrip=line.rstrip()
      for key in atom_dict2:
         if linestrip == key:
            tmp=atom_dict2[key]+1
            atom_dict2[key]=tmp

#Before doing anything else combine Zn and LP and remove LP count
#Dont assume Zn and LP wll maintain index as this initial script
zn_cnt_1=atom_dict1['Zn']
lp_cnt_1=atom_dict1['LP']
zn_cnt_2=atom_dict2['Zn']
lp_cnt_2=atom_dict2['LP']


#Balance by adding and substracting LP
#Zn = Zn + LP
atom_dict1['Zn'] = zn_cnt_1 + lp_cnt_1
atom_dict2['Zn'] = zn_cnt_2 + lp_cnt_2

#LP = LP - LP = 0   
atom_dict1['LP']=0
atom_dict2['LP']=0

#Atom formula
formula=""
for key in atom_dict1:
   if atom_dict1[key] > 0:
      formula += (str(key) + str(atom_dict1[key]) + " " )
print(formula)

difference_val=0
difference=""

#Atom differences
for key in atom_dict1:
   if atom_dict1[key]!=atom_dict2[key]:
      if key != "H":
         tmp_val=(atom_dict1[key] - atom_dict2[key])
         difference_val +=  tmp_val
      difference += (str(key)+ " " + str(atom_dict1[key] - atom_dict2[key]) + " #")
print(difference)
print(difference_val)

