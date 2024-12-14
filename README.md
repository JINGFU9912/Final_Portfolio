# Data Analysis Portfolio

This repository showcases three distinct data analysis projects, showcasing my skills in exploratory data analysis, model selection, and designing simulation studies. 

## Project 1
### Explore the impact of environmental conditions on marathon performance in gender

### Background
Marathon performance is known to be influenced by several factors, including age, gender, and environmental conditions such as temperature and humidity. Previous research has shown that older adults and different genders experience varying levels of heat stress, impacting their endurance and overall race times. This study aims to analyze how these environmental conditions to influence marathon outcomes.

### Methods
The dataset comprises single-age best performances from men and women aged 14-91, collected from five major marathon events over 15-20 years. We included variables such as WBGT, dry bulb temperature (Td), wet bulb temperature (Tw), black globe temperature (Tg), relative humidity (rh), solar radiation (SR), wind speed, and dew point (DP). Exploratory data analysis was conducted to examine relationships between variables, followed by regression modeling. We applied stepwise regression to identify key environmental factors, and weighted least squares (WLS) regression to handle heteroskedasticity. Additionally, variables were standardized to address multicollinearity issues, and models were run separately to isolate the effects of highly correlated variables.

### Results
The study finds that high WBGT and Td levels significantly impair performance, particularly in older age groups. Td and DP emerge as the most influential factors, followed by SR. Extreme heat conditions (e.g., red flag WBGT) are associated with the greatest performance declines. Additionally, age and gender interact with these variables, indicating that older and male athletes show distinct performance trends under varying environmental conditions. The full report can be found [here](<Exploratory Data Analysis/report/Jing_Report_Updated.pdf>).

## Project 2
### Evaluate baseline variables as predictors of abstinence

### Background
Smoking cessation remains a significant challenge, particularly for individuals with a history of major depressive disorder (MDD), who often experience higher nicotine dependence and more severe withdrawal symptoms. This study investigates the moderating effects of baseline factors, including age at phone interview and sex at phone interview on smoking abstinence outcomes in this high-risk population.

### Methods
A randomized, placebo-controlled, 2x2 factorial design was used, involving 300 adult smokers with current or past MDD. Modified Poisson regression models were applied to multiply imputed datasets to assess the impact of demographic, psychological, and physiological baseline factors and interactions. AUC and Briei were used to evaluate models.

### Results
The results indicate that Non-Hispanic White status, lower FTCD scores (indicating lower nicotine dependence), and varenicline use were significant predictors of smoking abstinence. Varenicline demonstrated a strong positive effect on cessation rates ($\beta$ = 1.20, p < 0.001), while behavioral therapy alone did not show significant subgroup variation. Nicotine Metabolism Ratio (NMR) exhibited a positive trend ($\beta$ = 0.54, p = 0.075) but did not reach statistical significance. Overall, the models showed good discrimination (pooled AUC = 0.76) and calibration (pooled Brier score = 0.14), indicating reliable predictive performance across imputations. The full report can be found [here](<Model Selection/report/model_selection_report_Updated.pdf>). 

## Project 3
### Estimate the Treatment Effect of Simulated Data on an Outcome Variable Y

### Background
Cluster randomized trials (CRTs) are commonly used to evaluate interventions applied at the group level, such as in schools or clinics. Designing CRTs involves balancing the number of clusters and the number of observations per cluster to optimize statistical efficiency while staying within budget constraints. These decisions are further complicated by factors such as intra-cluster correlation and differing costs for initial and additional samples in each cluster. Simulation studies provide a powerful tool to systematically evaluate design options under varying budget constraints and data-generating conditions, allowing researchers to identify optimal designs for estimating treatment effects accurately and efficiently.

### Methods
In this study, we use a simulation-based approach to evaluate the design of cluster randomized trials (CRTs) under fixed budget constraints. The hierarchical model assumes that the outcome variable (Y) is influenced by fixed effects (treatment assignment) and random effects (cluster-level variability). We systematically vary key parameters, including the treatment effect size ($\beta$), cluster-level variance ($\gamma^2$), and within-cluster variance ($\sigma^2$), while considering realistic cost structures where the first sample in a cluster (c1) is more expensive than subsequent samples (c2). Performance metrics, such as bias, standard error, and coverage probability, are calculated to assess the accuracy and precision of the treatment effect estimates. Additionally, the study explores how varying the cost ratio (c1/c2) and data generation parameters impact the optimal allocation of resources.

### Results
Our simulation study evaluated the impact of underlying data generation parameters and cost ratios on the estimation of treatment effects. The results demonstrated that bias remained minimal across all parameter settings, while standard errors increased with larger $\beta$ and $\gamma^2$, reflecting heightened variability in these conditions. Coverage rates were consistent across most settings but slightly reduced under higher $\alpha^2$ values. Cost ratios significantly influenced the allocation of clusters and observations per cluster, with lower c1/c2 ratios favoring smaller clusters and more observations, resulting in reduced bias and variability. More details can be found in the [report](Simulation/report/simulation_report.pdf)

## Contact
**Jing Fu** \
jing_fu@brown.edu 
