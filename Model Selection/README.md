# Evaluate baseline variables as predictors of abstinence

### Background

Smoking cessation remains a significant challenge, particularly for individuals with a history of major depressive disorder (MDD), who often experience higher nicotine dependence and more severe withdrawal symptoms. This study investigates the moderating effects of baseline factors, including age at phone interview and sex at phone interview on smoking abstinence outcomes in this high-risk population.

### Methods

A randomized, placebo-controlled, 2x2 factorial design was used, involving 300 adult smokers with current or past MDD. Modified Poisson regression models were applied to multiply imputed datasets to assess the impact of demographic, psychological, and physiological baseline factors and interactions. AUC and Briei were used to evaluate models.

### Results

The results indicate that Non-Hispanic White status, lower FTCD scores (indicating lower nicotine dependence), and varenicline use were significant predictors of smoking abstinence. Varenicline demonstrated a strong positive effect on cessation rates ($\beta$ = 1.20, p < 0.001), while behavioral therapy alone did not show significant subgroup variation. Nicotine Metabolism Ratio (NMR) exhibited a positive trend ($\beta$ = 0.54, p = 0.075) but did not reach statistical significance. Overall, the models showed good discrimination (pooled AUC = 0.76) and calibration (pooled Brier score = 0.14), indicating reliable predictive performance across imputations.

### Conclusion

This study highlights the critical role of nicotine dependence, demographic factors, and pharmacotherapy in smoking cessation among individuals with MDD. Varenicline consistently improved cessation outcomes, regardless of baseline characteristics, underscoring its importance in smoking cessation strategies. While behavioral activation alone did not uniformly enhance cessation rates, the observed trends in associations with baseline characteristics, such as NMR, warrant further investigation. These findings emphasize the need for personalized smoking cessation strategies that incorporate individual demographic and smoking-related baseline characteristics to optimize outcomes.



## Files
### report

`model_selection_report_Updated.Rmd`: The Rmarkdown version of the Model Selection report, which includes both written text interpretations and raw code used in the analysis. 

`model_selection_report_Updated.pdf`: The PDF version of the Model Selection report, which includes both written text interpretations and a Code Applendix with the raw code used in the analysis. 


## Dependencies

The following packages were used in this analysis: 

 - Data Manipulation: `tidyverse` , `dplyr`, `tidyr`, `reshape2`, `glmnet`, `mice`, `sandwich`, `lmtest`
 - Table Formatting: `knitr`, `kableExtra`
 - Data Visualization: `ggplot2`, `naniar`, `pROC`
