
# Ensure combined_df exists
total_rows <- 4100  # or nrow(combined_df)
columns_to_fill <- c("SP", "LA", "AD", "TF")

# Initialize columns
for (col in columns_to_fill) {
  combined_df[[col]] <- numeric(total_rows)
}

# Flexible helper function
fill_block <- function(col_name, start_row, end_row, values, block_size = 100) {
  n <- end_row - start_row + 1
  
  if (is.numeric(values) && length(values) == 1) {
    # numeric increment sequence
    combined_df[[col_name]][start_row:end_row] <<- rep(
      seq(values, values + (ceiling(n / block_size) - 1) * values, by = values),
      each = block_size,
      length.out = n
    )
  } else if (length(values) == n) {
    # vector of values (numeric or string)
    combined_df[[col_name]][start_row:end_row] <<- values
  } else {
    stop("Length of 'values' vector must match number of rows if providing custom values.")
  }
}

# Define block parameters per column
# You can mix numeric increment blocks and string-value blocks
block_params <- list(
  SP = list(
    list(start_row = 1, end_row = 900, start_value = 0.1, increment = 0.1),
    list(start_row = 901, end_row = 1300, start_value = 0.2, increment = 0),
    list(start_row = 1301, end_row = 1700, start_value = 0.5, increment = 0),
    list(start_row = 1701, end_row = 2100, start_value = 0.2, increment = 0),
    list(start_row = 2101, end_row = 2500, start_value = 0.5, increment = 0),
    list(start_row = 2501, end_row = 2900, start_value = 0.8, increment = 0),
    list(start_row = 2901, end_row = 3300, start_value = 0.2, increment = 0),
    list(start_row = 3301, end_row = 3700, start_value = 0.5, increment = 0),
    list(start_row = 3701, end_row = 4100, start_value = 0.8, increment = 0)
  ),
  LA = list(
    list(start_row = 1, end_row = 900, values = rep("Rand", 900)),
    list(start_row = 901, end_row = 1300, values = rep("Rand", 400)),
    list(start_row = 1301, end_row = 1700, values = rep("Rand", 400)),
    list(start_row = 1701, end_row = 2100, start_value = 0.2, increment = 0.2),
    list(start_row = 2101, end_row = 2500, start_value = 0.2, increment = 0.2),
    list(start_row = 2501, end_row = 2900, start_value = 0.2, increment = 0.2),
    list(start_row = 2901, end_row = 3300, values = rep("Rand", 400)),
    list(start_row = 3301, end_row = 3700, values = rep("Rand", 400)),
    list(start_row = 3701, end_row = 4100, values = rep("Rand", 400))
  ),
  AD = list(
    list(start_row = 1, end_row = 900, values = rep("Rand", 900)),
    list(start_row = 901, end_row = 1300, start_value = 0.2, increment = 0.2),
    list(start_row = 1301, end_row = 1700, start_value = 0.2, increment = 0.2),
    list(start_row = 1701, end_row = 2100, values = rep("Rand", 400)),
    list(start_row = 2101, end_row = 2500, values = rep("Rand", 400)),
    list(start_row = 2501, end_row = 2900, values = rep("Rand", 400)),
    list(start_row = 2901, end_row = 3300, values = rep("Rand", 400)),
    list(start_row = 3301, end_row = 3700, values = rep("Rand", 400)),
    list(start_row = 3701, end_row = 4100, values = rep("Rand", 400))
  ),
  TF = list(
    list(start_row = 1, end_row = 900, values = rep("Rand", 900)),
    list(start_row = 901, end_row = 1300, values = rep("Rand", 400)),
    list(start_row = 1301, end_row = 1700, values = rep("Rand", 400)),
    list(start_row = 1701, end_row = 2100, values = rep("Rand", 400)),
    list(start_row = 2101, end_row = 2500, values = rep("Rand", 400)),
    list(start_row = 2501, end_row = 2900, values = rep("Rand", 400)),
    list(start_row = 2901, end_row = 3300, start_value = 0.2, increment = 0.2),
    list(start_row = 3301, end_row = 3700, start_value = 0.2, increment = 0.2),
    list(start_row = 3701, end_row = 4100, start_value = 0.2, increment = 0.2)
  )
)

# Apply all blocks
for (col in columns_to_fill) {
  for (block in block_params[[col]]) {
    if (!is.null(block$values)) {
      # Assign string or vector
      fill_block(col, block$start_row, block$end_row, values = block$values)
    } else {
      # Numeric increment sequence
      fill_block(col, block$start_row, block$end_row, values = block$start_value, block_size = 100)
    }
  }
}

# Preview first and last rows
head(combined_df, 50)
tail(combined_df, 50)

# Save to CSV
write.csv(combined_df,
          "R Scripts/Simulation Results Copy/Activities Beta/combined_beta_data.csv",
          row.names = FALSE)