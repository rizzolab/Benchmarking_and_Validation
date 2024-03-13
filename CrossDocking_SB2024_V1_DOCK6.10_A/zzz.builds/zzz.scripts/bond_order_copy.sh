python bond_order_copy.py 2V5Z.cof.moe.mol2 | sort -n > tmp1.txt
python bond_order_copy.py 1SG0.cof.moe.mol2 | sort -n > tmp2.txt
diff tmp1.txt tmp2.txt
