#!/bin/sh 
#SBATCH --partition=long-40core
#SBATCH --time=40:00:00
#SBATCH --nodes=3
#SBATCH --ntasks=40
#SBATCH --job-name=
#SBATCH --output=

# Set the appropriate path for the two following variables

# List of PDB Codes
system_file=
# Path to prepared testset files
testset=

seed="0"

#srun uses all of the cores available to run the docking in parallel
for lig_system in `cat ${system_file}`; do
  mkdir $lig_system
  for rec_system in `cat ${system_file}`; do
   srun --mem=1000 --exclusive -N1 -n1 FLX.sh  ${lig_system} $rec_system ${testset} $seed &
  done
  wait
done


