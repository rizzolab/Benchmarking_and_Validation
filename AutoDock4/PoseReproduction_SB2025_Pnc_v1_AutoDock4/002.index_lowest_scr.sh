# This script determines the index of best scoring pose in each LGA run


for sys in `  cat $system_file_pr `
  do
  echo ${sys}
  
  cd ${sys}
  
  #Make sure the 8th line below is capturing run # associated with lowest score 
  grep -A8 "LOWEST ENERGY DOCKED CONFORMATION" ${sys}.$conditions_ad4_pr.docking.dlg  | tail -n1 | awk '{print $4}' > index_lowest_score_$conditions_ad4_pr.txt
  
  cd ../

done
