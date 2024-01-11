#!/bin/sh
# This script will run the scripts to prepare all of the files necessary for constructing aligned crossdocking systems 
# Namely (ligand and receptor mol2, spheres files and grid files)
list="${LIST_DIR}/${1}.txt"
for system in `cat $list`; do
  echo ${system}
  bash run.001.lig_clean_am1bcc.sh ${system}
  bash run.002.rec_runleap.sh ${system}
  bash run.003.rec_dms_sph.sh ${system}
  bash run.004.rec_grid_cluster.sh ${system}
done
