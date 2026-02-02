import os
import pandas as pd

# Base path to Simulation Results copy
base_path = './Simulation Results copy'

# Subfolders and distributions
subfolders = ['Activities Beta', 'Activities Lognormal', 'Activities Triangular']
distributions = ['Beta', 'Lognormal', 'Triangular']

# Output folder
output_folder = os.path.join(base_path, 'Combined Datasets')

# Get unique base names from one subfolder (e.g., Beta)
beta_folder = os.path.join(base_path, 'Activities Beta')
base_names = set()
for file in os.listdir(beta_folder):
    if file.endswith('.csv') and 'Fixed' not in file:
        # Remove ' - Beta.csv' to get base
        base = file.replace(' - Beta.csv', '')
        base_names.add(base)

# For each base name, combine the three corresponding files
for base in sorted(base_names):
    dfs = []
    for subfolder, dist in zip(subfolders, distributions):
        file_path = os.path.join(base_path, subfolder, f'{base} - {dist}.csv')
        if os.path.exists(file_path):
            df = pd.read_csv(file_path)
            df['Distribution'] = dist
            dfs.append(df)
        else:
            print(f"Warning: {file_path} not found")
    
    if dfs:
        # Concatenate
        combined_df = pd.concat(dfs, ignore_index=True)
        # Add dummy variables for distributions
        combined_df['Is_Beta'] = (combined_df['Distribution'] == 'Beta').astype(int)
        combined_df['Is_Lognormal'] = (combined_df['Distribution'] == 'Lognormal').astype(int)
        combined_df['Is_Triangular'] = (combined_df['Distribution'] == 'Triangular').astype(int)
        # Save to Combined Datasets
        output_file = os.path.join(output_folder, f'{base} - Combined.csv')
        combined_df.to_csv(output_file, index=False)
        print(f"Combined {base} into {output_file} with {len(combined_df)} rows")
    else:
        print(f"No files found for {base}")

print("Dataset combination complete.")