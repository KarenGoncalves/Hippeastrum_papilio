#!/bin/sh
#SBATCH --account=def-desgagne
#SBATCH --mem=5G
#SBATCH --time=3:00:00
#SBATCH --job-name=Hipap_TD
#SBATCH --output=/scratch/$USER/Hippeastrum_papilio/slurms/predict-%j.out

module restore annotation_modules
source ~/trinotateAnnotation/bin/activate

module load gcc/9.3.0 transdecoder

SPECIES=Hippeastrum_papilio
DIR=$SCRATCH/${SPECIES}
ASSEMBLY=$DIR/${SPECIES}_nt97.fa
pfam=$DIR/results_annotation/longest_orfs.pep_TrinotatePFAM.out
blastp=$DIR/results_annotation/longest_orfs.pep_blastp.out

TransDecoder.Predict\
 -t $ASSEMBLY\
 --output_dir $DIR\
 --retain_pfam_hits ${pfam}\
 --retain_blastp_hits ${blastp}\
 --single_best_only


DATA_DIR=/project/def-desgagne/trinotate_data
cp /project/def-desgagne/trinotate_data/Trinotate.sqlite $DIR/

$TRINOTATE_HOME/util/trinotateSeqLoader/TrinotateSeqLoader.pl\
 --sqlite $DIR/Trinotate.sqlite\
 --gene_trans_map $DIR/${SPECIES}_gene_trans_map\
 --transcript_fasta ${ASSEMBLY}\
 --transdecoder_pep ${ASSEMBLY}.transdecoder.pep\
 --bulk_load
