#!/bin/sh -fe

#
# Edit the lines below to match your desired environment variables. Source this script prior to
# running the others.
#
# Remember to define each variable to meet your cluster/system


### Source some global variables

export WORK_DIR=`pwd`

export LIST_DIR="${WORK_DIR}/zzz.family_lists"

export BUILD_DIR="${WORK_DIR}/zzz.builds"

export CROSSDOCK_DIR="${WORK_DIR}/zzz.crossdock"

export SCRIPTS_DIR="${WORK_DIR}/zzz.crossdock_scripts"

#If you are using the pre-processed downloaded testset set below variable to yes and set path
export prepped_set="yes"
if [ "$prepped_set" = "yes" ];then
  export TESTSET_DIR="/gpfs/scratch/ccorbo/ScriptTesting/SB2025_v1_DOCK6_CDfam"
fi

