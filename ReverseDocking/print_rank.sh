for lig_sys in `cat FARMA.systems.all`;do
cd $lig_sys
rank=`for sys in `cat ../FARMA.systems.all `;do val=`grep Grid_Score ${lig_sys}_${sys}_0_scored.mol2| head -n1`; echo $sys " " $val;done| sort -n -k4 | grep -n $lig_sys| awk -F ':' '{print $1}'`
echo $lig_sys " " $rank
done
