#!/bin/sh 
#SBATCH --partition=
#SBATCH --time=
#SBATCH --nodes=
#SBATCH --ntasks-per-node=
#SBATCH --job-name=DatabaseEnrichment
#SBATCH --output=DatabaseEnrichment.out

# This script will dock actives and decoys from the downloaded set of actives and decoys from DUDE
# Written by: C Corbo
# Affiliation: Rizzo Lab, Stony Brook University
# Last Edit by: C Corbo

#Set the variables below
#Upper directory where all docking files are located
testset="YOURPATH/DUDE_11_DOCK6"

#List of PDB which are located as subdirectory within testset directory
system_file=DUDE.systems.all

# Path to Dock Executable (Uppermost directory - dont include bin)
dock=YOURPATH

#Path to MPI Library if running mpi - Else set to "No"
mpi=No

# Number of cores being run if mpi (nodes * ntasks-per-node)
processes=

for system in `cat ${system_file}`; do
 ./zzz.scripts/FLX_actives.sh ${system} ${testset} ${dock} ${mpi} ${processes}
 ./zzz.scripts/FLX_decoys.sh ${system} ${testset} ${dock} ${mpi} ${processes}

 cat ./${system}/Active_score.txt > ./${system}/All_score.txt
 cat ./${system}/Decoy_score.txt >> ./${system}/All_score.txt
 sort -n ./${system}/All_score.txt > ./${system}/All_score_sort.txt
 echo ${system} " has finished processing" >> DUDE_Docked_Log.txt
done

