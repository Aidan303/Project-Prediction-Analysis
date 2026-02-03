# Jupyter Notebook 99% Completion Time Analysis Summary (EDA)

This document summarizes the analyses performed in the notebook `Python Code/Jupyter_Test_Env.ipynb` **using the 99% completion time values**. All statistics and comparisons here are based on the estimated 99th percentile ("Sim 99%") of project completion times rather than the mean values used in the original exploratory data analysis summary.

---

## 1. Datasets and 99% Processing

The same simulated datasets used in the original analysis are reused here. They cover three underlying probability distributions for project completion times:

- Triangular
- Lognormal
- Beta

For each distribution, the notebook processes nine datasets representing different activity types and complexity levels (SP, AD, LA, TF and low/mid/high SP):

```text
Triangular datasets
- Set 1 SP Completion Times - Triangular.csv
- Set 2.1 AD (low SP) Completion Times - Triangular.csv
- Set 2.2 AD (mid SP) Completion Times - Triangular.csv
- Set 3.1 LA (low SP) Completion Times - Triangular.csv
- Set 3.2 LA (mid SP) Completion Times - Triangular.csv
- Set 3.3 LA (high SP) Completion Times - Triangular.csv
- Set 4.1 TF (low SP) Completion Times - Triangular.csv
- Set 4.2 TF (mid SP) Completion Times - Triangular.csv
- Set 4.3 TF (high SP) Completion Times - Triangular.csv

Lognormal datasets
- Set 1 SP Completion Times - Lognormal.csv
- Set 2.1 AD (low SP) Completion Times - Lognormal.csv
- Set 2.2 AD (mid SP) Completion Times - Lognormal.csv
- Set 3.1 LA (low SP) Completion Times - Lognormal.csv
- Set 3.2 LA (mid SP) Completion Times - Lognormal.csv
- Set 3.3 LA (high SP) Completion Times - Lognormal.csv
- Set 4.1 TF (low SP) Completion Times - Lognormal ln.csv
- Set 4.2 TF (mid SP) Completion Times - Lognormal.csv
- Set 4.3 TF (high SP) Completion Times - Lognormal.csv

Beta datasets
- Set 1 SP Completion Times - Beta.csv
- Set 2.1 AD (low SP) Completion Times - Beta.csv
- Set 2.2 AD (mid SP) Completion Times - Beta.csv
- Set 3.1 LA (low SP) Completion Times - Beta.csv
- Set 3.2 LA (mid SP) Completion Times - Beta.csv
- Set 3.3 LA (high SP) Completion Times - Beta.csv
- Set 4.1 TF (low SP) Completion Times - Beta.csv
- Set 4.2 TF (mid SP) Completion Times - Beta.csv
- Set 4.3 TF (high SP) Completion Times - Beta.csv
```

For each file, the notebook computes the **absolute percent difference between each estimation method's 99% completion time and the simulated 99% completion time (`Sim 99%`)**. Errors are then averaged across all files within a distribution and by complexity level (Low, Mid, High).

All results in this document therefore refer specifically to **tail-risk / high-confidence 99% completion time estimates**.

---

## 2. Method Performance Rankings at the 99% Level

This section summarizes the ranking of estimation methods by **mean absolute percent error** at the 99% completion time for each distribution and complexity level.

The methods compared here are the 99% variants of the three tail-focused estimators:

- PERT (99%)
- BB/2 (99%)
- Lognormal (99%)

Lower percent error indicates a more accurate 99% completion time estimate relative to `Sim 99%`.

### 2.1 Triangular Distribution (99% Level)

```text
Triangular Distribution - Method Rankings (Best → Worst):
--------------------------------------------------------------------------------

Low Complexity:
  1. Lognormal (99%)     :   2.03% error
  2. BB/2 (99%)          :   5.94% error
  3. PERT (99%)          :   6.21% error

Mid Complexity:
  1. PERT (99%)          :   2.93% error
  2. BB/2 (99%)          :   3.23% error
  3. Lognormal (99%)     :   7.82% error

High Complexity:
  1. PERT (99%)          :   6.74% error
  2. BB/2 (99%)          :   7.05% error
  3. Lognormal (99%)     :  11.82% error
```

**Interpretation (Triangular, 99% level)**

- At **low complexity**, Lognormal (99%) slightly outperforms PERT (99%) and BB/2 (99%), suggesting it best matches the simulated tail behavior.
- At **mid and high complexity**, PERT (99%) and BB/2 (99%) are clearly superior, with errors typically below 8%, while Lognormal (99%) remains competitive but somewhat less accurate at higher complexity.

### 2.2 Lognormal Distribution (99% Level)

```text
Lognormal Distribution - Method Rankings (Best → Worst):
--------------------------------------------------------------------------------

Low Complexity:
  1. Lognormal (99%)     :   2.25% error
  2. BB/2 (99%)          :   5.01% error
  3. PERT (99%)          :   5.29% error

Mid Complexity:
  1. PERT (99%)          :   5.85% error
  2. BB/2 (99%)          :   6.16% error
  3. Lognormal (99%)     :  10.89% error

High Complexity:
  1. PERT (99%)          :  10.07% error
  2. BB/2 (99%)          :  10.39% error
  3. Lognormal (99%)     :  15.31% error
```

**Interpretation (Lognormal, 99% level)**

 - For **low complexity** Lognormal datasets, Lognormal (99%) expectedly performs best, with very small error (~2.25%).
 - At **mid and high complexity**, PERT (99%) and BB/2 (99%) become the top performers, with errors between ~6–10%, while Lognormal (99%) becomes modestly less accurate.

### 2.3 Beta Distribution (99% Level)

```text
Beta Distribution - Method Rankings (Best → Worst):
--------------------------------------------------------------------------------

Low Complexity:
  1. PERT (99%)          :   4.48% error
  2. BB/2 (99%)          :   4.77% error
  3. Lognormal (99%)     :   9.39% error

Mid Complexity:
  1. PERT (99%)          :  13.39% error
  2. BB/2 (99%)          :  13.72% error
  3. Lognormal (99%)     :  18.79% error

High Complexity:
  1. PERT (99%)          :  17.05% error
  2. BB/2 (99%)          :  17.39% error
  3. Lognormal (99%)     :  22.62% error
```

**Interpretation (Beta, 99% level)**

- For the **Beta distribution**, PERT (99%) consistently ranks first, closely followed by BB/2 (99%).
- Lognormal (99%) is noticeably less accurate, especially at low and mid complexity.
- Percent errors at the 99% level are generally **larger than the mean-based errors** from the original EDA, reflecting the increased challenge of accurately estimating extreme tail completion times.

---

## 3. Mean 99% Completion Times by Distribution and Complexity

In addition to percent errors, the notebook reports the **actual mean 99% completion times (in days)** for each method compared to the simulated 99% completion time (`Sim 99%`). This provides an intuitive measure of schedule conservatism or optimism at the 99% level.

### 3.1 Triangular Distribution – Mean 99% Completion Times

```text
Triangular Distribution - Mean Completion Times (days):
--------------------------------------------------------------------------------

Low Complexity:
  Sim 99%             :    59.69
  PERT (99%)          :    56.04
  BB/2 (99%)          :    56.20
  Lognormal (99%)     :    58.71

Mid Complexity:
  Sim 99%             :   120.51
  PERT (99%)          :   124.07
  BB/2 (99%)          :   124.43
  Lognormal (99%)     :   129.97

High Complexity:
  Sim 99%             :   180.60
  PERT (99%)          :   192.82
  BB/2 (99%)          :   193.39
  Lognormal (99%)     :   202.00
```

**Key observations (Triangular, 99% level)**

- PERT (99%) and BB/2 (99%) slightly underestimate at low complexity but overshoot at mid and especially high complexity (about 12–13 days high).
- Lognormal (99%) is generally the most conservative, especially at high complexity, overshooting by more than 20 days.

### 3.2 Lognormal Distribution – Mean 99% Completion Times

```text
Lognormal Distribution - Mean Completion Times (days):
--------------------------------------------------------------------------------

Low Complexity:
  Sim 99%             :    59.07
  PERT (99%)          :    56.04
  BB/2 (99%)          :    56.20
  Lognormal (99%)     :    58.71

Mid Complexity:
  Sim 99%             :   117.17
  PERT (99%)          :   124.07
  BB/2 (99%)          :   124.43
  Lognormal (99%)     :   129.97

High Complexity:
  Sim 99%             :   175.13
  PERT (99%)          :   192.82
  BB/2 (99%)          :   193.39
  Lognormal (99%)     :   202.00
```

 **Key observations (Lognormal, 99% level)**

 - The pattern closely mirrors the Triangular case because the 99% estimates used here are aligned across the analysis.
 - PERT (99%) and BB/2 (99%) are near `Sim 99%` at low complexity and become increasingly conservative at higher complexity.
 - Lognormal (99%) is consistently the most conservative estimator at the 99% level.

### 3.3 Beta Distribution – Mean 99% Completion Times

```text
Beta Distribution - Mean Completion Times (days):
--------------------------------------------------------------------------------

Low Complexity:
  Sim 99%             :    53.61
  PERT (99%)          :    56.04
  BB/2 (99%)          :    56.20
  Lognormal (99%)     :    58.71

Mid Complexity:
  Sim 99%             :   109.38
  PERT (99%)          :   124.07
  BB/2 (99%)          :   124.43
  Lognormal (99%)     :   129.97

High Complexity:
  Sim 99%             :   164.69
  PERT (99%)          :   192.82
  BB/2 (99%)          :   193.39
  Lognormal (99%)     :   202.00
```

**Key observations (Beta, 99% level)**

- PERT (99%) and BB/2 (99%) are slightly conservative at low complexity and significantly conservative at mid and high complexity (up to ~28 days high).
- Lognormal (99%) is the most conservative method across all complexity levels, overshooting `Sim 99%` by ~5–37 days.

---

## 4. 99% Error by Complexity – Visualizations

The notebook generates visualizations to summarize how **mean percent error at the 99% level** varies by complexity and distribution.

1. **Method Accuracy by Dataset Complexity (99% Level)**
  - A grid of bar and line plots showing mean percent error for PERT (99%), BB/2 (99%), and Lognormal (99%) at Low, Mid, and High complexity for each distribution (Triangular, Lognormal, Beta).
   - This figure is saved as:

![Method Accuracy by Dataset Complexity (99%)](Output/Graphics/99_Python_Visualizations/Method_Accuracy_by_Dataset_Complexity_99.png)

  - In the plot, the legend explicitly labels PERT (99%), BB/2 (99%), and Lognormal (99%) to distinguish these tail-focused methods.

Overall, these visualizations confirm that the 99% versions of PERT, BB/2, and Lognormal yield substantially lower errors at the 99% level, especially at higher complexity levels.

---

## 5. Summary: Choosing Methods for 99% Completion Time Estimates

This analysis is specifically concerned with **high-confidence (99%) completion time estimates**, which are critical for risk-averse planning and contingency setting.

Key takeaways:

- **PERT (99%) and BB/2 (99%) are generally the best overall choices** for 99% estimates:
  - They achieve the lowest percent errors for most distributions and complexity levels.
  - They tend to be conservative (slightly overestimating schedule duration), which is often desirable when planning for worst-case scenarios.
- **Lognormal (99%)** is:
  - Very accurate for low-complexity Lognormal datasets (small percent error),
  - More conservative and somewhat less accurate at higher complexity, especially for non-Lognormal underlying distributions.
- **Beta distribution results** show that PERT (99%) is particularly strong for representing the 99% tail, with BB/2 (99%) a close second.

These conclusions complement the original mean-based EDA results by showing that, when focusing on **99% completion times (tail risk)**, PERT/BB/2/Lognormal continue to outperform other common approaches, but with:

- Larger absolute errors due to the difficulty of estimating extreme quantiles.
- Increased conservatism from the 99%-focused methods, which may be beneficial when setting contingency buffers or high-confidence project completion commitments.

All findings in this document should be interpreted explicitly as **99% (upper-tail) results**, not average-duration predictions.