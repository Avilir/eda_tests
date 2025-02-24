#!/usr//bin/env bash

source ./global.sh

ev_stream=$1
ev_per_sec=$2

if [[ ${ev_stream} == "" ]] ; then
	ev_stream=0
fi


if [[ ${ev_per_sec} == "" ]] ; then
	ev_per_sec=1
fi

BURL="$(get_url ${EES_array[$ev_stream]})"

for i in `seq 1 ${EVENTS}` ; do

	DATA="{'letters': 'bbb', 'meta': {'hosts': '$(get_hostname)'}}"

	for j in `seq 1 ${ev_per_sec}` ; do
		echo "sendinh job ${i}.${j}"
		curl -X POST -H "${HEAD}" -H "${AUTH}" ${BURL} --data-raw "${DATA}"  &
	done
	sleep 1
done

test_done
