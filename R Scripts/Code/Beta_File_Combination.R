# Load necessary library
library(dplyr)

# 1️⃣ Set the folder path
beta_folder_path <- "R Scripts/Simulation Results Copy/Activities Beta"

# 2️⃣ Get all CSV files in the folder
beta_csv_files <- list.files(
  path = beta_folder_path,
  pattern = "\\.csv$",
  full.names = TRUE
)

# 3️⃣ Read each CSV and add a 'source_file' column
beta_df_list <- lapply(beta_csv_files, function(file) {
  df <- read.csv(file, stringsAsFactors = FALSE)
  df$source_file <- tools::file_path_sans_ext(basename(file))
  return(df)
})

# 4️⃣ Combine all data frames safely (fills missing columns with NA)
combined_df <- bind_rows(beta_df_list)

# 5️⃣ Write the combined data to CSV
write.csv(
  combined_df,
  file = "combined_beta_data.csv",
  row.names = FALSE
)

# ✅ Optional: print summary
cat("Combined", length(beta_df_list), "CSV files into 'combined_beta_data.csv'\n")
