#Load a version of python with sklearn and also ensure that matplotlib is installed
#List of PDB which are located as subdirectory within testset directory
system_file=

#Upper directory where all docking files ending in DUDE_11_DOCK6
testset=

mkdir -p plots
for system in `cat ${system_file}`; do
  #This appends undocked molecules to end of list at random enrichment rate
  ./zzz.scripts/finish_roc.sh $system $testset
  #This plots roc curve and calculates basic statistics 
  ./zzz.scripts/make_roc.sh $system $testset
done
