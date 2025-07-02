#!/bin/bash

# GET all Maps using "/api/khub/maps" endpoint and parse out the "id" value for each map to save in a variable

#Playground
portalURL="URL HERE"
authorization="Bearer NoneYaBusiness"
endpoint="/api/khub/maps"
requestType="GET"
requestBody=$(cat << EOF
EOF
)

jsonResponse=$(curl -s -H "Authorization: $authorization" -H "Content-type: application/json" -H "Accept: application/json" "$portalURL""$endpoint" -X GET)

mapIds=($(echo $jsonResponse | jq -r '.[].id'))


for mapId in "${mapIds[@]}"
do
	
	count=$(curl -s -H "Authorization: $authorization" -H "Content-type: application/json" -H "Accept: application/json" "$portalURL""/api/khub/maps/$mapId/topics" -X GET | jq length)
	echo "Map ID $mapId has $count topics"
	
done