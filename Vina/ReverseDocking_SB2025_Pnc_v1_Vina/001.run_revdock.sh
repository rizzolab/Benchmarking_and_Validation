#!/bin/sh
#SBATCH --partition=
#SBATCH --time=62:00:00
#SBATCH --nodes=5
#SBATCH --ntasks=40
#SBATCH --job-name=vina_RD
#SBATCH --output=vina_RD.out

module load autodock-vina/1.1.2

mkdir $dock_dir
cd $dock_dir
for lig_sys in `cat $system_file`; do
 mkdir $lig_sys
 cd $lig_sys
 for rec_sys in `cat ${system_file}`; do
    srun --exclusive --mem=0 -N1 -n1  bash ${work_dir}/vina_RD.sh ${lig_sys} $rec_sys  $seed &
 done
 
 wait
 cd ..
done
 
