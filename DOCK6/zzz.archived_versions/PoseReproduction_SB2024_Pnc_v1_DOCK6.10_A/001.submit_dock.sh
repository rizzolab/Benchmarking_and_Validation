#!/bin/sh 
#SBATCH --partition=
#SBATCH --time=
#SBATCH --nodes=
#SBATCH --ntasks=
#SBATCH --job-name=PoseReproduction
#SBATCH --output=PoseReproduction.out

# Set the appropriate path for the two following variables

# List of PDB Codes with prepared files
system_file=

# Path to prepared testset files
testset=

#Path to dock executable upper most folder (dont include bin)
dock_dir=

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
