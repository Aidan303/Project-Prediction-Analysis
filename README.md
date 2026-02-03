# Python and R Scripts for Distribution Analysis and Data Processing

## Overview

This project analyzes the accuracy of various project estimation methods (CPM, PERT, BB/2 Mean, Lognormal Mean) against simulated completion times for different probability distributions (Triangular, Lognormal, Beta). The analysis calculates average percent differences between estimated and simulated values across multiple datasets.

The project has evolved to include comprehensive data preparation, cleaning, and combination steps to standardize and unify the simulation results for robust analysis.

## Project Structure

### Folders

- **Python Code/**: Main Python scripts directory
  - **EDA/**: Exploratory Data Analysis scripts (e.g., Percent_Difference_Method.py, Complexity_Combined_Per_Diff.py)
  - **Data Vis/**: Data visualization scripts for creating charts and graphs
  - **File Combination/**: Data cleaning and combination scripts
- **R Scripts/**: R-based analysis and visualization scripts
  - **Code/**: R scripts for additional distribution analysis, data combination, and visualization
  - **Simulation Results Copy/**: Simulation results with combination of files and data complexity columns added in R(AD, SP, LA, TF)
- **Simulation Results copy/**: Version-controlled working copy of simulation data with modifications made by python scripts
  - **Activities Beta/**: Beta distribution simulation CSVs
  - **Activities Lognormal/**: Lognormal distribution simulation CSVs
  - **Activities Triangular/**: Triangular distribution simulation CSVs
  - **Combined Datasets/**: Combined CSVs with data from all distributions for project sets using python
- **Output/**: Output files and visualizations
  - **Graphics/**: Generated PNG visualization files
- **Complete_Exploratory_Data_Analysis_Summary.md**: Written report summarizing the full exploratory data analysis and key findings
- **Complete_Exploratory_Data_Analysis_Summary_99_Percentile.md**: Written report summarizing the 99% completion time (Sim 99%) analysis and tail-risk-focused findings
- **__pycache__/**: Python bytecode files

### Core Analysis Modules (EDA Folder)

- **Percent_Difference_Method.py**: Contains the `calculate_percent_differences(filepath)` function. This function reads a CSV file containing simulation results, compares estimation methods against the 'Sim Mean' reference column, and computes the average absolute percent difference for each method. It returns a dictionary of these differences.

- **Overall_Distribution_Per_Diff.py**: Contains the `test_overall_distribution_average_percent_differences(paths)` function. This function takes a list of file paths, calls `calculate_percent_differences` for each, accumulates the results, and returns the overall average differences across all files along with a list of individual file results.

- **Complexity_Combined_Per_Diff.py**: Analyzes percent differences across complexity levels. Processes combined datasets grouped by complexity (Set 1, Set 2.1, etc.) and generates a JSON file with results for visualization.

### Data Visualization Scripts (Data Vis Folder)

- **Percent_Error_Data_Vis_by_Distro.py**: Creates bar charts showing average percent differences by estimation method for each distribution (Triangular, Lognormal, Beta). Reads results from combined_output.txt and generates side-by-side plots.

- **Percent_Error_Data_Vis_by_Complexity.py**: Creates a bar chart visualizing percent differences across complexity levels. Reads from Complexity_Combined_Per_Diff.json to show how estimation accuracy varies with project complexity.

### Distribution-Specific Analysis Scripts (EDA Folder in Python Code)

- **Triangular_Distribution_Avg_%_Diff.py**: Runs the analysis for Triangular distribution datasets. It defines a list of CSV file paths for Triangular simulation results and computes the overall average percent differences for this distribution.

- **Lognormal_Distribution_Avg_%_Diff.py**: Runs the analysis for Lognormal distribution datasets. It defines a list of CSV file paths for Lognormal simulation results and computes the overall average percent differences for this distribution.

- **BigBeta_Distribution_Avg_%_Diff.py**: Runs the analysis for Beta (BigBeta) distribution datasets. It defines a list of CSV file paths for Beta simulation results and computes the overall average percent differences for this distribution.

### Data Preparation and Combination Scripts (File Combination Folder in Python Code)

- **Data Cleaning.py**: Handles data standardization and cleaning. Identifies CSV files with missing columns, adds missing columns with data from corresponding files, and ensures all files have consistent 28 columns.

- **read_csv_columns.py**: Generates a JSON file (`column_names_copy.json`) listing column names for all CSV files, used for validation and processing.

- **dataset_combination.py**: Combines corresponding CSV files from the three distribution folders into unified datasets. Each combined file stacks data from Beta, Lognormal, and Triangular distributions, adds a "Distribution" column, and includes dummy variables (Is_Beta, Is_Lognormal, Is_Triangular) for modeling.

### Utility Scripts (Python Code Folder)

- **Individual_File_Stats_Calculator.py**: A standalone script that prompts the user for a single file path and calculates the percent differences for that file using the `Percent_Difference_Method` module. Useful for quick analysis of individual datasets.

- **Combined_Run.py**: A comprehensive script that runs the analysis for all three distributions (Triangular, Lognormal, BigBeta) in sequence. It prints summaries to the console and writes detailed results (overall dictionaries and individual file dictionaries) to `combined_output.txt`.

### Jupyter Notebooks

- **Jupyter_Test_Env.ipynb**: A notebook for testing and prototyping code snippets, data analysis workflows, and visualizations. Useful for interactive exploration and debugging.

## R Script Integration

The R scripts in "R Scripts/Code/" provide parallel and extended analyses of the combined datasets, including additional distribution-specific summaries and visualizations. They operate on the same standardized and combined CSV files created by the Python pipeline, enabling cross-validation of results and alternative visualization approaches. Alternate visuals in the R Scripts folder are made using ggplot2 and are black and white publisher friendly.

## Data Processing Workflow

1. **Data Standardization**: `Data Cleaning.py` ensures all CSV files have consistent columns by adding missing data from corresponding files.

2. **Column Validation**: `read_csv_columns.py` scans all files and generates a JSON summary of column structures.

3. **Dataset Combination**: `dataset_combination.py` creates combined CSV files in "Simulation Results copy/Combined Datasets/", stacking data from all distributions with identification columns.

4. **Analysis**: Original EDA scripts process the combined or individual datasets to compute percent differences.

5. **Complexity Analysis**: `Complexity_Combined_Per_Diff.py` analyzes results across complexity levels and saves to JSON.

6. **Visualization**: Data visualization scripts create charts and graphs from analysis results, saved as PNG files in the Graphics folder.

## Output Files

- **combined_output.txt**: Generated by `Combined_Run.py`, contains complete output data including overall result dictionaries for each distribution and all individual file dictionaries.

- **Complexity_Combined_Per_Diff.json**: JSON file containing percent difference results aggregated by complexity levels, used for visualization.

- **column_names_copy.json**: JSON file listing column names for all processed CSV files.

- **Graphics/**: Folder containing generated visualization files:
  - **Percent_Difference_Data_Vis_by_Complexity.png**: Bar chart showing percent differences across complexity levels.
  - **Percent_Difference_Data_Vis_by_Distribution.png**: Side-by-side bar charts comparing estimation methods across distributions.
  - **99_Python_Visualizations/Percent_Difference_by_Distribution_99.png**: Bar charts showing 99% (Sim 99%) percent differences by estimation method for each distribution.
  - **99_Python_Visualizations/Method_Accuracy_by_Dataset_Complexity_99.png**: Bar and line plots showing 99% (Sim 99%) percent error by method across Low, Mid, and High complexity for each distribution.

- **Simulation Results copy/Combined Datasets/**: Folder containing 9 combined CSV files (e.g., "Set 1 SP Completion Times - Combined.csv"), each with ~1200-2700 rows from all distributions, plus dummy variables.

## How It Works

1. **Data Input**: Analysis starts with standardized CSV files containing simulation results. Files have columns for estimation methods (CPM, PERT, etc.) and a 'Sim Mean' reference.

2. **Data Cleaning**: Missing columns are populated, and files are standardized to 28 columns.

3. **Combination**: Corresponding files from different distributions are stacked into combined datasets with distribution identifiers.

4. **Percent Difference Calculation**: For each file/dataset, absolute percent differences between estimation methods and simulated mean are calculated and averaged.

5. **Aggregation**: Results are aggregated across files and distributions for overall comparisons.

6. **Output**: Results are printed to console and saved to files in human-readable and structured formats.

Scripts use pandas for data manipulation and require correct file paths.

## Results Overview

Running `Combined_Run.py` provides a comprehensive comparison across distributions:

- **Triangular Distribution**: CPM shows the highest error (15.98%), followed by PERT (8.98%). BB/2 Mean and Lognormal Mean perform similarly well (4.31% and 4.42%).

- **Lognormal Distribution**: Similar pattern with CPM at 13.49%, PERT at 6.28%, and BB/2 Mean and Lognormal Mean at 1.56% and 1.59% respectively.

- **BigBeta (Beta) Distribution**: CPM at 9.11%, PERT performs best at 1.54%, with BB/2 Mean and Lognormal Mean at 3.94% and 3.85%.

Overall, PERT and Lognormal Mean tend to provide the most accurate estimates across distributions, while CPM consistently shows the highest percent differences. The Beta distribution yields the lowest errors for most methods, suggesting better estimation performance for this distribution type.

## Usage

1. Ensure data is in "Simulation Results copy/" with subfolders.
2. Run data cleaning: `python "Python Code/File Combination/Data Cleaning.py"`
3. Generate column summary: `python "Python Code/File Combination/read_csv_columns.py"`
4. Combine datasets: `python "Python Code/File Combination/dataset_combination.py"`
5. Run analysis: `python "Python Code/Combined_Run.py"`
6. Run complexity analysis: `python "Python Code/EDA/Complexity_Combined_Per_Diff.py"`
7. Generate visualizations: 
  - `python "Python Code/Data Vis/Percent_Error_Data_Vis_by_Distro.py"`
  - `python "Python Code/Data Vis/Percent_Error_Data_Vis_by_Complexity.py"`

Combined datasets in "Simulation Results copy/Combined Datasets/" can be used for further EDA or modeling. Visualization files are saved in "Output/Graphics/".
