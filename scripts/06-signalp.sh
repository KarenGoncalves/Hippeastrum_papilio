#!/bin/sh
#SBATCH --account=def-desgagne
#SBATCH --job-name=signalP_Hipap
#SBATCH --time=1-00:00:00
#SBATCH --nodes=1
#SBATCH --output=/scratch/$USER/Hippeastrum_papilio/slurms/signalP-%j.out
#SBATCH --cpus-per-task=8
#SBATCH --mem=20G

THREADS=8

cd /scratch/$USER/Hippeastrum_papilio/results_annotation

ml StdEnv/2023 cuda scipy-stack/2023b
source ~/ENV2023/bin/activate

signalp6 --fastafile /scratch/$USER/Hippeastrum_papilio/Hippeastrum_papilio_nt97.fa.transdecoder.pep\
 --model_dir ~/ENV2023/lib/python3.11/site-packages/signalp/model_weights\
 --organism other\
 --output_dir ./\
 --format none\
 --write_procs ${THREADS}\
 --mode fast
