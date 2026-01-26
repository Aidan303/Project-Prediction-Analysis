import Overall_Distribution_Per_Diff as od
import json
import os

def run_distribution(name, paths, output_file):
    print(f"\n\n----Running {name} Distribution----")
    with open(output_file, 'a') as f:
        f.write(f"\n\n----{name} Distribution----\n")

    overall_result, individual_results = od.test_overall_distribution_average_percent_differences(paths)

    print(f"\n----Overall Average Percent Difference for Each Estimation Method Using {name} Distribution----")
    for label, values in overall_result.items():
        print(f"{label}: {values:.4f}%")

    with open(output_file, 'a') as f:
        f.write(f"\n----Overall Average Percent Difference for Each Estimation Method Using {name} Distribution----\n")
        for label, values in overall_result.items():
            f.write(f"{label}: {values:.4f}%\n")

    # Write overall result dict
    with open(output_file, 'a') as f:
        f.write(f"\n{name} Overall Result Dictionary:\n")
        json.dump(overall_result, f, indent=4)
        f.write("\n")

    # Write individual dict_diffs
    with open(output_file, 'a') as f:
        f.write(f"\n{name} Individual dict_diff Dictionaries:\n")
        for i, ind_result in enumerate(individual_results):
            f.write(f"\nFile {i+1}: {paths[i]}\n")
            json.dump(ind_result, f, indent=4)
            f.write("\n")

if __name__ == "__main__":
    output_file = "../../Ouput/combined_output.txt"

    # Clear the output file
    with open(output_file, 'w') as f:
        f.write("Combined Output for All Distributions\n")

    # Base path to Simulation Results
    base_path = os.path.join(os.path.dirname(__file__), '../../Simulation Results')

    # Triangular paths
    triangular_paths = [
        os.path.join(base_path, 'Activities Triangular', 'Set 1 SP Completion Times - Triangular.csv'),
        os.path.join(base_path, 'Activities Triangular', 'Set 2.1 AD (low SP) Completion Times - Triangular.csv'),
        os.path.join(base_path, 'Activities Triangular', 'Set 2.2 AD (mid SP) Completion Times - Triangular.csv'),
        os.path.join(base_path, 'Activities Triangular', 'Set 3.1 LA (low SP) Completion Times - Triangular.csv'),
        os.path.join(base_path, 'Activities Triangular', 'Set 3.2 LA (mid SP) Completion Times - Triangular.csv'),
        os.path.join(base_path, 'Activities Triangular', 'Set 3.3 LA (high SP) Completion Times - Triangular.csv'),
        os.path.join(base_path, 'Activities Triangular', 'Set 4.1 TF (low SP) Completion Times - Triangular.csv'),
        os.path.join(base_path, 'Activities Triangular', 'Set 4.2 TF (mid SP) Completion Times - Triangular.csv'),
        os.path.join(base_path, 'Activities Triangular', 'Set 4.3 TF (high SP) Completion Times - Triangular.csv')
    ]

    run_distribution("Triangular", triangular_paths, output_file)

    # Lognormal paths
    lognormal_paths = [
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

    run_distribution("Lognormal", lognormal_paths, output_file)

    # BigBeta paths
    bigbeta_paths = [
        os.path.join(base_path, 'Activities Beta', 'Set 1 SP Completion Times - Beta.csv'),
        os.path.join(base_path, 'Activities Beta', 'Set 2.1 AD (low SP) Completion Times - Beta.csv'),
        os.path.join(base_path, 'Activities Beta', 'Set 2.2 AD (mid SP) Completion Times - Beta.csv'),
        os.path.join(base_path, 'Activities Beta', 'Set 3.1 LA (low SP) Completion Times - Beta.csv'),
        os.path.join(base_path, 'Activities Beta', 'Set 3.2 LA (mid SP) Completion Times - Beta.csv'),
        os.path.join(base_path, 'Activities Beta', 'Set 3.3 LA (high SP) Completion Times - Beta.csv'),
        os.path.join(base_path, 'Activities Beta', 'Set 4.1 TF (low SP) Completion Times - Beta.csv'),
        os.path.join(base_path, 'Activities Beta', 'Set 4.2 TF (mid SP) Completion Times - Beta.csv'),
        os.path.join(base_path, 'Activities Beta', 'Set 4.3 TF (high SP) Completion Times - Beta.csv')
    ]

    run_distribution("BigBeta", bigbeta_paths, output_file)

    print(f"\nAll output written to {output_file}")