#!/bin/sh
#SBATCH --partition=
#SBATCH --time=
#SBATCH --nodes=
#SBATCH --ntasks=
#SBATCH --job-name=DUDE_AD_dock
#SBATCH --output=DUDE_AD_dock

#This script docks all actives and decoys
#It may be best to run a single system at time instead of for loop due to long running duration
module load mgltools/1.5.6
module load autodock/4.2.6

#It is likely better to submit one system at a time rather than for loop entire family due to long runtime
#for system in `cat DUDE.systems.all`;do
system=3CCW
dock_dir=docking
work_dir=`pwd`
cd $system

mkdir actives
cd actives


list_active="List_of_actives.txt"

#Dock the active set of molecules
mkdir ${dock_dir}
for active in `cat $list_active`;do
   srun --mem=0 --exclusive -N1 -n1 -W 0  bash ${work_dir}/LGA_DE.sh $active $system active $dock_dir &

done

wait

cd ../

mkdir decoys
cd decoys


#This section breaks decoys into manageable sized lists which dont exceed memory
##################
length=`wc -l List_of_decoys.txt | awk '{print $1}'`
float_len=`echo " $length / 1000 " | bc -l`
int_len=`echo " $float_len  " | bc -l | awk -F'.' '{print $1}'`

rm Master_list.txt

for i in $( seq 0 $int_len );
do


j=`echo " $i * 1000 " |bc -l`
j=$(( j + 1 ))
k=`echo " ($i + 1) * 1000" |bc -l`
if [[ $i -eq $int_len ]];then
k=$length
fi
#echo  $j  " " $k

echo "List_of_decoys_${j}_${k}.txt" >>Master_list.txt

sed -n "$j,${k}p" List_of_decoys.txt > List_of_decoys_${j}_${k}.txt
done

#Now dock the decoys one list at a time
###################
mkdir ${dock_dir}
for list_decoy in `cat Master_list.txt`;do

for decoy in `cat $list_decoy`;do
   echo $decoy >> $work_dir/${system}.decoys.out
   srun --mem=4500 --exclusive -N1 -n1 -W 0  bash ${work_dir}/LGA_DE.sh $decoy $system decoy $dock_dir &
done
wait

done
cd ../../
#done
