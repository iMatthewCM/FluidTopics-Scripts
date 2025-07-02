#!/bin/bash

#Update this file path to point at a list of all of the IPs that already exist in the white/black list
existingIPListFile="/Users/Matthew/Desktop/existingIPs.txt"

#Update this file path to point to a list of IPs you'd like to potentially add to the white/black list
listOfIPsToCheckFile="/Users/Matthew/Desktop/IPsToAdd.txt"

#Do not modify below this line
echo "The following IPs do not already exist in the IP list and need to be added:"

while read ipToCheck
do
	found=$(grep $ipToCheck "$existingIPListFile")
	if [[ "$found" == "" ]]; then
		echo "$ipToCheck"
	fi
done < "$listOfIPsToCheckFile"