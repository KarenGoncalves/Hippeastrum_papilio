#!/bin/sh

DIR=$SCRATCH/Hippeastrum_papilio/clean_reads
metadata=$DIR/metadata/metadata.txt

cut -f 1,2 $metadata |\
 awk -v DIR=$DIR 'BEGIN {OFS="\t"}\
	{print $2, $1, DIR"/"$1"_1.fastq", DIR"/"$1"_2.fastq"}'\
 > metadata/samples_file.txt

# cut -f 1,2 means "select first and second columns"
# The awk command creates an awk variable for the directory,
# indicates that the output field separator is a tab (BEGIN {}),
# Finally it indicates what is to be printed:
# SampleName	ReplicateName	Read1_path	Read2_path
