import Percent_Difference_Method as pdm
import pandas as pd
import os

#Establish paths
base_path =os.path.join(os.path.dirname(__file__), '../../Simulation Results copy')
output_path = os.path.join(os.path.dirname(__file__), '../../Output')

paths = [
    os.path.join(base_path, 'Combined Datasets', 'Set 1 SP Completion Times - Combined.csv'),
    os.path.join(base_path, 'Combined Datasets', 'Set 2.1 AD (low SP) Completion Times - Combined.csv'),
    os.path.join(base_path, 'Combined Datasets', 'Set 2.2 AD (mid SP) Completion Times - Combined.csv'),
    os.path.join(base_path, 'Combined Datasets', 'Set 3.1 LA (low SP) Completion Times - Combined.csv'),
    os.path.join(base_path, 'Combined Datasets', 'Set 3.2 LA (mid SP) Completion Times - Combined.csv'),
    os.path.join(base_path, 'Combined Datasets', 'Set 3.3 LA (high SP) Completion Times - Combined.csv'),
    os.path.join(base_path, 'Combined Datasets', 'Set 4.1 TF (low SP) Completion Times - Combined.csv'),
    os.path.join(base_path, 'Combined Datasets', 'Set 4.2 TF (mid SP) Completion Times - Combined.csv'),
    os.path.join(base_path, 'Combined Datasets', 'Set 4.3 TF (high SP) Completion Times - Combined.csv')
]
results_dicts = []

#Calculate percent differences for each file and store results
for path in paths:
    result = pdm.calculate_percent_differences(path)
    results_dicts.append(result)


#Save results to JSON
df = pd.DataFrame(results_dicts, index=[os.path.basename(path).replace(' Completion Times - Combined.csv', '') for path in paths])
df.to_json(os.path.join(output_path, 'Complexity_Combined_Per_Diff.json'),orient='index', indent=4)