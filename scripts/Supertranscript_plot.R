library(tidyverse)
# devtools::install_github("dzhang32/ggtranscript")
library(ggtranscript)
library(rtracklayer)
library(cowplot)

gtf <- rtracklayer::import("D:/Work/Hpapilio_2025/trinity_genes.gtf") %>% 
    as_tibble

genes = paste0("Hipap_TRINITY_",
               c("DN7708_c0", "DN88533_c1", "DN16473_c1"),
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
        arrange(gene_id))$n

# isoform_lengths = 
        

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

