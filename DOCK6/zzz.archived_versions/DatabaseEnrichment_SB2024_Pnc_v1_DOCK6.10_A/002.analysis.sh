module load anaconda/3
#List of PDB which are located as subdirectory within testset directory
system_file=

#Upper directory where all docking files are located
testset=

mkdir plots
for system in `cat ${system_file}`; do
  #This appends undocked molecules to end of list at random enrichment rate
  ./zzz.scripts/finish_roc.sh $system $testset
  #This plots roc curve and calculates basic statistics 
  ./zzz.scripts/make_roc.sh $system $testset
done
