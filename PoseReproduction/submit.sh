#!/bin/sh 
#SBATCH --partition=rn-long-40core
#SBATCH --time=48:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=Dock_testset
#SBATCH --output=testset.out

system_file="clean.systems.all"
testset="/gpfs/projects/rizzo/SB2012_testset_Built_2020"

for system in `cat ${system_file}`; do
   srun --exclusive -N1 -n1 FLX.sh  ${system} ${testset} &
done

wait

