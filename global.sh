#!/usr//bin/env bash

# The credential information for the event stream 
USER="perfuser"

# The password need to be set localy only and not push to the repo.
PASS="<change me>"

# The AAP administrator credential
ADMIN_USER="admin"

# The password need to be set localy only and not push to the repo.
ADMIN_PASS="<change me>"

# The test time in Minuts
TEST_TIME=120

# Events per seconds
EVPSEC=5

# Jobs per minute
JPM=1

# when testing SaaS - on ly the cluster name is changed between different deployments
Cluster_name="8b3l6r"

function set_auth {
    user=$1
    password=$2
    BAUTH=$(echo -n "${user}:${password}" | base64)
    echo ${BAUTH}
}


BAUTH=$(set_auth ${USER} ${PASS})
AUTH="Authorization: Basic ${BAUTH}"

ABAUTH=$(set_auth ${ADMIN_USER} ${ADMIN_PASS})
ADMIN_AUTH="Authorization: Basic ${ABAUTH}"

HEAD="Content-Type: application/json"

Base_URL="https://platform.cus-${Cluster_name}.int.aws.ansiblecloud.com"
Base_API="eda-event-streams/api/eda/v1/external_event_stream"

# sleep time between events which should fire jobs on the AAP
((JPM_Sleep=60/${JPM}))

# The uuid of event streams URL in the EDA - need to be update for every new ES which created.
#EES_array=("42dbece1-5fb6-4830-b2c8-0ddb5d63ddce" "2865a9c1-2d4b-47da-aaef-138052063c9e" "872bfb8d-6470-4b19-978e-41e0aa7ca315" "f5bd3e0b-c241-4e48-81fd-0ca4bdb781be" "59cffaa1-cc11-4c2d-8823-ea77926476a9" "6e992d16-ce75-4c96-b283-9eaa69e5e060")
EES_array=("42dbece1-5fb6-4830-b2c8-0ddb5d63ddce" "2865a9c1-2d4b-47da-aaef-138052063c9e" "872bfb8d-6470-4b19-978e-41e0aa7ca315")


# calculate the number of event to send as factor of test runtime + 2 minutes
((EVENTS=${TEST_TIME}*60+120))       
((JOB_EVENTS=${TEST_TIME}*${JPM}))    

function get_url {
    BURL="${Base_URL}/${Base_API}/${1}/post/"
    echo ${BURL}
}

function get_hostname {
    # getting host name
	HN=$((1 + $RANDOM % 500))
	HOST="host-${HN}.example.com"
    echo ${HOST}
}

function test_done {
    echo "The test is done !"
    exit
}
