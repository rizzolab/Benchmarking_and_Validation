# This script will read a rank sorted list of actives and decoys and interleave them because Vina produces
# many isoenergetic results as it only prints scores to tenths place 
# Written by: C Corbo
# Affiliation: Rizzo Lab, Stony Brook University
# Last Edit Date: 10/2021
# Last Edit by: C Corbo

system_file="DUDE.systems.all"
for system in `cat ${system_file}`; do
   cd ${system}

   cp  All_score_sort.txt All_score_sort_original.txt 
   python ../zzz.scripts/smooth_roc.py > tmp.txt
   mv tmp.txt All_score_sort.txt

   cd ..
done

