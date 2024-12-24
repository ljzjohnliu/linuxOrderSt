#!/bin/bash


imagesInputFile=$1
imagesOutputFile="oc_url"

if [[ $imagesInputFile == "" ]]; then
	echo "error: must have a image url input file !"
 	exit 1
fi

while read line || [[ -n $line ]]
do
	args=($line)

	if [[ ${args[0]} == "" ]]; then
		echo "" >> $imagesOutputFile
		continue
	fi

	if [[ ${args[0]} == "#" ]]; then
		echo $line >> $imagesOutputFile
		continue
	fi

	imageURL=${args[0]}
	imageOCURL="\"${imageURL}\","
	echo $imageOCURL >> $imagesOutputFile
done < $imagesInputFile

echo ""
echo ""
echo "done ~"
