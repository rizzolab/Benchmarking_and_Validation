#!/bin/tcsh 
#SBATCH --partition=rn-long-40core
#SBATCH --time=168:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=CD_Build
#SBATCH --output=CrossDock_Build

# This script calls will construct all of the systems (ligand, receptor, spheres, grid) that were aligned on the previous step
tcsh
source 000.source.env.csh

cd ${BUILD_DIR}

source run.000.set_env_vars.csh

set list_of_fam = "${LIST_DIR}/family_more_than7.txt"

foreach family (`cat ${list_of_fam}`)

srun --exclusive -N1 -n1 tcsh ../zzz.crossdock_scripts/002.build.csh ${family} &

end

wait
