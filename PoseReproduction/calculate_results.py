#!/usr/bin/env python
from sys import argv
import  os
import datetime
from operator import itemgetter
import csv

#This script is an analysis script that follows the template made by /gpfs/projects/rizzo/zzz.SB2012_testset/Dock6_testset/zzz.distribution/FLX.sh
#This version of the script was developed by Scott Laverty and John Bickel in the rizzo lab
#The purpose of this script is the create a .csv file and dat files to study the success rate of these systems
#Script input should likes this
#python bickel_laverty_calculate_dock6_results.py FLX clean.systems.all DOCK6_results
#An explanaition for all these input arguements is located in the except clause of the main() script

#These are the known family of these systems
#name_dict={
#"ACETYLCHOLINESTERASE" : ["1ACJ","1E66","1EVE","1GPN","1H22","1H23","1J07","1Q84","1VOT","1W4L","1W6R","1W76","1ZGC","2ACK","1ODC","1UT6","2CKM","2CMF","2HA2"],
#"ADENYLATE_CYCLASE" : ["1WC0","1WC1","1WC5","2BW7"],
#"ALPHA_AMYLASE" : ["1U2Y","1U33","1XD0","1XD1"],
#"ALPHA-LYTIC_PROTEASE" : ["5LPR","6LPR","7LPR","9LPR"],
#"ALPHA-MANNOSIDASE_II" : ["1HWW","1PS3","1R33","1TQT"],
#"ASPARTATE_TRANSCARBAMOYLASE" : ["1ACM","1D09","1Q95","8ATC"],
#"BETA-GLUCOSIDASE" : ["1OIF","1OIM","1UZ1","1W3J"],
#"BETA-TRYPSIN" : ["1BJU","1BJV","1GHZ","1GI4","1GI6","1GJ6","1O2H","1O2I","1O2J","1O2K","1O2N","1O2O","1O2Q","1O2S","1O2U","1O2V","1O2Z","1O30","1O31","1O36","1O37","1O39","1O3B","1O3D","1O3E","1O3F","1O3G","1O3H","1O3I"],
#"BETA-XYLANASE" : ["1FH7","1FH8","1FH9","1FHD","1J01"],
#"CARBONIC_ANHYDRASE" : ["1BN1","1BN3","1BN4","1BNN","1BNT","1BNU","1BNV","1BNW","1AZM","1BCD","1CIL","1CIM","1CIN","1CNW","1CNX","1CNY","1G48","1G52","1G53","1I8Z","1I90","1I91","1IF7","1IF8","1OKL","1OKN","1OQ5","1YDB","2H4N"],
#"carbonic_waters" : ["1BN1","1BN3","1BN4","1BNN","1BNT","1BNU","1BNV","1BNW","1AZM","1BCD","1CIL","1CIM","1CIN","1CNW","1CNX","1CNY","1G48","1G52","1G53","1I8Z","1I90","1I91","1IF7","1IF8","1OKL","1OKN","1OQ5","1YDB","2H4N"],
#"CARBOXYPEPTIDASE_A" : ["1CBX","1CPS","1F57","1HDQ","3CPA","6CPA","7CPA","8CPA"],
#"CEL7" : ["1DY4","1H46","1Z3T","1Z3V"],
#"COX" : ["1EQG","1EQH","1HT5","1HT8","1Q4G","1S2A","4COX"],
#"EGFR" : ["1M17","1XKK"],
#"ELASTASE" : ["1ELB","1ELC","7EST"],
#"ESTROGEN_RECEPTOR" : ["1A52","1ERE","1GWQ","1GWR","1L2J","1QKT","1QKU","1R5K","1U3Q","1U3S","1U9E","1UOM","1X76","1X78","1X7B","1X7E","1X7J","1X7R","1XQC","1YIN","1YY4","1YYE","1ZAF","2EWP","2GIU","2I0G","2I0J","2JJ3","2NV7","2P7A","2P7G","2P7Z","2PJL","2QA6","2QE4","2QGT","2QGW","2QH6","2QXM","2R6W","2R6Y","2Z4B","2ZAS","3DT3","3ERD"],
#"FACTOR_XA" : ["1Z6E","2J95","1LPG","1LPK","1LPZ","1XKA","1XKB","1G2L","2BOK","2FZZ","2G00","2J94","2P3T","2P3U","2RA0","2UWL","2UWO","2P16","1MQ5","1MQ6","2J2U","1V3X","2PR3","1EZQ","1F0R","1F0S","1FJS","1KSN","1NFU","1NFW","1NFX","1NFY","2CJI","2J34","2J38","2Q1J","1KYE","2BQ7","2P93","2P94","2P95"],
#"GAR_TRANSFERASE" : ["1JKX","1NJS","1RBM"],
#"GLUCOAMYLASE" : ["1AGM","1GAH","1GAI","1LF9"],
#"HEAT_LABILE_ENTEROTOXIN" : ["1EEF","1EFI","1FD7"],
#"HEVAMINE" : ["1LLO","1HVQ","1KQY","1KQZ","1KR0","1KR1"],
#"HIV_cyclic_urea" : ["1HVR","1AJV","1DMP","1G35","1HVH","1HWR","1MER","1MES","1MET","1PRO","1QBS"],
#"HIV_non_cyclic_area" : ["1A8K","1CPI","1HPV","1HSH","1A9M","1AAQ","1HIV","1HPS","4PHV","5HVP","8HVP","9HVP","1IDA","1IDB","1IVP","1IVQ","2HPE","2HPF","2FDD","2FDE","1A30","1A8G","1BDQ","1BDR","1EBK","1HXB","1MTR","1ODW","7UPJ","1JLD","3UPJ","4UPJ","1AID","2F80","2F81","2IDW","2IEN","2IEO","1FEJ","1FFF","1FFI","1FG6","1FG8","1FGC","1FQX","1SDT","1T3R","1D4Y","2HS2"],
#"HIVPR.flap.water" : ["1A8K","1CPI","1HPV","1HSH","1A9M","1AAQ","1HIV","1HPS","4PHV","5HVP","8HVP","9HVP","1IDA","1IDB","1IVP","1IVQ","2HPE","2HPF","2FDD","2FDE","1A30","1A8G","1BDQ","1BDR","1EBK","1HXB","1MTR","1ODW","7UPJ","1JLD","3UPJ","4UPJ","1AID","2F80","2F81","2IDW","2IEN","2IEO","1FEJ","1FFF","1FFI","1FG6","1FG8","1FGC","1FQX","1SDT","1T3R","1D4Y","2HS2"],
#"HIV_PROTEASE" : ["1A8K","1CPI","1HPV","1HSH","1A9M","1AAQ","1HIV","1HPS","1HVR","4PHV","5HVP","8HVP","9HVP","1IDA","1IDB","1IVP","1IVQ","2HPE","2HPF","2FDD","2FDE","1A30","1A8G","1AJV","1BDQ","1BDR","1DMP","1EBK","1G35","1HVH","1HWR","1HXB","1MER","1MES","1MET","1MTR","1ODW","1PRO","1QBS","7UPJ","1JLD","3UPJ","4UPJ","1AID","2F80","2F81","2IDW","2IEN","2IEO","1FEJ","1FFF","1FFI","1FG6","1FG8","1FGC","1FQX","1SDT","1T3R","1D4Y","2HS2"],
#"HMG_COA_REDUCTASE" : ["1HW8","1HW9","1HWI","1HWJ","1HWK","1HWL","1T02","2Q1L","2Q6B","2Q6C","2R4F","3BGL","3CCT","3CCW","3CCZ","3CD0","3CD5","3CD7","3CDA","3CDB"],
#"IGF-1R" : ["2OJ9","2ZM3","3D94","3F5P","3I81","3LVP","3LW0","3NW5","3NW6","3NW7"],
#"IMMUNOGLOBULIN" : ["1DBB","1DBJ","1EHL","2CGR","2PCP"],
#"ISOCITRATE_DEHYDROGENASE" : ["5ICD","8ICD","9ICD"],
#"L-ARABINOSE-BINDING_PROTEIN" : ["1ABE","1ABF","1BAP","8ABP"],
#"LYSOZYME" : ["1HEW","1LZY","1LZB","1LZC","1LZE","1LZG","1BB5","1BB6","1BB7","1LMC","1LMO","1LMP","1LMQ","1LJN"],
#"MANNOSE_LECTIN" : ["1RDI","1RDJ","1RDK","1RDL","1RDN"],
#"MMP" : ["1RMZ","1ROS","1Y93","2OXW","3EHX","3EHY","3F15","3F16","3F17","3F18","3F19","3F1A","1USN","2USN"],
#"MTA_SAH_NUCLEOSIDASE" : ["1JYS","1NC1","1NC3"],
#"MYROSINASE" : ["1E6Q","1E6S","1E72"],
#"NEURAMINIDASE" : ["1A4G","1A4Q","1B9S","1B9T","1BJI","1F8B","1F8C","1F8D","1F8E","1INF","1INW","1IVB","1IVF","1L7F","1L7G","1L7H","1MWE","1NNB","1NNC","1NSD","1VCJ","1XOE","1XOG","2BAT","2HT7","2HT8","2HTQ","2HTR","2HTU","2HTW","2HU0","2HU4","2QWC","2QWD","2QWE","2QWF","2QWG","2QWH","2QWI","2QWJ","2QWK","3CKZ","3CL0"],
#"OMP_DECARBOXYLASE" : ["1EIX","1LOQ","1DBT","1DQX","1DVJ","1LOR","1LOS"],
#"ORNITHINE_TRANSCARBAMOYLASE" : ["1DUV","1OTH"],
#"PHOSPHODIESTERASE" : ["1XON","1XOQ","1XOR","1OYN"],
#"PHOSPHOLIPASE_A2" : ["1HN4","1KPM","1KVO","1OYF","1SV9","1KQU","1SV3","2AZY","2AZZ","2B00","2B01","2OYF","2QVD","3H1X","3HSW"],
#"REVERSE_TRANSCRIPTASE" : ["1C1B","1C1C","1EP4","1RTH","1S1T","1VRU","2BE2","2HND","2HNY","2OPS","2RF2","2RKI","2ZD1","3BGR","3DLE","3DLG","3DOL","3DYA","1VRT","1RT2","1IKW"],
#"RIBONUCLEASE_A" : ["1JN4","1W4O","1W4P","1W4Q","1QHC","1AFK","1ROB","4RSK","1O0F","1O0H","1O0M","1O0N","1Z6S","1U1B"],
#"RIBONUCLEASE_T1" : ["1BIR","1RGK","1RGL","3BIR","5BIR","1RNT","2AAD"],
#"SCYTALONE_DEHYDRATASE" : ["3STD","4STD","5STD","6STD","7STD","2STD"],
#"SIALIDASE" : ["1EUS","1MZ6","1N1T","1N1V","1N1Y","1V3C","1V3D","1V3E","2SIM","3B50","4SLI"],
#"STREPTAVIDIN" : ["1DF8","1SWP","1SWR","1SRG","1SRI","1SRJ","2IZL","1STP"],
#"T4_LYSOZYME" : ["1LI6","1XEP","2OTY","2OTZ","2OU0","181L","182L","183L","184L","185L","186L","187L","188L"],
#"THERMOLYSIN" : ["4TMN","2TMN","4TLN","5TLN","5TMN","6TMN","1HYT","1KJO","1KJP","1KKK","1KL6","1KR6","1KRO","1KS7","1KTO","1OS0","1PE5","1PE7","1PE8","1QF0","1QF1","1QF2","1THL","1TLP","1Z9G","1ZDP"],
#"THROMBIN" : ["1KTS","1KTT","1T4V","1K21","1K22","1ETT","1C5N","1C5O","8KME","1C4U","1C4V","1JWT","1O5G","1SB1","1D3D","1D3P","1D4P","1D6W","1D9I","1GHV","1GHW","1MU6","1MU8","1MUE","1NM6","1NT1","1O2G","1SL3","1TA2","1TA6","1UVT","1Z71","1ZRB","1NZQ","1O0D","1VZQ","1EB1"],
#THYMIDYLATE_SYNTHASE" : ["1F4E","1F4F","1F4G","1JMF","1JMG","1JMI","1NJA","1NJD","1NJE","1TDB","1TSY","1BP0"],"TRIOSEPHOSPHATE_ISOMERASE" : ["2YPI","4TIM","6TIM","7TIM"],
#"TRYPSIN" : ["1PPC","1PPH","1TPS","1C5P","1C5Q","1C5S","1C5T","1CE5","1QB1","1QB6","1QB9","1QBN","2BZA","1C1R","1EB2","1F0T","1F0U","1K1I","1K1J","1K1L","1K1M","1LQE","1QL7","1TNG","1TNH","1TNI","1TNJ","1TNK","1TNL","1V2J","1V2K","1V2L","1V2M","1V2N","1V2O","1V2Q","1V2R","1V2S","1V2T","1V2U","1V2V","1V2W","1UTN","1UTO","1UTP","1G36"],
#"TRYPTOPHAN_SYNTHASE" : ["1A5S","1C9D","1CW2","1CX9","1C8V"],
#"TYROSINE_PHOSPHATASE" : ["1C83","1C84","1C86","1C87","1C88","1BZC","1BZJ","2BGE","1PA9","1G7F","1G7G","1KAV","1PYN","1Q6M","1Q6P","1Q6S","1Q6T","1QXK","1T48","1T49"],
#"YEAST_ENOLASE" : ["1EBG","5ENL","6ENL"]
#}
##################################################################################################################
############### OUTCOME_GRID_Laverty_Version #####################################################################
#################################################################################################################

#This script is used to obtain the top scoring RMSD values to determine the Success Rate
#A success lowest grid score is less than 2.0 A
#A scoring failure is when one of the systems are less then 2.0 A
#A sampling failure is when none of the systems are less than 2.0 A
def outcome_grid(input):
#This failed list represents top 11 RMSD scores but no RMSD's present because all systems failed
    failed=[]
    i=0
    while 11>i:
        failed.append("N/A")
        i=i+1
    #If the file doesn't exist this returns a sampling failure and everything is N/A
    if (not os.path.isfile(input)):
        print(input+" :File not found")
        #CSV order is result, RMSD, Grid Score, Cluster size, # docked, # of docked molecules, 10 best scores
        return 0, "Sampling Failure", "N/A", "N/A","N/A", "N/A", failed
#If this occurs file exist but nothing is within the file, still sampling failure and everything is N/A
    if (os.path.getsize(input) == 0):
        print(input+" :File is present but empty")
#        print input + " is empty."
#        print 'Did not finish'
        return 0, "Sampling Failure","N/A", "N/A","N/A", "N/A", failed
#This successfully opens the file and there is information within the file
    file = open(input, 'r')
#This splits each line within the file
    lines = file.readlines()
    RMSDarray = []
    Grid_Scores=[]
    clusters=[]
#Reads each line within the file
    for line in lines:
        splitline = line.split()
        if len(splitline) == 3:
            #Finds the RMSD to use
            if splitline[1] == "HA_RMSDh:":
                RMSDarray.append(float(splitline[2]))
            #Returns the Grid Score
            if splitline[1]=="Grid_Score:":
                Grid_Scores.append(float(splitline[2]))
            #Returns the cluster size of best ligand
            if splitline[1]=="Cluster_Size:":
                clusters.append(float(splitline[2]))

#Script to get the 10 best results
    RMSD_top_10 = []
    i=0
    #for i in range(1, 11):
    while 10>i:
        if i >= len(RMSDarray):
            RMSD_top_10.append("N/A")
            #break
        else:
            RMSD_top_10.append(RMSDarray[i])
        i=i+1
#This prints a DOCK success if the first RMSD is less than 2.0, Important Script assumes first score is the lowerst energy in the mol2 file
    if RMSDarray[0] <= 2.0: # DOCK success
#        print 'DockSuccess'
        return 1, "Success", RMSDarray[0], Grid_Scores[0], clusters[0], len(RMSDarray), RMSD_top_10
#This sorts all the RMSD's and checks if any of the results are less than 2.0 A
    RMSDarray_original=RMSDarray
    RMSDarray.sort()
#THis checks the new sorted list and the first element is the lowest RMSD value
    if RMSDarray[0] <= 2.0:
#        print 'scoringFailure'
        return 2, "Scoring Failure", RMSDarray[0], Grid_Scores[RMSDarray_original.index(RMSDarray[0])], clusters[RMSDarray_original.index(RMSDarray[0])],len(RMSDarray),RMSD_top_10
#    print 'samplingFailure'
    return 3, "Sampling Failure",RMSDarray[0], Grid_Scores[RMSDarray_original.index(RMSDarray[0])], clusters[RMSDarray_original.index(RMSDarray[0])],len(RMSDarray),RMSD_top_10


###################################################################################################################
################ OUTCOME_GRID_original ######################
##################################

#Not used in current script, you can delete if you want
def outcome_grid_original(input):
    if (not os.path.isfile(input)):
        return [0,0]
    if (os.path.getsize(input) == 0):
#        print input + " is empty."
#        print 'Did not finish'
        return [0,0]
    file = open(input, 'r')
    lines = file.readlines()
    RMSDarray=[]
    for line in lines:
        splitline = line.split()
        if len(splitline) == 3:
            if splitline[1] == "HA_RMSDh:":
                RMSDarray.append(float(splitline[2]))
    RMSD_top_10=[]
    for i in range(1,11):
        if i > len(RMSDarray):
            break
        else:
            RMSD_top_10.append(RMSDarray[i])
        
    if RMSDarray[0] <= 2.0: # DOCK success
#        print 'DockSuccess'
        return [1,RMSDarray[0],len(RMSDarray),RMSD_top_10]
    #initalize variables for keeping track of RMSD rankings
    RMSD_id_array=[]    
    identifier=1
    #generate new list for scoring failures
    for rmsd in RMSDarray:
        RMSD_id_array.append([rmsd,identifier])
        identifier+=1
    first_best=0
    for entry in RMSD_id_array:
        if entry[0] < 2:
            first_best=entry[1]
            print(first_best)
            break
    RMSD_id_array=sorted(RMSD_id_array, key=itemgetter(0))
    if RMSD_id_array[0][0] <= 2.0: 
#        print 'scoringFailure'
        return [2,RMSD_id_array[0][0],RMSD_id_array[0][1],len(RMSD_id_array),RMSDarray[0],RMSD_top_10,first_best]
   
#    print 'samplingFailure'
    return [3,RMSD_id_array[0][0],RMSD_id_array[0][1],len(RMSD_id_array),RMSDarray[0],RMSD_top_10,first_best]

###################################################################################################################
################ OUTCOME_DCE #######################
##################################

#Not used in current script, can delete if you want
def outcome_dce(input):
    if (os.path.getsize(input) == 0):
#        print input + " is empty."
#        print 'Did not finish'
        return 0
    file = open(input, 'r')
    lines = file.readlines()
    RMSDarray = []
    for line in lines:
        splitline = line.split()
        if len(splitline) >= 3:
            if splitline[1] == "HA_RMSDh:":
                rmsd = float(splitline[2])
            if splitline[2] == "Score:":
                nrg = float(splitline[3])
                RMSDarray.append([nrg, rmsd])

    score = [a[0] for a in RMSDarray]
    lowest_score = min(score)

    for entry in RMSDarray:
        if entry[0] == lowest_score:
            if entry[1] <= 2.0:
                return 1
            else:
                return 2
    return 2

###################################################################################################################
################ OUTCOME_FP ########################
##################################

#Not used in current script, can delete if you want
def outcome_fp(input):
    if (os.path.getsize(input) == 0):
#        print input + " is empty."
#        print 'Did not finish'
        return 0
    file = open(input, 'r')
    lines = file.readlines()
    RMSDarray = []
    fps = 0
    for line in lines:
        splitline = line.split()
        if len(splitline) == 3:
            if splitline[1] == "HA_RMSDh:":
                rmsd = float(splitline[2])
                fps = 0
            if splitline[1] == "vdw_fp:":
                fps += float(splitline[2])
            if splitline[1] == "es_fp:":
                fps += float(splitline[2])
                RMSDarray.append([fps, rmsd])

    fps = [a[0] for a in RMSDarray]
    lowest_fps = min(fps)

    for entry in RMSDarray:
        if entry[0] == lowest_fps:
            if entry[1] <= 2.0:
                return 1
            else:
                return 2
    return 2

####################################################################################################################
#############time##############################################################################
###################################################################################################################

#This script unlike other functions uses a .out file not a mol2 file
def outcome_time(input):
    #This determines if file exist, if not it returns N/A
    if (not os.path.isfile(input)):
        print(input+" :File not found")
        # CSV order is result, RMSD, Grid Score
        return "N/A"
    # If this occurs file exist but nothing is within the file and returns N/A
    if (os.path.getsize(input) == 0):
        #        print input + " is empty."
        #        print 'Did not finish'
        print(input+" :File found but file is empty")
        return "N/A"
    #If all of this exist then it reads the output file
    times = open(input, "r")
    #This splits each line within the file
    lines = times.readlines()
    #This for loop reads each line in the file
    for line in lines:
        #If this string is within the line it provides the time in this file
        if "Total elapsed time:" in line:
            #This splits all the values in the output
            values=line.split()
            #This returns the time for script to occur
            return values[3]

###################################################################################################################
############################# Rotable bonds ########################################################################
#################################################################################################################

#The purpose of this script is to obtain more details of the ligand including the rotable bonds, molecular weight, Formal Charge
def outcome_lig_details(input):
    if (not os.path.isfile(input)):
        print(input+" not found")
        # CSV order is result, RMSD, Grid Score
        return "N/A","N/A","N/A"
    # If this occurs file exist but nothing is within the file
    if (os.path.getsize(input) == 0):
        print(input+ " file found but is empty")
        #        print input + " is empty."
        #        print 'Did not finish'
        return "N/A","N/A","N/A"
    lig_details=open(input,"r")
    lines=lig_details.readlines()
    #The molecular weight
    MW=""
    #The rotatable bonds
    RB=""
    #The Formal Charge
    FC=""
    #This reads each of line within the mol2
    for line in lines:
        #This splits each string within a line of the file
        values=line.split()
        #This obtains the 3rd arguement
        if len(values)==3:
            #This obtains the dock rotatable bonds
            if values[1]=="DOCK_Rotatable_Bonds:":
                RB=values[2]
            #This returns the molecular weight
            if values[1]=="Molecular_Weight:":
                MW=values[2]
            #This returns the formal charge and all three variables,
            #These variables all the same for all ligands so it just reads the top one
            if values[1]=="Formal_Charge:":
                FC=values[2]
                return RB,MW,FC

##################################################################################################################
######################## Determining Ions present ################################################################
#################################################################################################################

#This assigns ions and cofactors to each system
def assign_Ions(sys,cofactor, name_dict):
    #rescounter reads through residue on the list
    res_counter = 0
    #This is the number of ions presents
    #It used to be true or false but
    Zn_bool = 0
    Mg_bool = 0
    Mn_bool = 0
    K_bool = 0
    Na_bool = 0
    Cl_bool = 0
    Cal_bool = 0
#Opens the source file of the best mol2 files
    with open("/gpfs/projects/rizzo/zzz.SB2012_testset/Dock6_testset/zzz.distribution/" + sys + "/" + sys + ".rec.clean.mol2") as f:
        #Checks if the ion is present in any of the scripts
        for line in f:
            if "RESIDUE" in line:
                res_counter += 1
            if " Zn " in line:
                Zn_bool = Zn_bool+1
            if " Mg " in line:
                Mg_bool = Mg_bool+1
            if " Mn " in line:
                Mn_bool = Mn_bool+1
            if " K " in line:
                K_bool = K_bool+1
            if " Na+ " in line:
                Na_bool = Na_bool+1
            if " Cl " in line:
                Cl_bool = Cl_bool+1
            if " CAL " in line:
                Cal_bool = Cal_bool+1
    #This checks the cofactor list to determine if any of the files exist
    cofact=""
    if sys in cofactor:
        cofact="YES"
    else:
        cofact="NO"
    #Appends each of the ions on the string
    ions=""
    if (Zn_bool > 0):
        ions=ions+"Zn/"
    if (Mg_bool > 0):
        ions=ions+"Mg/"
    if (Mn_bool > 0):
        ions=ions+"Mn/"
    if (K_bool > 0):
        ions=ions+"K/"
    if (Na_bool > 0):
        ions=ions+"Na/"
    if (Cl_bool > 0):
        ions=ions+"Cl/"
    if (Cal_bool > 0):
        ions=ions+"Cal/"
    #This determine what protein family the system is
    family_name = ""
    for key in name_dict:
        for pdb in name_dict[key]:
            if sys == pdb:
                family_name = key
                break
#This returns the ions, family, and residue counter
    #aggregate_CSV.write("%s,%s,%d," % (sys, family_name, res_counter))
    return str(Zn_bool), str(Mg_bool), str(Mn_bool),str(K_bool), str(Na_bool), str(Cl_bool),str(Cal_bool), cofact, ions, \
           family_name, str(res_counter)


#################################################################################################################
######## MAIN ##########################################################
##################################

def main():
    try:
        dock_suc = 0
        scoring = 0
        sampling = 0
        unfinished = 0

        # if len(argv) !=3:
        #    print(argv[0], "[FLX/RGD/FAD] ListFile")
        #    exit()
        function = argv[1]
        listFile = argv[2]
        CSV_File = argv[3]
        # scoredFile = argv[2]

        systemsFile = open(listFile, 'r')

        systems = systemsFile.readlines()
        systemsFile.close()
        # The list of cofactors present
        families = open("/gpfs/projects/rizzo/for_Scott/family_PR.txt", "r")
        family_split = families.readlines()
        print(family_split)
        dict_family = {}
        i = 0
        while len(family_split) > i:
            print(family_split[i])
            value = family_split[i].split(":")
            value[0] = value[0].replace(" ", "")
            value[1] = value[1].replace(" ", "")
            value[1] = value[1].replace("\"", "")
            value[1] = value[1].replace("[", "")
            value[1] = value[1].replace("]", "")
            value[1] = value[1].replace("\n", "")
            sys = value[1].split(",")
            family_sys = []
            for j in sys:
                if len(j) == 4:
                    family_sys.append(j)
            dict_family.update({value[0].replace("\"", ""): family_sys})
            i = i + 1
        print(dict_family)
        # print(name_dict)
        cofactor_list = ["1A7A", "1AH3", "1B8O", "1C2T", "1F9H", "1H1D", "1HNN", "1HQ2", "1HVY", "1IA1", "1IA2", "1IA3",
                         "1IA4", "1J3I", "1J3J", "1J3K", "1KIM", "1ME7", "1MEH", "1MEI", "1MMV", "1MMW", "1MZC", "1N2J",
                         "1P44", "1P62", "1SG0", "1SQ5", "1T40", "1U1C", "1X8X", "1XOS", "3DFR", "3K5V", "3LSY"]
        # print N

        # success_file=open("2019-09-16.dock6.SB2012.sampling_failure_RClust1_conf10.FLX.dat","w")
        # scoring_failure_file=open("2019-09-16.dock6.SB2012.scoring_failure_RClust1_conf10.FLX.dat","w")
        # sampling_failure_file=open("2019-09-16.dock6.SB2012.success_RClust1_conf10.FLX.dat","w")

        success_file = open("%s.bickel.dock6.SB2012.success.%s.dat" % (str(datetime.date.today()), function), "w")
        scoring_failure_file = open(
            "%s.bickel.dock6.SB2012.scoring_failure.%s.dat" % (str(datetime.date.today()), function), "w")
        sampling_failure_file = open(
            "%s.bickel.dock6.SB2012.sampling_failure.%s.dat" % (str(datetime.date.today()), function), "w")
        Mega_CSV = []
        # aggregate_CSV=open(CSV_File+".csv","w")
        # aggregate_CSV.write("PDB_CODE,FAMILY,NUM_RES,COFACTORS,IONS,SUCCESS,SCORING FAILURE,SAMPLING FAILURE,RMSD LOWEST,RANK LOWEST RMSD,TOT CONF,FIRST_SUCC,RMSD RANK 1,RMSD RANK 2,RMSD RANK 3,RMSD RANK 4,RMSD RANK 5,RMSD RANK 6,RMSD RANK 7,RMSD RANK 8,RMSD RANK 9,RMSD RANK 10,RMSD RANK 11\n")
        for sys in systems:
            sys = sys.rstrip()
            # out_grid = outcome_grid(sys+"/07a-mod_flex.dock/mod_flex.dock_scored.mol2")
            # out_grid = outcome_grid(sys+"/04b-min_flag.dock/min_flag.dock_scored.mol2")
            # out_grid = outcome_grid(sys+"/04-min_flag.dock/min_flag.dock_scored.mol2")
            # out_grid = outcome_grid(sys+"/02-am1bcc.dock/am1bcc.dock_scored.mol2")
            # out_grid = outcome_grid(sys+"/"+function+"/"+sys+"."+function+"_scored.mol2")
            # out_grid = outcome_grid(sys+"/slaverty_dock/4.dock/dock_test_run_8_13_19/"+sys+"dock_test_run_8_13_19_scored.mol2")

            out_grid, result, RMSD, Grid, cluster, total, top = outcome_grid(
                sys + "/" + function + "/" + sys + "." + function + "_scored.mol2")
            time = outcome_time(sys + "/" + function + "/" + function + ".out")
            # print(sys+"/"+function+"/"+function+".out")
            RB, MW, FC = outcome_lig_details(sys + "/" + function + "/" + sys + "." + function + "_scored.mol2")
            Zn, Mg, Mn, K, Na, Cl, Ca, cofact, ions, family, residue = assign_Ions(sys, cofactor_list, dict_family)
            Mega_CSV.append(
                [sys, result, str(RMSD), Grid, cluster, function, time, RB, MW, FC, total, top[0], top[1], top[2],
                 top[3], top[4], top[4], top[5],
                 top[6], top[7], top[8], top[9], Zn, Mg, Mn, K, Na, Cl, Ca, cofact, ions, family, residue])
            # out_grid=outcome_grid(sys+"/slaverty_dock/4.dock/dock_test_run_9_10_19_RMSD_Clust1_Conf10/FLX_RMSD1_Conf10/"+sys+".FLX_RMSD1_Conf10_scored.mol2")

            if (out_grid == 1):
                dock_suc += 1
                success_file.write("%s\n" % sys)

                # aggregate_CSV.write("YES,NO,NO,%04.2f,1,%d,1,%04.2f" % (out_grid[1],out_grid[2],out_grid[1]))



            #    for entry in out_grid[3]:
            # aggregate_CSV.write(",%04.2f" % entry)
            # aggregate_CSV.write("\n")
            # print sys, "success"

            elif (out_grid == 2):
                scoring += 1
                scoring_failure_file.write("%s\n" % sys)

                # aggregate_CSV.write("NO,YES,NO,%04.2f,%d,%d,%d,%04.2f" % (out_grid[1],out_grid[2],out_grid[3],out_grid[6],out_grid[4]))

                # for entry in out_grid[5]:
                #    aggregate_CSV.write(",%04.2f" % entry)
                # aggregate_CSV.write("\n")



            # print sys, "scoring"
            elif ((out_grid == 3) or (out_grid == 0)):
                sampling += 1
                sampling_failure_file.write("%s\n" % sys)
            # if ( out_grid[0] == 3 ):

            # aggregate_CSV.write("NO,NO,YES,%04.2f,%d,%d,%d,%04.2f" % (out_grid[1],out_grid[2],out_grid[3],out_grid[6],out_grid[4]))

            # for entry in out_grid[5]:
            #    aggregate_CSV.write(",%04.2f" % entry)
            # aggregate_CSV.write("\n")

            # print sys, "sampling"
            if (out_grid == 0):
                #    aggregate_CSV.write("UNFINISHED\n")
                unfinished += 1
            # print sys
        # out_heuc = outcome_fp(sys+"/half_euclidean_scored.mol2")
        # if (out_heuc == 1):
        #    heuc_suc += 1

        # out_eucl = outcome_fp(sys+"/euclidean_scored.mol2")
        # if (out_eucl == 1):
        # i = 0
        # while len(Mega_CSV) > i:
        #    print(Mega_CSV[i])
        #    i = i + 1
        #    eucl_suc += 1
        with open(CSV_File + '.csv', mode='w') as Creating_CSV:
            The_CSV = csv.writer(Creating_CSV, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
            The_CSV.writerow(
                ["PDB ID", "Results", "Best RMSD", "Grid Score", "Cluster", "Docking type", "time", "Rotatable Bonds",
                 "Molecular Weight", "Formal Charge",
                 "# of docked ligands", "1st RMSD", "2nd RMSD", "3rd RMSD", "4th RMSD", "5th RMSD", "6th RMSD",
                 "7th RMSD", "8th RMSD",
                 "9th RMSD", "10th RMSD", "11th RMSD", "# Zn", "# Mg", "# Mn", "# K", "# Na", "# Cl", "# Ca",
                 "cofactor", "Ions", "Protein Family", "Residues"])
            z = 0
            while len(Mega_CSV) > z:
                The_CSV.writerow(Mega_CSV[z])
                z = z + 1

        success_file.close()
        scoring_failure_file.close()
        sampling_failure_file.close()
        # aggregate_CSV.close()
        print(len(systems), "Systems")
        print("Success", dock_suc, (dock_suc / float(len(systems))) * 100)
        print("Scoring", scoring, (scoring / float(len(systems))) * 100)
        print("Sampling", sampling, (sampling / float(len(systems))) * 100)
        print("Unfinished", unfinished, (unfinished / float(len(systems))) * 100)
    except:
        print("There was an issue with the docking process")
        print("Make sure you apply the proper input format of the script\n\n")
        print("Arguement 1 is the name of file")
        print("Example input\nFLX")
        print("Arguement 2 is the list of systems. Systems in file should be listed as below\n121P\n181L\n182L\n183L\netc\n")
        print("mol2 format is expected to be:")
        print("121P/FLX/121P.FLX.mol2")
        print("181L/FLX/181L.FLX.mol2")
        print("out put file format is expected to be:\n121P/FLX/FLX.out\n181L/FLX/FLX.out")
        print("Arguement 3 is the csv file name")
        print("Example input\nDOCK6\nDOCK6.csv")


###########################################
main()
###########################################

