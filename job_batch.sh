#!/usr/bin/env bash

source ./global.sh

# This script is launching a batch of jobs on the AAP so it will run jobs
# during the EDA is working.

# you need to launch - using bulk API - some jobs (5 to 15)
# and update the workflow job id and the time it take for it to comleate.

# The workflow JOB ID
ID=9991

# The time it take the workflow to compleate (in seconds) - add 1 minute
RUNTIME=300

# Calculate the number of batches 
((batches=${TEST_TIME}*60/${RUNTIME}))

API="api/controller/v2/workflow_jobs"

BURL="${Base_URL}/${API}/${ID}/relaunch/"

for i in $(seq 1 ${batches}) ; do
    
    curl -X POST -H "${HEAD}" -H "${ADMIN_AUTH}"  ${BURL}
    sleep ${RUNTIME}
done

