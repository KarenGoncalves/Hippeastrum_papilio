library(tidyverse)

system("sh scripts/create_busco_table.sh")

busco_stats = read_delim("table_busco_result") %>%
  filter(Category == "n_markers")

busco_stats %>%
  ggplot(aes(Value, 'Hippeastrum papilio', fill = Category)) +
  geom_col()
