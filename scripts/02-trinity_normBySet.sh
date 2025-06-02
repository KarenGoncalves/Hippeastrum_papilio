#!/bin/bash
#SBATCH --account=def-desgagne
#SBATCH --job-name=trinityBySet_Hipap
#SBATCH --output=/scratch/sajjad71/Hippeastrum_papilio/slurms/Trinity_%j.out
#SBATCH --mem=300G
#SBATCH --time=3-00:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=20

################### Replace karencgs, FOLDER and SPECIES with the correct names/paths ###################
ACRONYM=Hipap_
SPECIES=Hippeastrum_papilio

############### samples_file.txt is a file with 4 columns:
#### sample_name replicate_name /FULL/PATH/TO/READ_1.fastq.gz /FULL/PATH/TO/READ_2.fastq.gz
#### 1 line per replicate
#module load StdEnv/2020 gcc/9.3.0 expat/2.2.9 perl/5.30.2\
# metaeuk/6 r/4.3.1 boost/1.72.0 gsl/2.6 flexiblas/3.0.4\
# suitesparse/5.7.1 samtools/1.17 jellyfish\
# libffi/3.3 python/3.10.2 scipy-stack java/13.0.2 bowtie2/2.4.1\
# salmon/1.4 trinity/2.14.0
#
#module save trinity_modules

module restore trinity_modules
source ~/trinotateAnnotation/bin/activate
inDIR=$SCRATCH/${SPECIES}
source $inDIR/scripts/format_fasta.sh

Trinity --seqType fq --max_memory 300G\
 --output $SLURM_TMPDIR/Trinity\
 --CPU $SLURM_CPUS_PER_TASK\
 --samples_file $inDIR/metadata/samples_file.txt\
 --normalize_by_read_set --full_cleanup

# run CDHIT if trinity worked
if [[ -e $SLURM_TMPDIR/Trinity.Trinity.fasta.gene_trans_map ]]; then

        sed -E "s/>(TRINITY)/>${ACRONYM}\1/g"\
         $SLURM_TMPDIR/Trinity.Trinity.fasta >\
         $inDIR/og_transcriptome.fa

        sed -E "s/(TRINITY)/${ACRONYM}\1/g"\
         $SLURM_TMPDIR/Trinity.Trinity.fasta.gene_trans_map >\
         $inDIR/og_gene_trans_map

        ml StdEnv/2020 cd-hit

        cd-hit-est\
         -i $inDIR/og_transcriptome.fa\
         -o $inDIR/tmp.fa\
         -c 0.97 -l 200\
         -T 0 -M 4000M
        # -c is the similarity threshold
        # -l is the minimum length threshold
        # -T threads; -M memory in megabytes

        # Create new gene_trans_map

        grep ">" $inDIR/tmp.fa |\
         sed -E "s/>([A-Za-z0-9\._\-]+)(_seq|i[0-9]+)*( .+)*/\1\t\1\2/" >\
         $inDIR/${SPECIES}_gene_trans_map

	format_fasta $inDIR/tmp.fa $inDIR/${SPECIES}_nt97.fa
else
        echo "Trinity failed"
fi
