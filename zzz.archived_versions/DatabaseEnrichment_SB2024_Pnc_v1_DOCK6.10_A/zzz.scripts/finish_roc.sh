#This script will append undocked molecules to end of list at random enrichment rate
sys=$1
testset=$2
rm $sys/All_score_append.txt

act_count=`grep MOLE $testset/$sys/actives_final.mol2  |wc -l`

dec_count=`grep MOLE $testset/$sys/decoys_final.mol2  |wc -l`

act_dock=` grep "MOLE"  $sys/${sys}_actives.FLX_scored.mol2 |wc -l`

dec_dock=` grep "MOLE"  $sys/${sys}_decoys.FLX_scored.mol2 |wc -l`

act_undock=` echo " $act_count - $act_dock " | bc -l`

dec_undock=` echo " $dec_count - $dec_dock " | bc -l`

for i in $( seq 0 $act_undock );do
echo "10000.0 Active" >> $sys/All_score_append.txt
done

for i in $( seq 0 $dec_undock );do
echo "10000.0 Decoy" >> $sys/All_score_append.txt
done

cd $sys
python ../zzz.scripts/finish_smooth_roc.py > tmp.txt
cat All_score_sort.txt tmp.txt > All_score_complt_sort.txt
cd ..
