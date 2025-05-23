#!/bin/sh
#SBATCH --account=def-desgagne
#SBATCH --mem=8G
#SBATCH --time=3:00:00
#SBATCH --job-name=Hipap_LO
#SBATCH --output=/scratch/$USER/Hippeastrum_papilio/slurms/longOrfs-%j.out


module load StdEnv/2020 gcc/9.3.0 transdecoder

SPECIES=Hippeastrum_papilio
DIR=$SCRATCH/${SPECIES}
ASSEMBLY=$DIR/${SPECIES}_nt97.fa
gtm=$DIR/${SPECIES}_gene_trans_map


TransDecoder.LongOrfs\
 -t $ASSEMBLY\
 --gene_trans_map $gtm\
 --output_dir $DIR
