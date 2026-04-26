#!/bin/sh
#SBATCH --partition=
#SBATCH --time=168:00:00
#SBATCH --nodes=2
#SBATCH --ntasks=40
#SBATCH --job-name=001_AD4_CD
#SBATCH --output=001_AD4_CD.out

#This script copies testset architecture from downloaded files and runs crossdocking

#Both mgltools and AutoDock needed to run script
#If these are not available as modules, substitute in the global paths in script being called
module load mgltools/1.5.6
module load autodock/4.2.6

cd ${crossdock_dir}

#Copy over prepared/downloaded testset files
cp -r $testset/* ./

list_of_fam="${work_dir}/zzz.family_lists/zzz.Families.txt"
#Run in parallel
for ref_fam in `cat ${list_of_fam}`; do
  cd ${ref_fam}
  echo  "Running Family: " ${ref_fam}
  list_of_sys="${work_dir}/zzz.family_lists/${ref_fam}.txt"
  for comp_system in `cat ${list_of_sys}`; do
     cd ${crossdock_dir}/${ref_fam}/${comp_system}
     srun --mem=0 --exclusive -N1 -n1  ${work_dir}/LGA_CD.sh ${ref_fam}  ${comp_system}  &

  done
  wait

done

#Run in serial
#for ref_fam in `cat ${list_of_fam}`; do
#  cd ${ref_fam}
#  echo  "Running Family: " ${ref_fam}
#  list_of_sys="${work_dir}/zzz.family_lists/${ref_fam}.txt"
#  for comp_system in `cat ${list_of_sys}`; do
#     cd ${WORK_DIR}/${ref_fam}/${comp_system}
#     bash  ${work_dir}/LGA_CD.sh ${ref_fam}  ${comp_system} 
#  done
#done
