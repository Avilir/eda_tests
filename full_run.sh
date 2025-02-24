#!/usr//bin/env bash

source ./global.sh

multi_test=$1
if [[ $multi_test == "" ]] ; then
    multi_test=false
else
    multi_test=true
fi

if [[ $multi_test == "true" ]] ; then
    xterm -hold -e "./job_batch.sh" &
    sleep 30
fi

((total_es=${#EES_array[@]}-1))

for index in $(seq 0 $total_es) ; do
    echo $index
    xterm -hold -e "./se.sh $index ${EVPSEC}" &
done


sleep 15

for index in $(seq 0 $total_es) ; do
    echo $index
    xterm -hold -e "./je.sh $index" &
    sleep 5
done

exit
