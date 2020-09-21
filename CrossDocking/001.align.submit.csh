#!/bin/tcsh 
#SBATCH --partition=extended-40core
#SBATCH --time=120:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=CD_Align
#SBATCH --output=CrossDock_Align

tcsh  zzz.crossdock_scripts/001.align.csh
