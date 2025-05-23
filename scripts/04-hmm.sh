#!/bin/sh
#SBATCH --account=def-desgagne
#SBATCH --job-name=hmm_Hipap
#SBATCH --time=2-0:00:00
#SBATCH --nodes=1
#SBATCH --output=/scratch/$USER/Hippeastrum_papilio/slurms/hmm-%j.out
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G

module restore annotation_modules
THREADS=16



echo Starting HMMScan


hmmscan\
  --cpu ${THREADS}\
  --domtblout /scratch/$USER/Hippeastrum_papilio/results_annotation/longest_orfs.pep_TrinotatePFAM.out\
  /project/def-desgagne/trinotate_data/Pfam-A.hmm\
  /scratch/$USER/Hippeastrum_papilio/Hippeastrum_papilio_nt97.fa.transdecoder_dir/longest_orfs.pep

echo 'Finished HMMScan'
