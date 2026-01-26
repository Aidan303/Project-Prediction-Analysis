import os
import pandas as pd
import json

# Path to the Simulation Results folder
simulation_results_path = os.path.join(os.path.dirname(__file__), '../../Simulation Results copy')

# Dictionary to store the results
column_dict = {}

# Walk through the directory
for root, dirs, files in os.walk(simulation_results_path):
    for file in files:
        if file.endswith('.csv') and file != 'Set 1 Completion Times Fixed.csv':
            filepath = os.path.join(root, file)
            # Read the CSV file to get column names
            df = pd.read_csv(filepath)
            columns = df.columns.tolist()
            # Store in dictionary
            column_dict[filepath] = columns

# Save the results to a JSON file
json_path = os.path.join(os.path.dirname(__file__), 'column_names_copy.json')
with open(json_path, 'w') as f:
    json.dump(column_dict, f, indent=4)

print("Results saved to column_names_copy.json")