
rm Outcome.txt


for sys in `  cat ${system_file} `
  do
  
  #echo $sys
  cd ${sys}/
  
  
  RMSD1=`head -n 1 RMSDh_grep.txt | tail -n1 `
  
  sort -n RMSDh_grep.txt > RMSDh_grep_sort.txt
  RMSD2=`head -n 1 RMSDh_grep_sort.txt`
  
  if (( $(echo "$RMSD1 < 2.00" | bc -l) )); then
  echo -n "Success " >> ../Outcome.txt
  echo ${sys} >> ../Outcome.txt
  
  elif (( $(echo "$RMSD2 < 2.00" | bc -l) )); then
  echo -n "Score Fail " >> ../Outcome.txt
  echo ${sys} >> ../Outcome.txt
  
  else 
  echo -n "Sample Fail " >> ../Outcome.txt
  echo ${sys} >> ../Outcome.txt
  fi
  
  cd ../
  
done

#How many systems were in testset
len=`wc -l Outcome.txt | awk '{print $1}'`

#Count of success, score fail and sample fail
succ=`grep "Succ" Outcome.txt |wc -l`
sco=`grep "Sco" Outcome.txt |wc -l`
sam=`grep "Sam" Outcome.txt |wc -l`

#Percent of success, score fail and sample fail
succ_r=`echo " $succ * 100/ $len " | bc -l`
sco_r=`echo " $sco * 100/ $len " | bc -l`
sam_r=`echo " $sam * 100/ $len " | bc -l`

echo "Success " $succ_r
echo "Scoring Failure " $sco_r
echo "Sampling Failure " $sam_r


