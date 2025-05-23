#!/bin/sh
#SBATCH --account=def-desgagne
#SBATCH --job-name=infernal_Hipap
#SBATCH --time=2-00:00:00
#SBATCH --nodes=1
#SBATCH --output=/scratch/$USER/Hippeastrum_papilio/slurms/infernal-%j.out
#SBATCH --cpus-per-task=4
#SBATCH --mem=5G

module restore annotation_modules
THREADS=4

splitN=${SLURM_ARRAY_TASK_ID}

cd /scratch/$USER/Hippeastrum_papilio/results_annotation

Trinotate --db ../Trinotate.sqlite\
 --CPU ${THREADS}\
 --transcript_fasta /scratch/$USER/Hippeastrum_papilio/Hippeastrum_papilio_nt97.fa\
 --transdecoder_pep /scratch/$USER/Hippeastrum_papilio/Hippeastrum_papilio_nt97.fa.transdecoder.pep\
 --trinotate_data_dir /project/def-desgagne/trinotate_data\
 --run 'infernal'
