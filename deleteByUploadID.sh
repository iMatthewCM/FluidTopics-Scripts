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
portal="https://portalURL.fluidtopics.net"

#API Token
authorization="Bearer h3yRGUwNASDU76xkaHG1cGIuygSA"

#Upload ID
uploadID="asd86be3d-f39b-46a7-af28-c4e3asd87f"

#################################
# STOP
#
# DO NOT MODIFY BELOW THIS LINE
#################################

#Gather all document IDs associated with the Upload ID
itemsToDelete=$(curl -s -H "Authorization: $authorization" -H "Content-type: application/json" -H "Accept: application/json" "$portal/api/khub/uploads/$uploadID/report" -X GET | jq '.publications[].khubId')

#Add all found document IDs into an array
IFS=$'\n' read -r -d '' -a doc_array <<< "$itemsToDelete"

#Loop through the array and process each document ID
for docID in "${doc_array[@]}"; do

	#Trim off the quotes around the docID as they will cause errors
	docID="${docID%\"}"
	docID="${docID#\"}"
	
	#Delete the document using its document ID
	curl -s -H "Authorization: $authorization" -H "Ft-Calling-App: deleteByUploadID" "$portal/api/admin/khub/documents/$docID" -X DELETE
	
done