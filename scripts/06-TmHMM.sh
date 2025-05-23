#!/bin/sh
#SBATCH --account=def-desgagne
#SBATCH --job-name=tmhmm_Hipap
#SBATCH --time=2:00:00
#SBATCH --nodes=1
#SBATCH --output=/scratch/$USER/Hippeastrum_papilio/slurms/tmhmm-%j.out
#SBATCH --cpus-per-task=16
#SBATCH --mem=500M

module restore annotation_modules
THREADS=16


echo Starting TMHMM

tmhmm --short <\
  /scratch/$USER/Hippeastrum_papilio/Hippeastrum_papilio_nt97.fa.transdecoder.pep >\
  /scratch/$USER/Hippeastrum_papilio/results_annotation/Hippeastrum_papilio_nt97.fa.transdecoder.pep_tmhmm.out

echo Finished TMHMM
