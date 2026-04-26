#!/bin/sh -fe

#
# Edit the lines below to match your desired environment variables. Source this script prior to
# running the others.
#
# Remember to define each variable to meet your cluster/system


### Source some global variables

export WORK_DIR=`pwd`

export LIST_DIR="${WORK_DIR}/zzz.family_lists"

#This directory is only used if you are aligning and processing protein families yourself
export BUILD_DIR="${WORK_DIR}/zzz.builds"

#This is where crossdocking is run
export CROSSDOCK_DIR="${WORK_DIR}/zzz.crossdock"

export SCRIPTS_DIR="${WORK_DIR}/zzz.crossdock_scripts"

#Uppermost path to DOCK6 compilation (Dont include bin)
export DOCK_DIR="YOURPATH"

#If you are using the pre-processed downloaded testset set below variable to yes and set path
export prepped_set="yes"
if [ "$prepped_set" = "yes" ];then
  export TESTSET_DIR="YOURPATH/SB2025_v1_DOCK6_CDfam"
fi

