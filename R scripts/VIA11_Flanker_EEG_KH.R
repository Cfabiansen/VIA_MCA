###################################################################
###################### VIA 11 Eriksen Flanker #####################
################## Statistical analysis EEG Data ##################
###################################################################

# This script is made by Karlijn Hendriks in April, 2022 for the EEG data analysis of the Flanker task from VIA11



### PACKAGES ###

### Statistics 

#install.packages("installr") # package installations are only needed the first time you use it
#library(installr)            
#updateR()
#install.packages("rlang")
#install.packages("magrittr") 
#install.packages("dplyr")    
#install.packages("tidyverse")
#install.packages("ggpubr")
#install.packages("rstatix")
library(magrittr) 
library(dplyr) 
library(tidyverse)
library(ggpubr)
library(rstatix)



# ! For the N34 dataset, group = fhr_group (FHR or PBC)
# ! For the N174 dataset, group = hgr_status (SZ, BP or K)

################################
######## Dataset N = 34 ########
################################


####################### N200 ###########################

# Load data
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N34_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N34_KH.xlsx")  


# Condition (congruent and incongruent) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "amplitude", CON_N2_FCZ, INCON_N2_FCZ) %>%
  convert_as_factor(id, condition)

# Inspect some random rows of the data by groups 
set.seed(123)
data %>% sample_n_by(fhr_group, condition, size = 1) 

# Some summary statistics
data %>%
  group_by(condition, fhr_group) %>%
  get_summary_stats(amplitude, type = "mean_sd")

# Data visualization
bxp <- ggboxplot(
  data, x = "condition", y = "amplitude",
  color = "fhr_group", palette = "jco")
bxp

### ASSUMPTIONS

# Outliers
data %>%
  group_by(condition, fhr_group) %>%
  identify_outliers(amplitude)

# Normality
data %>%
  group_by(condition, fhr_group) %>%
  shapiro_test(amplitude)
# p should be >0.05
ggqqplot(data, "amplitude", ggtheme = theme_bw()) + facet_grid(condition~fhr_group)
# normality checked if all the points fall approximately along the reference line 

# Homogeneity of variances
data %>%
  group_by(condition) %>%
  levene_test(amplitude ~ fhr_group)
# p should be >0.05

# Assumption of sphericity --> implied in anova_test, Greenhouse-Geisser sphericity correction applied

# Homogeneity of covariances
box_m(data[, "amplitude", drop = FALSE], data$fhr_group)
# p should be > 0.001

### COMPUTATION 


# TWO-WAY MIXED ANOVA test
res.aov <- anova_test(
  data=data, dv = amplitude, wid = id, 
  between = fhr_group, within = condition)
get_anova_table(res.aov)



####################### P3b ###########################

# Clear environment
rm(list=ls())

# Load data again
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N34_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N34_KH.xlsx")   


# Condition (congruent and incongruent) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "amplitude", CON_P3_PZ, INCON_P3_PZ) %>%
  convert_as_factor(id, condition)

# Inspect some random rows of the data by groups 
set.seed(123)
data %>% sample_n_by(fhr_group, condition, size = 1)

# Some summary statistics
data %>%
  group_by(condition, fhr_group) %>%
  get_summary_stats(amplitude, type = "mean_sd")

# Data visualization
bxp <- ggboxplot(
  data, x = "condition", y = "amplitude",
  color = "fhr_group", palette = "jco")
bxp

### ASSUMPTIONS

# Outliers
data %>%
  group_by(condition, fhr_group) %>%
  identify_outliers(amplitude)

# Normality (ANNA: K-S test?)
data %>%
  group_by(condition, fhr_group) %>%
  shapiro_test(amplitude)
ggqqplot(data, "amplitude", ggtheme = theme_bw()) + facet_grid(condition~fhr_group)

# Homogeneity of variances
data %>%
  group_by(condition) %>%
  levene_test(amplitude ~ fhr_group)

# Assumption of sphericity --> implied in anova_test, Greenhouse-Geisser sphericity correction applied

# Homogeneity of covariances
box_m(data[, "amplitude", drop = FALSE], data$fhr_group)


### COMPUTATION 


# TWO-WAY MIXED ANOVA test
res.aov <- anova_test(
  data=data, dv = amplitude, wid = id, 
  between = fhr_group, within = condition)
get_anova_table(res.aov)



####################### LRP ###########################

# Clear environment
rm(list=ls())

# Remove variables and load data again
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N34_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N34_KH.xlsx")  

# Condition (congruent and incongruent) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "LRP", CON_peaktopeak, INCON_peaktopeak) %>%
  convert_as_factor(id, condition)

# Some summary statistics
data %>%
  group_by(condition, fhr_group) %>%
  get_summary_stats(LRP, type = "mean_sd")

# Data visualization
bxp <- ggboxplot(
  data, x = "condition", y = "LRP",
  color = "fhr_group", palette = "jco")
bxp

### ASSUMPTIONS

# Outliers
data %>%
  group_by(condition, fhr_group) %>%
  identify_outliers(LRP)

# Normality (ANNA: K-S test?)
data %>%
  group_by(condition, fhr_group) %>%
  shapiro_test(LRP)
ggqqplot(data, "LRP", ggtheme = theme_bw()) + facet_grid(condition~fhr_group)

# Homogeneity of variances
data %>%
  group_by(condition) %>%
  levene_test(LRP ~ fhr_group)

# Assumption of sphericity --> implied in anova_test, Greenhouse-Geisser sphericity correction applied

# Homogeneity of covariances
box_m(data[, "LRP", drop = FALSE], data$fhr_group)


### COMPUTATION


# TWO-WAY MIXED ANOVA test
res.aov <- anova_test(
  data=data, dv = LRP, wid = id, 
  between = fhr_group, within = condition)
get_anova_table(res.aov)




#################################
######## Dataset N = 174 ########
#################################

# ! For the N174 dataset, group = hgr_status (SZ, BP or K), instead of fhr_group (FHR or PBC)

####################### N200 ###########################

# Clear environment
rm(list=ls())

# Load data
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N174_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N174_KH.xlsx")  

# Condition (congruent and incongruent) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "amplitude", CON_N2_FCZ, INCON_N2_FCZ) %>%
  convert_as_factor(id, condition)

# Inspect some random rows of the data by groups 
set.seed(123)
data %>% sample_n_by(hgr_status, condition, size = 1) 

# Some summary statistics
data %>%
  group_by(condition, hgr_status) %>%
  get_summary_stats(amplitude, type = "mean_sd")

# Data visualization
bxp <- ggboxplot(
  data, x = "condition", y = "amplitude",
  color = "hgr_status", palette = "jco")
bxp


### ASSUMPTIONS

# Outliers
data %>%
  group_by(condition, hgr_status) %>%
  identify_outliers(amplitude)

# Normality (ANNA: K-S test?)
data %>%
  group_by(condition, hgr_status) %>%
  shapiro_test(amplitude)
ggqqplot(data, "amplitude", ggtheme = theme_bw()) + facet_grid(condition~hgr_status)


# Homogeneity of variances
data %>%
  group_by(condition) %>%
  levene_test(amplitude ~ hgr_status)

# Assumption of sphericity --> implied in anova_test, Greenhouse-Geisser sphericity correction applied

# Homogeneity of covariances
box_m(data[, "amplitude", drop = FALSE], data$hgr_status)


### COMPUTATION

# TWO-WAY MIXED ANOVA test
res.aov <- anova_test(
  data=data, dv = amplitude, wid = id, 
  between = hgr_status, within = condition)
get_anova_table(res.aov)


### POST HOC TESTING

# Comparisons for condition variable
data %>%
  pairwise_t_test(
    amplitude ~ condition, paired = TRUE, 
    p.adjust.method = "bonferroni"
  )



####################### P3b ###########################

# Clear environment
rm(list=ls())

# Load data again
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N174_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N174_KH.xlsx")   

# Condition (congruent and incongruent) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "amplitude", CON_P3_PZ, INCON_P3_PZ) %>%
  convert_as_factor(id, condition)

# Inspect some random rows of the data by groups 
set.seed(123)
data %>% sample_n_by(hgr_status, condition, size = 1)

# Some summary statistics
data %>%
  group_by(condition, hgr_status) %>%
  get_summary_stats(amplitude, type = "mean_sd")

# Data visualization
bxp <- ggboxplot(
  data, x = "condition", y = "amplitude",
  color = "hgr_status", palette = "jco")
bxp

### ASSUMPTIONS

# Outliers
data %>%
  group_by(condition, hgr_status) %>%
  identify_outliers(amplitude)

# Normality (ANNA: K-S test?)
data %>%
  group_by(condition, hgr_status) %>%
  shapiro_test(amplitude)
ggqqplot(data, "amplitude", ggtheme = theme_bw()) + facet_grid(condition~hgr_status)

# Homogeneity of variances
data %>%
  group_by(condition) %>%
  levene_test(amplitude ~ hgr_status)

# Assumption of sphericity --> implied in anova_test, Greenhouse-Geisser sphericity correction applied

# Homogeneity of covariances
box_m(data[, "amplitude", drop = FALSE], data$hgr_status)



### COMPUTATION


# TWO-WAY MIXED ANOVA test
res.aov <- anova_test(
  data=data, dv = amplitude, wid = id, 
  between = hgr_status, within = condition)
get_anova_table(res.aov)


### POST HOC TESTING

# SIMPLE MAIN effect of hgr_status at each condition
one.way <- data %>%
  group_by(condition) %>%
  anova_test(dv = amplitude, wid = id, between = hgr_status) %>%
  get_anova_table() %>%
  adjust_pvalue(method = "bonferroni")
one.way

# Pairwise comparisons between hgr_status
pwc <- data %>%
  group_by(condition) %>%
  pairwise_t_test(amplitude ~ hgr_status, p.adjust.method = "bonferroni")
pwc



### EXTRA 

# SIMPLE MAIN effect of condition at each hgr_status
one.way2 <- data %>%
  group_by(hgr_status) %>%
  anova_test(dv = amplitude, wid = id, within = condition) %>%
  get_anova_table() %>%
  adjust_pvalue(method = "bonferroni")
one.way2


# Pairwise comparisons between condition
pwc2 <- data %>%
  group_by(hgr_status) %>%
  pairwise_t_test(
    amplitude ~ condition, paired = TRUE, 
    p.adjust.method = "bonferroni"
  ) %>%
  select(-df, -statistic, -p) # Remove details
pwc2






####################### LRP ###########################

# Clear environment
rm(list=ls())

# Remove variables and load data again
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N174_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N174_KH.xlsx")  

# Condition (congruent and incongruent) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "LRP", CON_peaktopeak, INCON_peaktopeak) %>%
  convert_as_factor(id, condition)

# Some summary statistics
data %>%
  group_by(condition, hgr_status) %>%
  get_summary_stats(LRP, type = "mean_sd")

# Data visualization
bxp <- ggboxplot(
  data, x = "condition", y = "LRP",
  color = "hgr_status", palette = "jco")
bxp

### ASSUMPTIONS

# Outliers
data %>%
  group_by(condition, hgr_status) %>%
  identify_outliers(LRP)

# Normality (ANNA: K-S test?)
data %>%
  group_by(condition, hgr_status) %>%
  shapiro_test(LRP)
ggqqplot(data, "LRP", ggtheme = theme_bw()) + facet_grid(condition~hgr_status)

# Homogeneity of variances
data %>%
  group_by(condition) %>%
  levene_test(LRP ~ hgr_status)

# Assumption of sphericity --> implied in anova_test, Greenhouse-Geisser sphericity correction applied

# Homogeneity of covariances
box_m(data[, "LRP", drop = FALSE], data$hgr_status)


### COMPUTATION


# TWO-WAY MIXED ANOVA test
res.aov <- anova_test(
  data=data, dv = LRP, wid = id, 
  between = hgr_status, within = condition)
get_anova_table(res.aov)
