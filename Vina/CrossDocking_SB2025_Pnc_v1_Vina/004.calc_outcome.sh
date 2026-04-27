cd $crossdock_dir

List_dir="$work_dir/zzz.family_lists"

for ref_fam in `  cat $List_dir/zzz.Families.txt`;do
echo ${ref_fam}

cd ${ref_fam}

rm *outcomeh.txt

for ref_sys in `cat $dock6_rearrange_dir/${ref_fam}_Rearrangeh.txt`;do

cd $ref_sys

for comp_sys in `cat $dock6_rearrange_dir/${ref_fam}_Rearrangeh.txt`;do

cd $comp_sys

echo $ref_sys " " $comp_sys
##########
#CHECK COMPATIBLITY IN MINIMIZED !!!!!!!!!!
if  grep -q "RMSDh" $dock6_crossdock_dir/zzz.crossdock/$ref_fam/$comp_sys/$ref_sys/${ref_sys}_${comp_sys}.min_scored.mol2 ; then
   min_h=`grep "RMSDh" $dock6_crossdock_dir/zzz.crossdock/$ref_fam/$comp_sys/$ref_sys/${ref_sys}_${comp_sys}.min_scored.mol2| awk '{print $3}'` 
   min_score=`grep "Grid_Score" $dock6_crossdock_dir/zzz.crossdock/$ref_fam/$comp_sys/$ref_sys/${ref_sys}_${comp_sys}.min_scored.mol2| awk '{print $3}'`
else #If file doesnt exist min failed
   min_h=1000
   min_score=1000
fi
##########

RMSD1=`head -n 1 RMSDh_grep.txt | tail -n1 `

rm RMSDh_grep_sort.txt

sort -n RMSDh_grep.txt >> RMSDh_grep_sort.txt
RMSD2=`head -n 1 RMSDh_grep_sort.txt`
#echo $min_h " " $min_score
if (( $(echo "$min_h > 2.00 || $min_score >  0.0" | bc -l) )); then
echo 0 >> ../../${ref_sys}.outcomeh.txt

elif (( $(echo "$RMSD1 < 2.00" | bc -l) )); then
echo 3 >> ../../${ref_sys}.outcomeh.txt

elif (( $(echo "$RMSD2 < 2.00" | bc -l) )); then
echo 2 >> ../../${ref_sys}.outcomeh.txt

else
echo 1 >> ../../${ref_sys}.outcomeh.txt
fi

cd ..
done

cd ..
done

cd ..
done

#######################

