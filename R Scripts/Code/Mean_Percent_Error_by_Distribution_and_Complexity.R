# Mean Percent Error analysis by distribution and complexity

suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(ggpattern)
})

#-----------------------------
# Helper functions
#-----------------------------

# Derive complexity level (Low / Mid / High) from source_file text
derive_complexity_from_source <- function(source_vec) {
  s <- tolower(as.character(source_vec))
  comp <- ifelse(grepl("low sp", s), "Low",
                 ifelse(grepl("mid sp", s), "Mid",
                        ifelse(grepl("high sp", s), "High", NA)))
  factor(comp, levels = c("Low", "Mid", "High"))
}

# Add Complexity column if possible
add_complexity_column <- function(df) {
  if ("source_file" %in% names(df)) {
    df$Complexity <- derive_complexity_from_source(df$source_file)
  } else {
    df$Complexity <- factor(NA, levels = c("Low", "Mid", "High"))
  }
  df
}

# Compute mean absolute percent error (MPE, %) by Complexity and Method
compute_mpe_by_complexity <- function(df, method_cols, sim_col = "Sim.Mean") {
  if (!sim_col %in% names(df)) {
    stop(paste("Reference column", sim_col, "not found in data."))
  }

  df <- add_complexity_column(df)

  # Keep only rows with defined complexity and valid reference
  df <- df[!is.na(df$Complexity) & !is.na(df[[sim_col]]) & df[[sim_col]] != 0, ]

  complexities <- c("Low", "Mid", "High")
  results <- data.frame(Complexity = character(0),
                        Method = character(0),
                        MPE = numeric(0),
                        stringsAsFactors = FALSE)

  for (m in method_cols) {
    if (!m %in% names(df)) {
      stop(paste("Method column", m, "not found in data."))
    }
    for (comp in complexities) {
      idx <- df$Complexity == comp & !is.na(df[[m]])
      if (!any(idx)) next
      mpe_val <- mean(abs((df[[m]][idx] - df[[sim_col]][idx]) / df[[sim_col]][idx]) * 100)
      results <- rbind(results,
                       data.frame(Complexity = comp,
                                  Method = m,
                                  MPE = mpe_val,
                                  stringsAsFactors = FALSE))
    }
  }

  results$Complexity <- factor(results$Complexity, levels = complexities)
  results
}

#-----------------------------
# Data loading and aggregation
#-----------------------------

base_path <- "R Scripts/Simulation Results Copy"
method_cols <- c("CPM", "PERT", "BB.2.Mean", "Lognormal.Mean")

# Beta
beta_path <- file.path(base_path, "Activities Beta", "combined_beta_data.csv")
beta_df <- read.csv(beta_path, stringsAsFactors = FALSE)
beta_results <- compute_mpe_by_complexity(beta_df, method_cols)
beta_results$Distribution <- "Beta"

# Lognormal
log_path <- file.path(base_path, "Activities Lognormal", "combined_log_data.csv")
log_df <- read.csv(log_path, stringsAsFactors = FALSE)
log_results <- compute_mpe_by_complexity(log_df, method_cols)
log_results$Distribution <- "Lognormal"

# Triangular
tri_path <- file.path(base_path, "Activities Triangular", "combined_tri_data.csv")
tri_df <- read.csv(tri_path, stringsAsFactors = FALSE)
tri_results <- compute_mpe_by_complexity(tri_df, method_cols)
tri_results$Distribution <- "Triangular"

# Combined numeric summary (optional to inspect in console)
all_results <- bind_rows(beta_results, log_results, tri_results)
cat("Mean Percent Error (%) by distribution, complexity, and method:\n")
print(all_results)

#-----------------------------
# Plotting
#-----------------------------

plot_mpe_dist_complexity <- function(result_df, dist_name) {
  # Ordered factors
  result_df$Complexity <- factor(result_df$Complexity,
                                 levels = c("Low", "Mid", "High"))
  result_df$Method <- factor(result_df$Method,
                             levels = c("CPM", "PERT", "BB.2.Mean", "Lognormal.Mean"))

  ggplot(result_df,
         aes(x = Complexity, y = MPE,
             pattern = Method,
             pattern_fill = Method)) +
    ggpattern::geom_bar_pattern(
      position = position_dodge(width = 0.8),
      width = 0.7,
      color = "black",
      fill = "white",          # bar base color (for B/W)
      pattern_color = "black", # pattern lines color
      pattern_density = 0.4,
      pattern_spacing = 0.04,
      stat = "identity"
    ) +
    scale_pattern_manual(values = c(
      "CPM" = "none",         # solid white with outline
      "PERT" = "stripe",
      "BB.2.Mean" = "crosshatch",
      "Lognormal.Mean" = "circle"
    )) +
    scale_x_discrete(drop = FALSE) +
    labs(
      title = paste("Mean Percent Error by Complexity -", dist_name, "Distribution"),
      x = "Complexity Level",
      y = "Mean Percent Error (%)",
      pattern = "Method"
    ) +
    theme_bw() +
    theme(
      plot.title = element_text(hjust = 0.5),
      panel.grid = element_blank()
    )
}

p_beta <- plot_mpe_dist_complexity(beta_results, "Beta")
p_log  <- plot_mpe_dist_complexity(log_results, "Lognormal")
p_tri  <- plot_mpe_dist_complexity(tri_results, "Triangular")

# Print bar plots to the active graphics device
print(p_beta)
print(p_log)
print(p_tri)

#-----------------------------
# Line plots: MPE vs complexity
#-----------------------------

plot_mpe_line_dist_complexity <- function(result_df, dist_name) {
  # Ordered factors
  result_df$Complexity <- factor(result_df$Complexity,
                                 levels = c("Low", "Mid", "High"))
  result_df$Method <- factor(result_df$Method,
                             levels = c("CPM", "PERT", "BB.2.Mean", "Lognormal.Mean"))

  ggplot(result_df,
         aes(x = Complexity, y = MPE,
             group = Method,
             linetype = Method,
             shape = Method)) +
    geom_line(color = "black", linewidth = 0.6) +
    geom_point(color = "black", linewidth = 2) +
    scale_linetype_manual(values = c(
      "CPM" = "solid",
      "PERT" = "dashed",
      "BB.2.Mean" = "dotted",
      "Lognormal.Mean" = "dotdash"
    )) +
    scale_shape_manual(values = c(
      "CPM" = 16,           # filled circle
      "PERT" = 17,          # filled triangle
      "BB.2.Mean" = 15,     # filled square
      "Lognormal.Mean" = 18 # diamond
    )) +
    scale_x_discrete(drop = FALSE) +
    labs(
      title = paste("Mean Percent Error vs Complexity -", dist_name, "Distribution"),
      x = "Complexity Level",
      y = "Mean Percent Error (%)",
      linetype = "Method",
      shape = "Method"
    ) +
    theme_bw() +
    theme(
      plot.title = element_text(hjust = 0.5),
      panel.grid = element_blank()
    )
}

p_beta_line <- plot_mpe_line_dist_complexity(beta_results, "Beta")
p_log_line  <- plot_mpe_line_dist_complexity(log_results, "Lognormal")
p_tri_line  <- plot_mpe_line_dist_complexity(tri_results, "Triangular")

# Print line plots to the active graphics device
print(p_beta_line)
print(p_log_line)
print(p_tri_line)
