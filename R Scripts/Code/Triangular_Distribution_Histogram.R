# Histogram of Triangular distribution Sim.Mean values using ggplot2 and ggpattern

suppressPackageStartupMessages({
  library(ggplot2)
  library(ggpattern)
  library(dplyr)
})

# This script assumes log_df is already loaded in the environment
# and contains a numeric column named "Sim.Mean" (reference mean).

#-----------------------------
# Configuration: column to plot
#-----------------------------

value_col <- "Sim.Mean"  # column whose distribution we want to plot

if (!exists("log_df")) {
  stop("log_df is not found in the current R environment. Load it before running this script.")
}

if (!value_col %in% names(log_df)) {
  stop(paste("Column", value_col, "not found in log_df. Please update value_col in this script."))
}

# Keep only non-missing values
plot_data <- log_df %>%
  filter(!is.na(.data[[value_col]]))

#-----------------------------
# Histogram with ggplot2 + ggpattern
#-----------------------------

p_tri_hist <- ggplot(plot_data, aes(x = .data[[value_col]])) +
  ggpattern::geom_histogram_pattern(
    aes(
      pattern = "triangular",
      pattern_fill = "Distribution"
    ),
    bins = 30,
    color = "black",
    fill = "white",          # base fill for B/W
    pattern_color = "black",
    pattern_density = 0.4,
    pattern_spacing = 0.04,
    boundary = 0
  ) +
  scale_pattern_manual(values = c("triangular" = "stripe")) +
  labs(
    title = "Histogram of Log Distribution Sim.Mean Values",
    x = value_col,
    y = "Count",
    pattern = "Pattern"
  ) +
  theme_bw() +
  theme(
    plot.title = element_text(hjust = 0.5),
    panel.grid = element_blank()
  )

print(p_tri_hist)
