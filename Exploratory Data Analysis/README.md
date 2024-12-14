# Explore the impact of environmental conditions on marathon performance in gender

### Background
Marathon performance is known to be influenced by several factors, including age, gender, and environmental conditions such as temperature and humidity. Previous research has shown that older adults and different genders experience varying levels of heat stress, impacting their endurance and overall race times. This study aims to analyze how these environmental conditions to influence marathon outcomes.

### Methods
The dataset comprises single-age best performances from men and women aged 14-91, collected from five major marathon events over 15-20 years. We included variables such as WBGT, dry bulb temperature (Td), wet bulb temperature (Tw), black globe temperature (Tg), relative humidity (rh), solar radiation (SR), wind speed, and dew point (DP). Exploratory data analysis was conducted to examine relationships between variables, followed by regression modeling. We applied stepwise regression to identify key environmental factors, and weighted least squares (WLS) regression to handle heteroskedasticity. Additionally, variables were standardized to address multicollinearity issues, and models were run separately to isolate the effects of highly correlated variables.

### Results
The study finds that high WBGT and Td levels significantly impair performance, particularly in older age groups. Td and DP emerge as the most influential factors, followed by SR. Extreme heat conditions (e.g., red flag WBGT) are associated with the greatest performance declines. Additionally, age and gender interact with these variables, indicating that older and male athletes show distinct performance trends under varying environmental conditions. The full report can be found [here](<Exploratory Data Analysis/report/Jing_Report_Updated.pdf>).

![](<Exploratory Data Analysis/images/table5.png>)

## Files
### R
`preprocess.R`: Contains the preprocessing steps necessary for exploratory data analysis. Specifically, this script renamed the data variables and converted the categorical variables into factors.

### report
`Jing_Report_Updated.Rmd`: The Rmarkdown version of the Exploratory Data Analysis report, which includes both written text interpretations and raw code used in the analysis. 

`Jing_Report_Updated.pdf`: The PDF version of the Exploratory Data Analysis report, which includes both written text interpretations and a Code Applendix with the raw code used in the analysis. 


## Dependencies

The following packages were used in this analysis: 

 - Data Manipulation: `tidyverse` , `dplyr`, `tidyr`, `reshape2`
 - Table Formatting: `knitr`, `kableExtra`
 - Data Visualization: `ggplot2`, `naniar`
