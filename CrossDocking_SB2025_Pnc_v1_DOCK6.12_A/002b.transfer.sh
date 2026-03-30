#!/bin/sh 
#SBATCH --partition=
#SBATCH --time=
#SBATCH --nodes=
#SBATCH --ntasks=
#SBATCH --job-name=CD_Trans
#SBATCH --output=CD_Trans

cd ${CROSSDOCK_DIR}
family_list="${LIST_DIR}/zzz.Families.txt"
for ref_fam in `cat $family_list`; do
  
  mkdir $ref_fam
  
  ref_list="${LIST_DIR}/${ref_fam}.txt"
  
  for  ref_system  in  `cat $ref_list`; do
  
    mkdir ${ref_fam}/${ref_system}
    if ls -l ${BUILD_DIR}/${ref_system}/004.grid | grep -q ${ref_system}.rec.clean.mol2 ; then
      cp ${BUILD_DIR}/${ref_system}/001.lig-prep/${ref_system}.lig.am1bcc.mol2 ${ref_fam}/${ref_system}
      cp ${BUILD_DIR}/${ref_system}/004.grid/${ref_system}.rec* ${ref_fam}/${ref_system}
    else
      echo ${ref_system} >> Incomplete_Builds.txt
    fi
  
  done
done
