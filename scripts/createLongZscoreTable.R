source("scripts/FUNCTIONS.R") # loads packages too
runPCA=T

## Input files ##
Exp_table <- read_csv("Filtered_kallisto_TPM.csv") %>% 
    rename("gene_ID" = gene)
metadata <- read_delim("metadata/metadata.txt", 
                       col_names = c("replicateName", "tissue", rep(".", 3))) %>%
    filter(replicateName %in% names(Exp_table)) %>%
    select(replicateName, tissue) %>% 
    mutate(SampleName = tissue)


Baits <- read_delim("baits.txt", "\t")

## Long exp_table ##

Exp_table_long <- Exp_table %>% 
    pivot_longer(cols = !gene_ID, 
                 names_to = "replicateName", 
                 values_to = "tpm") %>% 
    mutate(logTPM = log10(tpm + 1)) 

Exp_table_log_wide <- Exp_table_long %>% 
    dplyr::select(gene_ID, replicateName, logTPM) %>% 
    pivot_wider(names_from = replicateName, 
                values_from = logTPM, 
                id_cols = gene_ID)

## PCA ##
if (runPCA){
    source("scripts/PCA_logTPM.R")
}

#### Gene co-expression analysis ####
# Average up the reps #
Exp_table_long_averaged_z <- Exp_table_long %>% 
    full_join(metadata, 
              by = "replicateName") %>% 
    group_by(gene_ID, SampleName, tissue) %>%
    summarise(mean.logTPM = mean(logTPM),
              mean.TPM = mean(tpm))  %>% 
    group_by(gene_ID) %>% 
    mutate(z.score.TPM = zscore(mean.TPM),
           z.score.logTPM = zscore(mean.logTPM)) %>% 
    ungroup() 

head(Exp_table_long_averaged_z)

# Write_Exp_table_long_z #

split_at <- 400000

if(nrow(Exp_table_long_averaged_z) < split_at) {
    Exp_table_long_averaged_z %>% 
        mutate(group = 0) %>%
        write_delim(file = "results/Exp_table_long_averaged_z_0.tsv",
                    quote = "none", append = F,
                    col_names = T, delim = "\t")
} else {
    Exp_table_long_averaged_z %>% 
        mutate(group = (row_number() - 1) %/% !! split_at) %>%
        group_split(group) %>%
        map(.f = ~{
            fileName = paste0("results/Exp_table_long_averaged_z_",
                              unique(.x$group), ".tsv")
            write_delim(.x, fileName,
                        quote = "none", append = F,
                        col_names = T, delim = "\t")
        }) 
    
}
