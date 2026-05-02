#!/bin/sh
#SBATCH --partition=
#SBATCH --time=62:00:00
#SBATCH --nodes=5
#SBATCH --ntasks=40
#SBATCH --job-name=AD4_RD
#SBATCH --output=AD4_RD.out

module load mgltools/1.5.6
module load autodock/4.2.6

mkdir $dock_dir
cd $dock_dir
for lig_sys in `cat $work_dir/FARMA.systems.all`; do
 mkdir $lig_sys
 cd $lig_sys
 for rec_sys in `cat ${system_file}`; do
    srun --exclusive --mem=0 -N1 -n1  bash ${work_dir}/LGA_RD.sh ${lig_sys} $rec_sys  $seed &
 done
 
 wait
 cd ..
done
 
