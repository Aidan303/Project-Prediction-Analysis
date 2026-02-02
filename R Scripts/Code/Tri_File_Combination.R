# Load necessary library
library(dplyr)

# 1️⃣ Set the folder path
tri_folder_path <- "R Scripts/Simulation Results Copy/Activities Triangular"

# 2️⃣ Get all CSV files in the folder
tri_csv_files <- list.files(
  path = tri_folder_path,
  pattern = "\\.csv$",
  full.names = TRUE
)

# 3️⃣ Read each CSV and add a 'source_file' column
tri_df_list <- lapply(tri_csv_files, function(file) {
  df <- read.csv(file, stringsAsFactors = FALSE)
  df$source_file <- tools::file_path_sans_ext(basename(file))
  return(df)
})

# 4️⃣ Combine all data frames safely (fills missing columns with NA)
combined_df <- bind_rows(tri_df_list)

# 5️⃣ Write the combined data to CSV
write.csv(
  combined_df,
  file = "combined_tri_data.csv",
  row.names = FALSE
)

# ✅ Optional: print summary
cat("Combined", length(tri_df_list), "CSV files into 'combined_tri_data.csv'\n")
