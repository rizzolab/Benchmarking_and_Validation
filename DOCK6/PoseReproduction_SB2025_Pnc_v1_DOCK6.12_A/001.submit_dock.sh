#!/bin/sh 
#SBATCH --partition=rn-long-40core
#SBATCH --time=10:00:00
#SBATCH --nodes=9
#SBATCH --ntasks=40
#SBATCH --job-name=PoseReproduction2
#SBATCH --output=PoseReproduction2.out

# Set the appropriate path for the two following variables
module load gcc-stack

# Path to prepared testset files
testset="/gpfs/projects/rizzo/zzz.testsets/SB2025_Pnc_v2/zzz.distribution"

# List of PDB Codes with prepared files
system_file="/gpfs/projects/rizzo/zzz.testsets/SB2025_Pnc_v2/zzz.lists/clean.systems.all"

#Path to dock executable upper most folder (dont include bin)
dock_dir=/gpfs/projects/rizzo/ccorbo/DOCK_Builds/dock6.12

#Experiment Name 
#If running Pose Reproduction under multiple conditions give differing names for each experiment here
# to keep track of separate experiments
conditions="Default"


#If wanting to change seed, be aware "0" and "1" lead to identical behavior
seed="2"

#srun uses all of the cores available to run the docking in parallel
for system in `cat ${system_file}`; do
   srun --mem=1000 --exclusive -N1 -n1 FLX.sh  ${system} ${testset} $seed $conditions $dock_dir &
done

wait

#Alternative Can be run in serial
#for system in `cat ${system_file}`; do
#   bash FLX.sh  ${system} ${testset} $seed $conditions $dock_dir
#done
