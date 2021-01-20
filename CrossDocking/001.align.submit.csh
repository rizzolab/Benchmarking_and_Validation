#!/bin/tcsh 
#SBATCH --partition=rn-long-40core
#SBATCH --time=120:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --job-name=CD_Align
#SBATCH --output=CrossDock_Align

tcsh
source 000.source.env.csh
tcsh  zzz.crossdock_scripts/001.align.csh
