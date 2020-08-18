#!/bin/sh 
#SBATCH --partition=long-40core
#SBATCH --time=48:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=Dock_testset
#SBATCH --output=testset.out

./FLX.sh clean.systems.all

