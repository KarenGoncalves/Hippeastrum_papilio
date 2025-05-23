#!/bin/sh
#SBATCH --account=def-desgagne
#SBATCH --job-name=busco
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --output=/scratch/$USER/Hippeastrum_papilio/busco-%j.out
#SBATCH --cpus-per-task=8
#SBATCH --mem=10G

module restore annotation_modules
THREADS=16

source ~/trinotateAnnotation/bin/activate

cd /scratch/$USER/Hippeastrum_papilio/

busco --offline\
 --in $PWD/Hippeastrum_papilio/Hippeastrum_papilio_nt97.fa\
 --out busco\
 --lineage_dataset $HOME/busco_downloads/lineages/liliopsida_odb10\
 --mode transcriptome\
 --cpu ${THREADS} -f
