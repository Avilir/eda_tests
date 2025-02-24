#!/usr//bin/env bash

source ./global.sh

ev_stream=$1

if [[ ${ev_stream} == "" ]] ; then
	ev_stream=0
fi

BURL="$(get_url ${EES_array[$ev_stream]})"

for i in `seq 1 ${JOB_EVENTS}` ; do

	DATA="{'letters': 'aaa', 'meta': {'hosts': '$(get_hostname)'}}"

	echo "sendinh job ${i} - $DATA"
	curl -X POST -H "${HEAD}" -H "${AUTH}" ${BURL} --data-raw "${DATA}"  &
	sleep ${JPM_Sleep}
done

test_done
