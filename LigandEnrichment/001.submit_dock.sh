#!/bin/sh 
#SBATCH --partition=rn-long
#SBATCH --time=130:00:00
#SBATCH --nodes=4
#SBATCH --ntasks=24
#SBATCH --job-name=LigEnrch
#SBATCH --output=LigEnrch.out

# This script will dock actives and decoys from the downloaded set of actives and decoys from DUDE
# Written by: Christopher Corbo
# Affiliation: Rizzo Lab, Stony Brook University
# Last Edit Date: 10/2021
# Last Edit by: Christopher Corbo

#Set the three variables below
testset="/gpfs/projects/rizzo/ccorbo/Building_Stuff/DOCK6_with_ambpdb/SB_2020_testset"
system_file="List_DUDE_PDB_set2.txt"
processes="96"

for system in `cat ${system_file}`; do
./FLX_actives.sh ${system} ${testset} ${processes}
./FLX_decoys.sh ${system} ${testset} ${processes}

cat ./${system}/Active_score.txt >> ./${system}/All_score.txt
cat ./${system}/Decoy_score.txt >> ./${system}/All_score.txt
sort -n ./${system}/All_score.txt >> ./${system}/All_score_sort.txt
echo ${system} " has finished processing" >> DUDE_Docked_Log.txt
done

