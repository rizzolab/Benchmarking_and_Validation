#!/bin/sh
#SBATCH --partition=
#SBATCH --time=62:00:00
#SBATCH --nodes=
#SBATCH --ntasks=
#SBATCH --job-name=vina_RD
#SBATCH --output=vina_RD.out

module load autodock-vina/1.1.2

mkdir -p $revdock_dir_vina
cd $revdock_dir_vina
for lig_sys in `cat $system_file`; do
 mkdir -p $lig_sys
 cd $lig_sys
 for rec_sys in `cat ${system_file}`; do
    srun --exclusive --mem=0 -N1 -n1  bash ${work_dir_vina_rd}/vina_RD.sh ${lig_sys} $rec_sys  $seed_vina_rd &
 done
 
 wait
 cd ..
done
 
