#!/bin/sh
#SBATCH --partition=
#SBATCH --time=12:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=002_Vina_convert_type
#SBATCH --output=002_Vina_convert_type.out

#This script converts pdbqt to mol2  
module load openbabel/2.4.1 
List_dir="$work_dir/zzz.family_lists"

cd $crossdock_dir

for ref_fam in `  cat $List_dir/zzz.Families.txt`;do
  echo ${ref_fam}
  cd ${ref_fam}
  for ref_sys in `cat $List_dir/${ref_fam}.txt`;do
    cd $ref_sys
    for comp_sys in `cat $List_dir/${ref_fam}.txt`;do
      cd $comp_sys
      #remove hydrogen from reference
      obabel ../../${ref_sys}.lig.gast.pdbqt -O ${ref_sys}.lig.gast.noH.mol2 -d
      #remove hydrogens from docked poses pdbqt
      obabel ${ref_sys}_${comp_sys}.vina$seed.pdbqt -O ${comp_sys}.docking.noH.mol2 -d
      cd ..
    done
    cd ..
  done 
  cd ..
done
