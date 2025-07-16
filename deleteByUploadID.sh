#!/bin/bash

#################################################################################
#
# THIS SCRIPT IS NOT AN OFFICIAL PRODUCT OF ANTIDOT / FLUID TOPICS
# AS SUCH IT IS PROVIDED WITHOUT WARRANTY OR SUPPORT
#
# BY USING THIS SCRIPT, YOU AGREE THAT ANTIDOT / FLUID TOPICS 
# IS UNDER NO OBLIGATION TO SUPPORT, DEBUG, OR OTHERWISE MAINTAIN THIS SCRIPT 
#
#################################################################################

#Portal URL
portal="https://portal.fluidtopics.net"

#API Token
authorization="Bearer Yxh2k347xkjhasdfash4r"

#Upload ID
uploadID="acas7dd-f32b-43a7-af28-ea7asdkjhx19f"

#################################
# STOP
#
# DO NOT MODIFY BELOW THIS LINE
#################################

#Initialize an empty array to build up through paginated results
doc_array=()

#Start on this page
currentPage=1

#Keep looping as long as this variable is true
shouldKeepLooping=true

while $shouldKeepLooping
do
	echo "Getting results for page $currentPage"
	#Get the number of results on the current page
	pageOutput=$(curl -s -H "Authorization: $authorization" -H "Content-type: application/json" -H "Accept: application/json" "$portal/api/khub/uploads/$uploadID/report?page=$currentPage&per_page=100" -X GET)
	
	#Get how many results this page had
	numResults=$(echo "$pageOutput" | jq '.paging.totalCount')
	
	#Get all of the khubIDs from this page
	itemsToDelete=$(echo "$pageOutput" | jq '.publications[].khubId')
	
	#Read the IDs into a temporary "items" array
	IFS=$'\n' read -r -d '' -a items <<< "$itemsToDelete"
	
	#Append the contents of the temporary "items" array to doc_array
	doc_array+=("${items[@]}")
	
	#If there aren't 100 results
	if (( $numResults < 100 )); then
		#We're on the last page, set the variable to false to break the loop
		shouldKeepLooping=false
	else
		#We still need to keep looping, increment the page value to check the next page
		((currentPage++))
	fi
	
done

echo "Found ${#doc_array[@]} documents to delete"

#Loop through the array and process each document ID
for docID in "${doc_array[@]}"; do
	
	#Trim off the quotes around the docID as they will cause errors
	docID="${docID%\"}"
	docID="${docID#\"}"
	
	#Delete the document using its document ID
	curl -s -H "Authorization: $authorization" -H "Ft-Calling-App: deleteByUploadID" "$portal/api/admin/khub/documents/$docID" -X DELETE
	echo ""
	
done