#!/bin/sh 
#SBATCH --partition=rn-long
#SBATCH --time=168:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH --job-name=Cdock9
#SBATCH --output=CrossDock9.out

./zzz.crossdock_scripts/003.run.crossdock.sh ***INPUT NUMBER HERE***

