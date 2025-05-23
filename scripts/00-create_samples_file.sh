#!/bin/sh

DIR=$SCRATCH/Hippeastrum_papilio
metadata=$DIR/metadata/metadata.txt

cut -f 1 $metadata |\
 sed -E "s/([A-Z]{,2})([0-9]+)/\1\t\1\2/" |
 awk -v DIR=$DIR 'BEGIN {OFS="\t"}\
 NR>1 {if ($1 == "R") {tissue="Root"}\
	else if ($1 == "BS") {tissue="Basal_plate"}\
	else if ($1 == "YF") {tissue="Young_leaf"}\
	else if ($1 == "OF") {tissue="Old_leaf"}\
	else if ($1 == "BI") {tissue="Inner_bulb"}\
	else if ($1 == "PD") {tissue="Peduncle"}\
	else if ($1 == "PI") {tissue="Pistil"}\
	else if ($1 == "PT") {tissue="Petal"}\
	else {tissue=$1};\
	print tissue, $2, DIR"/"$2"_1.fastq", DIR"/"$2"_2.fastq"}'\
 > metadata/samples_file.txt

# cut -f 1 means "select first column"
# sed is using regex (-E) to get the sample name and the replicate number
# the replacement (after the second /) creates one column for sample and one for replicate
# The awk command creates an awk variable for the directory,
# indicates that the output field separator is a tab (BEGIN {}),
# removes the column names (first row) from the data (NR > 1)
# and then defines the actual tissue names based on the letters in column 1
# Finally (after the ;) it indicates what is to be printed:
# SampleName	ReplicateName	Read1_path	Read2_path
