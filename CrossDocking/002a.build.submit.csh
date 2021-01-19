#!/bin/tcsh 
#SBATCH --partition=extended-40core
#SBATCH --time=168:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=CD_Build
#SBATCH --output=CrossDock_Build

list_of_fam="/gpfs/scratch/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.sample_lists/family_more_than7.txt"
for family in `cat ${list_of_fam}`; do

srun --exclusive -N1 -n1 -W 0 tcsh zzz.crossdock_scripts/002.build.csh ${family} &

done

wait


