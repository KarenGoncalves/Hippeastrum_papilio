#!/bin/sh
#SBATCH --account=def-desgagne
#SBATCH --job-name=emapper_Hipap
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --output=/scratch/$USER/Hippeastrum_papilio/slurms/emapper-%j.out
#SBATCH --cpus-per-task=16
#SBATCH --mem=20G

THREADS=16

ml StdEnv/2020 scipy-stack/2020a

source ~/eggnog/bin/activate
DATA_DIR=/project/def-desgagne/trinotate_data

emapper.py -i /scratch/$USER/Hippeastrum_papilio/Hippeastrum_papilio_nt97.fa.transdecoder.pep\
 --cpu $THREADS\
 --data_dir ${DATA_DIR}\
 -o /scratch/$USER/Hippeastrum_papilio/results_annotation/eggnog_mapper
