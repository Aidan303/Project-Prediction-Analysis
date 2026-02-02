import Overall_Distribution_Per_Diff as od
import os


if __name__ == "__main__":
    # Base path to Simulation Results
    base_path = os.path.join(os.path.dirname(__file__), '../../Simulation Results')
    
    # Paste list of raw filepaths here
    paths = [
        os.path.join(base_path, 'Activities Lognormal', 'Set 1 SP Completion Times - Lognormal.csv'),
        os.path.join(base_path, 'Activities Lognormal', 'Set 2.1 AD (low SP) Completion Times - Lognormal.csv'),
        os.path.join(base_path, 'Activities Lognormal', 'Set 2.2 AD (mid SP) Completion Times - Lognormal.csv'),
        os.path.join(base_path, 'Activities Lognormal', 'Set 3.1 LA (low SP) Completion Times - Lognormal.csv'),
        os.path.join(base_path, 'Activities Lognormal', 'Set 3.2 LA (mid SP) Completion Times - Lognormal.csv'),
        os.path.join(base_path, 'Activities Lognormal', 'Set 3.3 LA (high SP) Completion Times - Lognormal.csv'),
        os.path.join(base_path, 'Activities Lognormal', 'Set 4.1 TF (low SP) Completion Times - Lognormal ln.csv'),
        os.path.join(base_path, 'Activities Lognormal', 'Set 4.2 TF (mid SP) Completion Times - Lognormal.csv'),
        os.path.join(base_path, 'Activities Lognormal', 'Set 4.3 TF (high SP) Completion Times - Lognormal.csv')
    ]

    result, _ = od.test_overall_distribution_average_percent_differences(paths)
    print("\n")
    print("\n")
    print("\n")
    print("\n----Overall Average Percent Difference for Each Estimation Method Using Lognormal Distribution----")
    for label, values in result.items():
        print(f"{label}: {values:.4f}%")