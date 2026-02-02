# Load necessary library
library(dplyr)

# 1️⃣ Set the folder path
log_folder_path <- "R Scripts/Simulation Results Copy/Activities Lognormal"

# 2️⃣ Get all CSV files in the folder
log_csv_files <- list.files(
  path = log_folder_path,
  pattern = "\\.csv$",
  full.names = TRUE
)

# 3️⃣ Read each CSV and add a 'source_file' column
log_df_list <- lapply(log_csv_files, function(file) {
  df <- read.csv(file, stringsAsFactors = FALSE)
  df$source_file <- tools::file_path_sans_ext(basename(file))
  return(df)
})

# 4️⃣ Combine all data frames safely (fills missing columns with NA)
combined_df <- bind_rows(log_df_list)

# 5️⃣ Write the combined data to CSV
write.csv(
  combined_df,
  file = "combined_log_data.csv",
  row.names = FALSE
)

# ✅ Optional: print summary
cat("Combined", length(log_df_list), "CSV files into 'combined_log_data.csv'\n")
