library(tidyverse)
data <- read.csv("/Users/fusei/Desktop/24FALL/PHP2550/Project1/project1.csv")
## rename
colnames(data) <- c("Race","Year","Sex","Flag","Age","Percent_off","Td","Tw","rh","Tg","SR",
                    "DP", "Wind", "WBGT")
## re-organized variables
data$Race <- factor(data$Race, levels = 0:4)
data$Year <- factor(data$Year, levels = 1993:2016)
data$Sex <-factor(data$Sex, levels = c(0,1))
data$Flag <- factor(data$Flag, levels = c("White","Green", "Yellow","Red","Black"))

## AQI
aqi_data <- read.csv("/Users/fusei/Desktop/24FALL/PHP2550/Project1/aqi_values.csv")

# keep right date
aqi_data$date_local <- as.Date(aqi_data$date_local)

# calculate avearge according to date , place and air parameters
summary_data <- aqi_data %>%
    group_by(marathon, date_local, parameter_code) %>%
    summarize(
        mean_aqi = mean(aqi, na.rm = TRUE), 
    ) %>%
    pivot_wider(
        names_from = parameter_code, 
        values_from = c(mean_aqi), 
        names_prefix = "param_" 
    )

## add AQI for ozone in data
summary_data <- summary_data %>%
    mutate(year = format(date_local, "%Y")) 
summary_data <- summary_data[,c(1,3,6)]
## create mapping
city_mapping <- c("Boston" = 0, "Chicago" = 1, "Grandmas" = 4, "NYC" = 2, "Twin Cities" = 3)
## substitute city name using factor
summary_data <- summary_data %>%
    mutate(marathon = city_mapping[marathon]) %>%
    mutate(marathon = as.factor(marathon))
## Keep same variable format
data <- data %>%
    mutate(Year = as.character(Year))
## combined two dataset
data <- data %>%
    left_join(summary_data, by = c("Race" = "marathon", "Year" = "year"))
## rename 
colnames(data) <- c("Race","Year","Sex","Flag","Age","Percent_off","Td","Tw","rh","Tg","SR",
                    "DP", "Wind", "WBGT","AQI")
## save data
saveRDS(data,"/Users/fusei/Desktop/24FALL/PHP2550/Project1/project1.cleaned_data.rds")
