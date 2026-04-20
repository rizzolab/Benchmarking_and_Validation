#!/bin/sh 
#SBATCH --partition=
#SBATCH --time=10:00:00
#SBATCH --nodes=
#SBATCH --ntasks=
#SBATCH --job-name=PoseReproduction(SeedNumber)
#SBATCH --output=PoseReproduction(SeedNumber).out

# Load compilers for DOCK
module load gcc-stack

# Global Path to prepared testset files
testset="YOURPATH/SB2025_v1_DOCK6_full"

# List of PDB Codes with prepared files
system_file="clean.systems.all"

#Path to dock executable upper most folder (dont include bin)
dock_dir="YOURPATH/dock6.12"

#Experiment Name 
#If running Pose Reproduction under multiple conditions give differing names for each experiment here
# to keep track of separate experiments
conditions="Default"


#If wanting to change seed, be aware "0" and "1" lead to identical behavior
seed="0"

#srun uses all of the cores available to run the docking in parallel
for system in `cat ${system_file}`; do
   srun --mem=1000 --exclusive -N1 -n1 FLX.sh  ${system} ${testset} $seed $conditions $dock_dir &
done

wait

#Alternative Can be run in serial
#for system in `cat ${system_file}`; do
#   bash FLX.sh  ${system} ${testset} $seed $conditions $dock_dir
#done
