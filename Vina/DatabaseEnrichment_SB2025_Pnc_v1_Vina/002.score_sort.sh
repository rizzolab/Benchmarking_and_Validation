#This script combines actives and decoys list and sorts them 
system_file="DUDE.systems.all"
for system in `cat ${system_file}`; do
echo $system
cd $system
   rm All_score.txt All_score_sort.txt

   cat actives/docking/active_score_list.txt >> All_score.txt
   cat decoys/docking/decoy_score_list.txt >> All_score.txt
   sed -i 's/+//g' All_score.txt
   sort -n -k2 All_score.txt > All_score_sort.txt
cd ..

done
