#!/bin/sh 
#SBATCH --partition=
#SBATCH --time=
#SBATCH --nodes=
#SBATCH --ntasks=
#SBATCH --job-name=CD_Run
#SBATCH --output=CD_Run

# This script runs the cartesian minimization and docking set up in the last step. Make sure to specify the set being used in line below.

#Where Dock Executable is located (uppermost folder)
dock_dir=""

list_of_fam=zzz.family_lists/zzz.Families.txt
for ref_fam in `cat ${list_of_fam}`; do
  echo -n "Running Family: "
  echo ${ref_fam}
  
  list_of_sys="$LIST_DIR/${ref_fam}.txt"
  for comp_system in `cat ${list_of_sys}`; do
  
   srun --mem=1000 --exclusive -N1 -n1 -W 0 zzz.crossdock_scripts/003.run.crossdock.sh $ref_fam $comp_system $list_of_sys $dock_dir &
  
  done
  
  wait
  
done

