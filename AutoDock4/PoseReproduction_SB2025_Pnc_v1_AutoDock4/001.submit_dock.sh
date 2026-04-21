#!/bin/sh
#SBATCH --partition=
#SBATCH --time=20:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=AD4_run01_(SeedNumber)
#SBATCH --output=AD4_run01_(SeedNumber).out

#Both mgltools and AutoDock needed to run script
#If these are not available as modules, substitute in the global paths in script being called
module load mgltools/1.5.6
module load autodock/4.2.6

mkdir zzz.output

for system in `cat ${system_file}`; do
   srun --exclusive --mem=0 -N1 -n1  bash ./LGA.sh $testset ${system}  ${conditions} $seed &> ./zzz.output/${system}.out    &
done

wait

#Alternatively can run in serial
#for system in `cat ${system_file}`; do
#    bash ./LGA.sh $testset ${system}  ${conditions} $seed > ./zzz.output/${system}.out    
#done



