#!/bin/bash

# GET all Maps using "/api/khub/maps" endpoint and parse out the "id" value for each map to save in a variable

#mapIds=()
#mapIds=$(curl -s -H "Authorization: Bearer $token" -H "Content-type: application/json" -H "Accept: application/json" "https://portal.fluidtopics.net/api/khub/maps" -X GET | jq -r ".[] | .id")


#Playground
portalURL="https://sandbox.fluidtopics.net/mml-luxo"
authorization="Bearer nbiMy9vDuRLmXFdOr97QNYDJDcgrjZKK"
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