#!/bin/sh 
#SBATCH --partition=
#SBATCH --time=40:00:00
#SBATCH --nodes=3
#SBATCH --ntasks=40
#SBATCH --job-name=
#SBATCH --output=

# Set the appropriate path for the two following variables

# List of PDB Codes
system_file=FARMA.systems.all
# Path to prepared testset files
testset=
#DOCK6 directory
dock_dir="YOURPATH"

seed="0"

#srun uses all of the cores available to run the docking in parallel
for lig_system in `cat ${system_file}`; do
  mkdir -p $lig_system
  for rec_system in `cat ${system_file}`; do
   srun --mem=0 --exclusive -N1 -n1 FLX.sh  ${lig_system} $rec_system ${testset} $seed $dock_dir &
  done
  wait
done


