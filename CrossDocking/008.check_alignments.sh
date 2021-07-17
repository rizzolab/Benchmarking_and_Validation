#!/bin/sh
#SBATCH --partition=rn-long
#SBATCH --time=168:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --job-name=transfer
#SBATCH --output=transfer.out

# This script will put all relevant aligned files into folders which can then be checked in Chimera on a need be basis

LIST_DIR="zzz.sample_lists"
list_of_fam="${LIST_DIR}/family_more_than7.txt"
for ref_fam in `cat ${list_of_fam}`; do

mkdir ./Transfers/${ref_fam}

list_of_sys1="${LIST_DIR}/${ref_fam}.txt"
for ref_system in `cat ${list_of_sys1}`; do

cp ./zzz.crossdock/${ref_fam}/${ref_system}/*mol2 ./Transfers/${ref_fam}
cp ./zzz.crossdock/${ref_fam}/${ref_system}/*sph ./Transfers/${ref_fam}

done
done
