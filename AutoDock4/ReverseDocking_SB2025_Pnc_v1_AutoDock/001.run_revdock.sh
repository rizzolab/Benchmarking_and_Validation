#!/bin/sh
#SBATCH --partition=
#SBATCH --time=62:00:00
#SBATCH --nodes=
#SBATCH --ntasks=
#SBATCH --job-name=AD4_RD
#SBATCH --output=AD4_RD.out

module load mgltools/1.5.6
module load autodock/4.2.6

mkdir -p $revdock_dir_ad4
cd $revdock_dir_ad4
for lig_sys in `cat $system_file`; do
 mkdir -p $lig_sys
 cd $lig_sys
 for rec_sys in `cat ${system_file}`; do
    srun --exclusive --mem=0 -N1 -n1  bash ${work_dir_ad4_rd}/LGA_RD.sh ${lig_sys} $rec_sys  $seed_ad4_rd &
 done
 
 wait
 cd ..
done
 
