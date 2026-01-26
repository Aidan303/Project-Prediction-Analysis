import Percent_Difference_Method as pdm

def test_overall_distribution_average_percent_differences(paths):

    dict_values = {
        "CPM": 0,
        "PERT": 0,
        "BB/2 Mean": 0,
        "Lognormal Mean": 0
    }

    individual_results = []

    for path in paths:
        result = pdm.calculate_percent_differences(path)
        individual_results.append(result)

        for label, values in dict_values.items():
            dict_values[label] += result[label]

    for label, values in dict_values.items():
        dict_values[label] = dict_values[label] / len(paths)

    return dict_values, individual_results