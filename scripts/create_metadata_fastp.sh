#!/bin/sh

sed -E 's/^([A-Z]{,2})([123])/\1\2\t\1/g'\
 metadata/GENOME_QUEBEC_data.txt\
 | cut -f 1,2  |\
 awk '$1 != "" {if ($2 == "R") {tissue="Root"}\
        else if ($2 == "BS") {tissue="Basal_plate"}\
        else if ($2 == "YF") {tissue="Young_leaf"}\
        else if ($2 == "OF") {tissue="Old_leaf"}\
        else if ($2 == "BI") {tissue="Inner_bulb"}\
        else if ($2 == "PD") {tissue="Peduncle"}\
        else if ($2 == "PI") {tissue="Pistil"}\
        else if ($2 == "PT") {tissue="Petal"}\
	else if ($2 == "ST") {tissue="Stem"}\
        else {tissue=$2};\
	print $1, tissue, "PE", "Illumina", "normal"}'\
 | tail -n +2 > metadata/metadata.txt

