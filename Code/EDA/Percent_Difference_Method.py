import pandas as pd

def calculate_percent_differences(filepath):
    # Read csv file into dataframe
    df = pd.read_csv(filepath)

    # Determine reference column to compare method against
    reference_column = 'Sim Mean'

    # Determine what columns are targets for comparison
    target_columns = {
        "CPM":"CPM",
        "PERT":"PERT",
        "BB/2 Mean":"BB/2 Mean",
        "Lognormal Mean":"Lognormal Mean"
    }


    dict_diffs = {
        "CPM": 0,
        "PERT": 0,
        "BB/2 Mean": 0,
        "Lognormal Mean": 0
    }

    # Find average percent difference for each method result from the simulated result
    for label, column_name in target_columns.items():
        percent_diffs = (((df[column_name]-df[reference_column]).abs())/df[reference_column]) * 100

        avg_diffs = percent_diffs.mean()
        dict_diffs[label] = avg_diffs

    return dict_diffs

