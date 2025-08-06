library(tidyverse)
library(devtools)
# devtools::install_github("dzhang32/ggtranscript")
library(ggtranscript)
# install.packages(c("rtracklayer", "cowplot"))
library(rtracklayer)
library(cowplot)

gtf <- import("D:/Work/Hpapilio_2025/trinity_genes.gtf") %>% # function from rtracklayer)
    as_tibble

genes = paste0("Hipap_TRINITY_",
               c("DN7708_c0", "DN88533_c1", "DN16473_c1"), # add the gene id's of interest
               "_g1"
)

rel_heights =
    (gtf %>%
    filter(gene_id %in% genes) %>%
    dplyr::select(gene_id, transcript_id) %>%
    unique %>%
    group_by(gene_id) %>%
    count %>%
    mutate(gene_id = factor(gene_id, levels=genes)) %>%
        arrange(gene_id))$n # this is for cowplot, to give space in the plot relative to the number of isoforms of each gene

isoform_lengths = 
    (gtf %>%
    filter(gene_id %in% genes) %>%
    group_by(gene_id, transcript_id) %>%
    summarize(Transcript_width = sum(width))
)

sapply(genes, simplify = F, \(x) {
    gtf %>%
        filter(gene_id %in% x) %>%
        mutate(transcript_id = gsub(paste0(x,"_"), "", transcript_id)) %>% 
        ggplot(aes(
            xstart = start,
            xend = end,
            y = transcript_id
        )) +
        xlab(x) + ylab("") +
        geom_range() +
        theme_classic() +
        theme(strip.text = element_blank())
}) %>% cowplot::plot_grid(plotlist = ., nrow = 3,
                           rel_heights = c(rel_heights[1:2], 2)
                          ) +
    scale_x_continuous(breaks = seq(0, 6500, by = 500))

