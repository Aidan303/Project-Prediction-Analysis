import pandas as pd
import json
import os
import matplotlib.pyplot as plt

# Read the JSON file containing the complexity combined percent differences into a DataFrame
df = pd.read_json(os.path.join(os.path.dirname(__file__), '../../Output/Complexity_Combined_Per_Diff.json'), orient='index')

# Plotting
df.plot.bar()
plt.xticks(rotation=25)
plt.show()