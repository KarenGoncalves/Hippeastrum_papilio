#!/bin/sh
#SBATCH --account=def-desgagne
#SBATCH --job-name=Hipap_kallisto
#SBATCH --time=3:00:00

#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=32G

#SBATCH --output=/scratch/Hippestrum_papilio/slurms/expression-%j.out

module load StdEnv/2020 gcc/9.3.0 trinity kallisto samtools r-bundle-bioconductor

SPECIES=Hippeastrum_papilio
NCPUS=${SLURM_CPUS_PER_TASK}
DIR=$SCRATCH/${SPECIES}
outDIR=$DIR/kallisto/

ASSEMBLY=${DIR}/${SPECIES}_nt97.fa
samples_file=$DIR/metadata/samples_file.txt
gtm=$DIR/${SPECIES}_gene_trans_map
mkdir $outDIR/
cd $outDIR/

$TRINITY_HOME/util/align_and_estimate_abundance.pl\
 --transcripts $ASSEMBLY\
 --est_method kallisto\
 --prep_reference\
 --gene_trans_map ${gtm}\
 --samples_file $samples_file\
 --seqType fq\
 --thread_count $NCPUS

ls */abundance.tsv > file.listing_quant_files.txt

$TRINITY_HOME/util/abundance_estimates_to_matrix.pl\
 --est_method kallisto\
 --gene_trans_map ${gtm}\
 --cross_sample_norm TMM\
 --quant_files file.listing_quant_files.txt\
 --name_sample_by_basedir
