import json
import pandas as pd
import os

# Load the dictionary from the JSON file
json_path = os.path.join(os.path.dirname(__file__), 'column_names_copy.json')
with open(json_path, 'r') as f:
    column_dict = json.load(f)

# Find the maximum length of the lists
max_length = max(len(columns) for columns in column_dict.values())

# Print the keys where the length of the value is less than the maximum length
print(f"Maximum length of column lists: {max_length}")
print("Keys with column lists shorter than the maximum:")
shorter_keys = []
for key, columns in column_dict.items():
    if len(columns) < max_length:
        print(key)
        shorter_keys.append(key)

# Get the full set of columns from a file with max length
full_columns = None
for key, cols in column_dict.items():
    if len(cols) == max_length:
        full_columns = cols
        break

# For each shorter file, add the missing columns
for key in shorter_keys:
    missing_cols = [col for col in full_columns if col not in column_dict[key]]
    print(f"Adding missing columns to {key}: {missing_cols}")
    # Read the CSV
    df = pd.read_csv(key)
    # Add missing columns with empty values
    for col in missing_cols:
        df[col] = pd.NA
    # Reorder columns to match the full set
    df = df[full_columns]
    print(f"Updated {key}")

# Now, populate the empty columns in Triangular files with data from corresponding Beta files
triangular_files = [key for key in column_dict.keys() if 'Triangular' in key]
columns_to_populate = ['Number of Paths', 'Average Nodes/Path']

for triangular_file in triangular_files:
    # Construct the corresponding Beta file path
    beta_file = triangular_file.replace('Triangular', 'Beta')
    print(f"Populating {triangular_file} with data from {beta_file}")
    
    # Read the Beta CSV
    beta_df = pd.read_csv(beta_file)
    # Read the Triangular CSV
    triangular_df = pd.read_csv(triangular_file)
    
    # Copy the values for the specified columns
    for col in columns_to_populate:
        triangular_df[col] = beta_df[col]
    
    # Save the updated Triangular CSV
    triangular_df.to_csv(triangular_file, index=False)
    print(f"Updated {triangular_file} with data from {beta_file}")
