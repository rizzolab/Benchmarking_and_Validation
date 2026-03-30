a = 1
b = 2
some_dict = {}
some_dict['zinc']= 1
some_dict['chlor']=0
print some_dict
print some_dict['zinc']
some_dict['zinc']= 11
some_dict['chlor']=0
print some_dict
another_dict = some_dict
another_dict['chlor']=1
print some_dict
print len(another_dict)

for key in some_dict:
   print some_dict[key]
