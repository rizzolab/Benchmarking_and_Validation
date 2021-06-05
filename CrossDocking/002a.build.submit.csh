#!/bin/tcsh 
#SBATCH --partition=rn-long-40core
#SBATCH --time=168:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=CD_Build
#SBATCH --output=CrossDock_Build

# This script calls will construct all of the systems that were aligned on the previous step
tcsh
source 000.source.env.csh

set list_of_fam = "/gpfs/scratch/ccorbo/Benchmarking_and_Validation/CrossDocking/zzz.sample_lists/family_more_than7.txt"

foreach family (`cat ${list_of_fam}`)

tcsh zzz.crossdock_scripts/002.build.csh ${family}

#srun commented out because may cause corrupted environment - Need to investigate further
#srun --exclusive -N1 -n1 -W 0 tcsh zzz.crossdock_scripts/002.build.csh ${family} &
#wait

end



