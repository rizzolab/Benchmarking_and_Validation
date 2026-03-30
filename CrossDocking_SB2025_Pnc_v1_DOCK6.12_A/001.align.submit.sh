#!/bin/sh 
#SBATCH --partition=
#SBATCH --time=
#SBATCH --nodes=
#SBATCH --ntasks=
#SBATCH --job-name=CD_Align
#SBATCH --output=CD_Align

# This script calls 001.align.sh which aligns crossdocking families to a reference in the family
# The reference will be the first pdb in each respective family list in zzz.family_lists

# Path to prepared testset files which do not need to be aligned (Typically same directory for Pose Reproduction)
testset=""

bash  zzz.crossdock_scripts/001.align.sh $testset 
