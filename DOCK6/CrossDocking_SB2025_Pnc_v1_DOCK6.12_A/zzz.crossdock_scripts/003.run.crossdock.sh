#!/bin/sh
# This script will coordinate submitting docking jobs in appropriate directories
cd ${CROSSDOCK_DIR}

ref_fam="${1}"
cd ${ref_fam}

ref_system="${2}"
cd ${ref_system}

list_of_sys="${3}"

for comp_system in `cat ${list_of_sys}`; do
cd ${comp_system}

${DOCK_DIR}/bin/dock6 -i min.in -o min.out
${DOCK_DIR}/bin/dock6 -i flx.in -o flx.out

echo -n "Running Pair: "
echo -n ${ref_system}
echo -n " - "
echo ${comp_system}

cd ..
done
