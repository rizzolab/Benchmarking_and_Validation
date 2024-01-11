#!/bin/sh 
#SBATCH --partition=
#SBATCH --time=
#SBATCH --nodes=
#SBATCH --ntasks=
#SBATCH --job-name=CD_Build
#SBATCH --output=CD_Build

# This script calls will construct sphere and grid dock files for all of the systems that were aligned on the previous step
#source 000.source.env.sh

### DOCK home directory
export DOCKHOMEWORK="/gpfs/projects/rizzo/zzz.programs/dock6.9_mpiv2018.0.3"

### AMBER home directory
export AMBERHOMEWORK="/gpfs/software/amber/16/gcc"

## DMS home directory
export DMSHOMEWORK="/gpfs/projects/rizzo/zzz.programs/dms"

### Root directory (the directory where all run.xxx.csh scripts are located)
export VS_ROOTDIR="$WORK_DIR/zzz.builds"

list_of_fam=${LIST_DIR}/zzz.Families.txt

cd ${BUILD_DIR}

for family in `cat ${list_of_fam}`;do 
  srun  --exclusive -N1 -n1 bash ../zzz.crossdock_scripts/002.build.sh ${family} &
done

wait


