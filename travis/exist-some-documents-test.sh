#!/bin/bash

EXPECTED_COUNT=30
COUNT_OF_DOCUMENTS=$(curl -s "localhost:9200/performance-tests-*/_count?filter_path=count" | sed 's/{"count"://g' | sed 's/}//g')

echo "Documents: ${COUNT_OF_DOCUMENTS}, Expected: ${EXPECTED_COUNT}"

if (( $COUNT_OF_DOCUMENTS > $EXPECTED_COUNT )) ; then
	exit 0
else
	exit 1
fi
