#!/bin/sh
#SBATCH --partition=rn-long-40core
#SBATCH --time=20:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=Vina_run01_(SeedNumber)
#SBATCH --output=Vina_run01_(SeedNumber).out

#AutoDockVina needed to run script
#If  not available as module, substitute in the global paths in script being called
module load autodock-vina/1.1.2

mkdir zzz.output

for system in `cat ${system_file}`; do
   srun --exclusive --mem=0 -N1 -n1  bash ./vina.sh  ${system}   &> ./zzz.output/${system}.out    &
done

wait

#Alternatively can run in serial
#for system in `cat ${system_file}`; do
#    bash ./vina.sh  ${system}   > ./zzz.output/${system}.out    
#done



