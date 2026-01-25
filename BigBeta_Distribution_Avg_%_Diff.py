import Overall_Distribution_Per_Diff as od

if __name__ == "__main__":
    # Paste list of raw filepaths here
    paths = [
    r"C:\Users\aidan\Documents\Independent Study\course_files_export V1\Simulation Results\Activities Beta\Set 1 SP Completion Times - Beta.csv",
    r"C:\Users\aidan\Documents\Independent Study\course_files_export V1\Simulation Results\Activities Beta\Set 2.1 AD (low SP) Completion Times - Beta.csv",
    r"C:\Users\aidan\Documents\Independent Study\course_files_export V1\Simulation Results\Activities Beta\Set 2.2 AD (mid SP) Completion Times - Beta.csv",
    r"C:\Users\aidan\Documents\Independent Study\course_files_export V1\Simulation Results\Activities Beta\Set 3.1 LA (low SP) Completion Times - Beta.csv",
    r"C:\Users\aidan\Documents\Independent Study\course_files_export V1\Simulation Results\Activities Beta\Set 3.2 LA (mid SP) Completion Times - Beta.csv",
    r"C:\Users\aidan\Documents\Independent Study\course_files_export V1\Simulation Results\Activities Beta\Set 3.3 LA (high SP) Completion Times - Beta.csv",
    r"C:\Users\aidan\Documents\Independent Study\course_files_export V1\Simulation Results\Activities Beta\Set 4.1 TF (low SP) Completion Times - Beta.csv",
    r"C:\Users\aidan\Documents\Independent Study\course_files_export V1\Simulation Results\Activities Beta\Set 4.2 TF (mid SP) Completion Times - Beta.csv",
    r"C:\Users\aidan\Documents\Independent Study\course_files_export V1\Simulation Results\Activities Beta\Set 4.3 TF (high SP) Completion Times - Beta.csv"
    ]

    result, _ = od.test_overall_distribution_average_percent_differences(paths)
    print("\n")
    print("\n")
    print("\n")
    print("\n----Overall Average Percent Difference for Each Estimation Method Using BigBeta Distribution----")
    for label, values in result.items():
        print(f"{label}: {values:.4f}%")