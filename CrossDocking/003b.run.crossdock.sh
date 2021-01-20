#!/bin/sh
#SBATCH --partition=rn-long
#SBATCH --time=168:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --job-name=Set_N
#SBATCH --output=Set_N.out

list_of_fam="/gpfs/scratch/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.sample_lists/set_N.txt"
for ref_fam in `cat ${list_of_fam}`; do

list_of_sys="/gpfs/scratch/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.sample_lists/${ref_fam}.txt"
for comp_system in `cat ${list_of_sys}`; do

srun --exclusive -N1 -n1 -W 0 zzz.crossdock_scripts/003.run.crossdock.sh ${ref_fam}  ${comp_system} &

done

wait

done

