#!/bin/sh 
#SBATCH --partition=rn-long-40core
#SBATCH --time=48:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=Dock_testset
#SBATCH --output=testset.out

# Set the appropriate path for the two following variables

# List of PDB Codes
system_file="clean.systems.all"
# Path to prepared testset files
testset="/gpfs/projects/rizzo/SB2012_testset_Built_2020"

#srun uses all of the cores available to run the docking in parallel
for system in `cat ${system_file}`; do
   srun --exclusive -N1 -n1 FLX.sh  ${system} ${testset} &
done

wait

