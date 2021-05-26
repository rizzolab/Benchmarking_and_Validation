#!/bin/sh 
#SBATCH --partition=rn-long
#SBATCH --time=48:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --job-name=LigEnrch
#SBATCH --output=LigEnrch.out


testset="/gpfs/projects/rizzo/ccorbo/DOCK6_with_ambpdb/SB_2020_testset"
system_file="List_DUDE_PDB.txt"

for system in `cat ${system_file}`; do
./FLX_actives.sh ${system} ${testset}
./FLX_decoys.sh ${system} ${testset}

cat ./${system}/Active_score.txt >> ./${system}/All_score.txt
cat ./${system}/Decoy_score.txt >> ./${system}/All_score.txt
sort -n ./${system}/All_score.txt >> ./${system}/All_score_sort.txt

done

