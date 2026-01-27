import pandas as pd
import os
import json
import matplotlib.pyplot as plt

base_path = os.path.join(os.path.dirname(__file__), '../../Ouput')

output_data = open(os.path.join(base_path, 'combined_output.txt'), 'r').read()

# Extract overall result dictionaries
def extract_overall_dict(content, dist_name):
    start_marker = f"{dist_name} Overall Result Dictionary:\n"
    start = content.find(start_marker)
    if start == -1:
        return None
    start += len(start_marker)
    end_marker = f"\n\n{dist_name} Individual dict_diff Dictionaries:"
    end = content.find(end_marker, start)
    if end == -1:
        return None
    json_str = content[start:end].strip()
    return json.loads(json_str)

triangular_results = extract_overall_dict(output_data, "Triangular")
lognormal_results = extract_overall_dict(output_data, "Lognormal")
bigbeta_results = extract_overall_dict(output_data, "BigBeta")

# Plot the results
tri_df = pd.DataFrame.from_dict(triangular_results, orient='index', columns=['Triangular_Avg_Percent_Diff'])
logn_df = pd.DataFrame.from_dict(lognormal_results, orient='index', columns=['Lognormal_Avg_Percent_Diff'])
bigb_df = pd.DataFrame.from_dict(bigbeta_results, orient='index', columns=['BigBeta_Avg_Percent_Diff'])


fig, axes = plt.subplots(1, 3, figsize=(15, 5))

tri_df.plot(kind='bar', ax=axes[0], title='Avg % Diff by Method for Triangular', ylabel='Average Percent Difference (%)', xlabel='Estimation Method')
axes[0].tick_params(axis='x', rotation=0)

logn_df.plot(kind='bar', ax=axes[1], title='Avg % Diff by Method for Lognormal', ylabel='Average Percent Difference (%)', xlabel='Estimation Method')
axes[1].tick_params(axis='x', rotation=0)

bigb_df.plot(kind='bar', ax=axes[2], title='Avg % Diff by Method for BigBeta', ylabel='Average Percent Difference (%)', xlabel='Estimation Method')
axes[2].tick_params(axis='x', rotation=0)

plt.tight_layout()
plt.show()