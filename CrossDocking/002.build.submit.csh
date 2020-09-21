#!/bin/tcsh 
#SBATCH --partition=extended-40core
#SBATCH --time=168:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=CD_Build
#SBATCH --output=CrossDock_Build

tcsh  zzz.crossdock_scripts/002a.build.csh
tcsh  zzz.crossdock_scripts/002b.transfer.csh
