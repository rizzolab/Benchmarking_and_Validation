#!/bin/sh
CROSSDOCK_DIR="/gpfs/scratch/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.crossdock"
cd ${CROSSDOCK_DIR}

ref_fam="${1}"
cd ${ref_fam}
echo -n "Running Family: "
echo ${ref_fam}

ref_system="${2}"
cd ${ref_system}

list_of_sys="/gpfs/scratch/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.sample_lists/${ref_fam}.txt"
for comp_system in `cat ${list_of_sys}`; do
cd ${comp_system}

dock6 -i min.in -o min.out
dock6 -i flx.in -o flx.out

echo -n "Running Pair: "
echo -n ${ref_system}
echo -n " - "
echo ${comp_system}

cd ..
done
