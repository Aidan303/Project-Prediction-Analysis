# Mean Percent Error analysis for each distribution

# Load required packages
suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(ggpattern)
})

# Helper: compute mean percent error (absolute) for a set of columns vs a reference column
compute_mpe <- function(df, method_cols, sim_col = "Sim.Mean") {
  if (!sim_col %in% names(df)) {
    stop(paste("Reference column", sim_col, "not found in data."))
  }

  # Filter out rows with NA or zero in the reference column to avoid division issues
  df <- df[!is.na(df[[sim_col]]) & df[[sim_col]] != 0, ]

  sapply(method_cols, function(col) {
    if (!col %in% names(df)) {
      stop(paste("Method column", col, "not found in data."))
    }
    x <- df[[col]]
    valid <- !is.na(x)
    # Mean absolute percent error in %
    mean(abs((x[valid] - df[[sim_col]][valid]) / df[[sim_col]][valid]) * 100)
  })
}

# Base path to simulation results (relative to project root / working directory)
base_path <- "R Scripts/Simulation Results Copy"

# Columns of interest
method_cols <- c("CPM", "PERT", "BB.2.Mean", "Lognormal.Mean")

# 1) Beta distribution
beta_path <- file.path(base_path, "Activities Beta", "combined_beta_data.csv")
beta_df <- read.csv(beta_path, stringsAsFactors = FALSE)
beta_mpe <- compute_mpe(beta_df, method_cols)

beta_results <- data.frame(
  Distribution = "Beta",
  Method = names(beta_mpe),
  MPE = as.numeric(beta_mpe)
)

# 2) Lognormal distribution
log_path <- file.path(base_path, "Activities Lognormal", "combined_log_data.csv")
log_df <- read.csv(log_path, stringsAsFactors = FALSE)
log_mpe <- compute_mpe(log_df, method_cols)

log_results <- data.frame(
  Distribution = "Lognormal",
  Method = names(log_mpe),
  MPE = as.numeric(log_mpe)
)

# 3) Triangular distribution
tri_path <- file.path(base_path, "Activities Triangular", "combined_tri_data.csv")
tri_df <- read.csv(tri_path, stringsAsFactors = FALSE)
tri_mpe <- compute_mpe(tri_df, method_cols)

tri_results <- data.frame(
  Distribution = "Triangular",
  Method = names(tri_mpe),
  MPE = as.numeric(tri_mpe)
)

# Combine all results for convenient viewing if needed
all_results <- bind_rows(beta_results, log_results, tri_results)

print("Mean Percent Error (%) by method and distribution:")
print(all_results)

# Function to make a bar plot for a single distribution
plot_mpe_bar <- function(result_df, dist_name) {
  # Ensure the methods appear in the desired order on the x-axis
  result_df$Method <- factor(
    result_df$Method,
    levels = c("CPM", "PERT", "BB.2.Mean", "Lognormal.Mean")
  )

  ggplot(result_df, aes(x = Method, y = MPE,
                        pattern = Method,
                        pattern_fill = Method)) +
    ggpattern::geom_bar_pattern(
      color = "black",
      fill = "white",           # bar base color
      pattern_color = "black",  # pattern lines color
      pattern_density = 0.4,
      pattern_spacing = 0.04,
      stat = "identity"
    ) +
    scale_pattern_manual(values = c(
      "CPM" = "none",          # solid white with outline
      "PERT" = "stripe",
      "BB.2.Mean" = "crosshatch",
      "Lognormal.Mean" = "circle"
    )) +
    scale_x_discrete(
      labels = c(
        "CPM" = "CPM",
        "PERT" = "PERT",
        "BB.2.Mean" = "BB/2",
        "Lognormal.Mean" = "Lognormal"
      )
    ) +
    labs(
      title = paste("Mean Percent Error -", dist_name, "Distribution"),
      x = "Method",
      y = "Mean Percent Error (%)"
    ) +
    theme_bw() +
    theme(
      plot.title = element_text(hjust = 0.5),
      legend.position = "none",
      panel.grid = element_blank()
    )
}

# Generate three separate bar plots
p_beta <- plot_mpe_bar(beta_results, "Beta")
p_log <- plot_mpe_bar(log_results, "Lognormal")
p_tri <- plot_mpe_bar(tri_results, "Triangular")

# Print plots to the active graphics device
print(p_beta)
print(p_log)
print(p_tri)
