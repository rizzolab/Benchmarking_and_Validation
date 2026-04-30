#This script calculates how many actives and deocys were undocked and appends them to the end of list 

module load anaconda/3-old

system_file="DUDE.systems.all"
for sys in `cat ${system_file}`; do
rm $sys/All_score_append.txt

act_count=`grep "${sys}" Total_LE_Actives.txt| awk '{print $1}'`

dec_count=`grep "${sys}" Total_LE_Decoys.txt| awk '{print $1}'`

act_dock=`wc -l $sys/actives/docking/active_score_list.txt  | awk '{print $1}'`

dec_dock=`wc -l $sys/decoys/docking/decoy_score_list.txt  | awk '{print $1}'`

act_undock=` echo " $act_count - $act_dock " | bc -l`

dec_undock=` echo " $dec_count - $dec_dock " | bc -l`

for i in $( seq 0 $act_undock );do
echo "active 10000.0" >> $sys/All_score_append.txt
done

for i in $( seq 0 $dec_undock );do
echo "decoy 10000.0" >> $sys/All_score_append.txt
done

cd $sys
python ../zzz.scripts/finish_smooth_roc.py > tmp.txt
cat All_score_sort.txt tmp.txt > All_score_complt_sort.txt
cd ..
done
