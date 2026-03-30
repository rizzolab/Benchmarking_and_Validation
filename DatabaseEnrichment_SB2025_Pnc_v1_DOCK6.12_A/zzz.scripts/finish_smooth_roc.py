#THIS requires a file which is sorted primarily on ascending score and secondary on alphanumerical active / decoy so all isoenergetic actives come first and then decoys

#You should use a dictionary for pairs of active/decoy score and count
import math
#First create lists so you can determine frequency, and then you use the score frequency pairs to create dicts
actives_scores=[]
decoys_scores=[]
overlap=[]
all_scores=[]
with open('All_score_append.txt','r') as filereader:
	for line in filereader:
		line_spl=line.split()
		if line_spl[1]=="Active":
			if len(line_spl)==2:
				actives_scores.append(line_spl[0])
		else:
			if len(line_spl)==2:
				decoys_scores.append(line_spl[0])

act_dict={}
tmp_score=0
freq=1
for score in actives_scores:
	if score == tmp_score:
		freq=freq+1
		act_dict[score]=freq
	else:
		freq=1
		tmp_score=score
		act_dict[score]=freq

dec_dict={}
tmp_score=0
freq=1
for score in decoys_scores:
	if score == tmp_score:
		freq=freq+1
		dec_dict[score]=freq
	else:
		freq=1
		tmp_score=score
		dec_dict[score]=freq


score="10000.0"
act_freq=0
dec_freq=0
try:
   act_freq=act_dict[score]
except:
   pass
dec_freq=dec_dict[score]
if dec_freq > act_freq:
			num=math.floor(dec_freq/(act_freq+1))
			for i in range(act_freq):
				print(str(score) + " Active")
				for j in range(num):
					print(str(score) + " Decoy")
			for j in range(num):
				print(str(score) + " Decoy")

			for mod in range(dec_freq%(act_freq+1)):
				print(str(score) + " Decoy")
else:
			num=math.floor(act_freq/(dec_freq+1))
			for i in range(act_freq):
				for j in range(num):
					print(str(score) + " Active")
				print(str(score) + " Decoy")
			for j in range(num):
				print(str(score) + "Active")

			for mod in range(act_freq%(dec_freq+1)):
				print(str(score) + " Active")

