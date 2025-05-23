#!/bin/sh
#SBATCH --account=def-desgagne
#SBATCH --job-name=blastp_Hipap
#SBATCH --time=1-0:00:00
#SBATCH --nodes=1
#SBATCH --output=/scratch/$USER/Hippeastrum_papilio/slurms/blastp-%j.out
#SBATCH --cpus-per-task=16
#SBATCH --mem=10G

module restore annotation_modules
THREADS=16


echo Starting blastp with longest_orfs.pep


blastp -query /scratch/$USER/Hippeastrum_papilio/Hippeastrum_papilio_nt97.fa.transdecoder_dir/longest_orfs.pep\
  -db /project/def-desgagne/trinotate_data/uniprot_sprot.pep\
  -evalue 1e-5\
  -task  blastp\
  -num_threads ${THREADS}\
  -max_target_seqs 1\
  -outfmt '6'\
  > /scratch/$USER/Hippeastrum_papilio/results_annotation/longest_orfs.pep_blastp.out

echo Finished blastp with longest_orfs.pep
