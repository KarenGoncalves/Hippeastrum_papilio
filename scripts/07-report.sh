#!/bin/sh
#SBATCH --account=def-desgagne
#SBATCH --mem=8G
#SBATCH --time=3:00:00
#SBATCH --job-name=Hipap_report
#SBATCH --output=/scratch/$USER/Hippeastrum_papilio/slurms/trinotate-%j.out


SPECIES=Hippeastrum_papilio
DIR=$SCRATCH/${SPECIES}
results_d=$DIR/results_annotation
ASSEMBLY=$DIR/${SPECIES}_nt97.fa
db=$DIR/Trinotate.sqlite

module restore annotation_modules
source ~/trinotateAnnotation/bin/activate

Trinotate --db $db\
 --LOAD_swissprot_blastp $results_d/longest_orfs.pep_blastp.out\
 --LOAD_pfam $results_d/longest_orfs.pep_TrinotatePFAM.out\
 --LOAD_signalp $results_d/output.gff3\
 --LOAD_EggnogMapper $results_d/eggnog_mapper.emapper.annotations\
 --LOAD_tmhmmv2 $results_d/${SPECIES}_nt97.fa.transdecoder.pep_tmhmm.out\
 --LOAD_swissprot_blastx $results_d/${SPECIES}_nt97.fa_blastx.out\
 --LOAD_infernal $results_d/infernal.out

# Each line is too long if blastpNR is included
# because we kept all hits for each protein
#Trinotate --db $db\
# --LOAD_custom_blast $results_d/${SPECIES}_nt97.fa_blastpNR.out\
# --custom_db_name NR --blast_type blastp

Trinotate --db $db --report\
 --incl_pep --incl_trans > $DIR/${SPECIES}_trinotate4.tsv

echo $DIR/${SPECIES}_trinotate4.tsv is done
