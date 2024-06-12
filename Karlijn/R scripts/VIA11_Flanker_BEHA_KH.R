###################################################################
###################### VIA 11 Eriksen Flanker #####################
################## Behavioural analysis EEG Data ##################
###################################################################

# This script is made by Karlijn Hendriks in May, 2022 for the behaviourial data analysis of the Flanker task from VIA11 (thesis purposes, not without ommission and commision errors etc)


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

# Clear environment
rm(list=ls())

# Load data
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N34_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N34_KH.xlsx")




####### CHARACTERISTICS

# MEAN + SD
library(psych)
describeBy(data, data$fhr_group)
describeBy(data, data$gender)

# TESTS

### Age

# Normality assumptions
with(data,shapiro.test(age[fhr_group == "PBC"]))
# p > 0.05 --> normally distributed
with(data,shapiro.test(age[fhr_group == "FHR"]))
# p > 0.05 --> normally distributed

# Homogeneity of variances assumption
res.ftest <- var.test(age ~ fhr_group, data = data)
res.ftest
# p > 0.05 --> no significant difference between the variances of the two sets of data

# T-TEST
age_test <- t_test(data, formula = age ~ fhr_group, paired=FALSE, var.equal = TRUE ,alternative = "two.sided")
age_test
# p > 0.05 --> no significant difference in age between FHR and PBC

### Gender

rm(list=ls())
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N34_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N34_KH.xlsx")
table(data$fhr_group,data$gender)
chisq.test(data$fhr_group,data$gender, correct=FALSE)


####### BEHAVIOURAL RESULTS

### RT

library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N34_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N34_KH.xlsx")

# RT (RT_con and RT_incon) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "RT", RT_con, RT_incon) %>%
  convert_as_factor(id, condition)

# Some summary statistics
data %>%
  group_by(condition, fhr_group) %>%
  get_summary_stats(RT, type = "mean_sd")

# Data visualization
bxp <- ggboxplot(
  data, x = "condition", y = "RT",
  color = "fhr_group", palette = "jco")
bxp

# Normality assumptions

# .....

# Two-way ANOVA
res.aov <- anova_test(data, dv = RT, wid=id, between=fhr_group, within=condition)
get_anova_table(res.aov)

# Posthocs

# Pairwise comparisons between condition levels
pwc <- data %>%
  group_by(fhr_group) %>%
  pairwise_t_test(RT ~ condition, p.adjust.method = "bonferroni")
pwc

# Pairwise comparisons between group levels
pwc <- data %>%
  group_by(condition) %>%
  pairwise_t_test(RT ~ fhr_group, p.adjust.method = "bonferroni")
pwc




### ACCURACY 

library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N34_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N34_KH.xlsx") 

# ACC (ACC_con and ACC_incon) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "ACC", ACC_con, ACC_incon) %>%
  convert_as_factor(id, condition)

# Some summary statistics
data %>%
  group_by(condition, fhr_group) %>%
  get_summary_stats(ACC, type = "mean_sd")

# Data visualization
bxp <- ggboxplot(
  data, x = "condition", y = "ACC",
  color = "fhr_group", palette = "jco")
bxp

# Two-way ANOVA
res.aov <- anova_test(data, dv = ACC, wid=id, between=fhr_group, within=condition)
get_anova_table(res.aov)

# Posthocs

# Pairwise comparisons between condition levels
pwc <- data %>%
  group_by(fhr_group) %>%
  pairwise_t_test(ACC ~ condition, p.adjust.method = "bonferroni")
pwc

# Pairwise comparisons between group levels
pwc <- data %>%
  group_by(condition) %>%
  pairwise_t_test(ACC ~ fhr_group, p.adjust.method = "bonferroni")
pwc


# Barplots
barplot1<- ggplot(data, aes(x=condition, y=ACC, color=fhr_group))
barplot1

accuracy <- table(data$ACC_con, data$ACC_incon)
barplot(accuracy)





### CV

library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N34_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N34_KH.xlsx") 

# CV (COV_RT_CC and COV_RT_IC) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "COV", COV_RT_CC, COV_RT_IC) %>%
  convert_as_factor(id, condition)

# Some summary statistics
data %>%
  group_by(condition, fhr_group) %>%
  get_summary_stats(COV, type = "mean_sd")

# Data visualization
bxp <- ggboxplot(
  data, x = "condition", y = "COV",
  color = "fhr_group", palette = "jco")
bxp

# Normality assumptions

# .....

# Two-way ANOVA
res.aov <- anova_test(data, dv = COV, wid=id, between=fhr_group, within=condition)
get_anova_table(res.aov)

# Posthocs

# Pairwise comparisons between condition levels
pwc <- data %>%
  group_by(fhr_group) %>%
  pairwise_t_test(RT ~ condition, p.adjust.method = "bonferroni")
pwc

# Pairwise comparisons between group levels
pwc <- data %>%
  group_by(condition) %>%
  pairwise_t_test(RT ~ fhr_group, p.adjust.method = "bonferroni")
pwc






################################
######## Dataset N = 174 #######
################################

# Clear environment
rm(list=ls())

# Load data
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N174_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N174_KH.xlsx")


####### CHARACTERISTICS

# MEAN + SD
library(psych)
describeBy(data, data$hgr_status)

# TESTS

### Age

# Normality assumption - ANOVA model residuals
data %>% 
  group_by(hgr_status) %>%
  identify_outliers(age)
model <- lm (age~hgr_status, data)
ggqqplot(residuals(model))
shapiro_test(residuals(model))
# Normality assumption - each group seperately (N>50, QQplots preferred)
data %>%
  group_by(hgr_status) %>%
  shapiro_test(age)
ggqqplot(data, "age", facet.by="hgr_status")
# points fall approximately along reference line --> assume normality

# Homogeneity of variances
data %>% levene_test(age~hgr_status)
# p > 0.05, no sign difference between variances across groups

# ONE-WAY ANOVA
res.aov <- data %>% anova_test(age ~ hgr_status)
res.aov
?anova_test
# p > 0.05, no sign difference in age between groups 


### Gender  

rm(list=ls())
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N174_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N174_KH.xlsx")
table(data$hgr_status,data$gender)
chisq.test(data$hgr_status,data$gender, correct=FALSE)



####### BEHAVIOURAL RESULTS

### RT

library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N174_KH.xlsx")
data = VIA11_Flanker_everything_N174_KH
#data <- read_excel("VIA11_Flanker_everything_N174_KH.xlsx")

# RT (RT_con and RT_incon) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "RT", RT_CC, RT_IC) %>%
  convert_as_factor(id, condition)

# Some summary statistics
data %>%
  group_by(condition, hgr_status) %>%
  get_summary_stats(RT, type = "mean_sd")

# Data visualization
bxp <- ggboxplot(
  data, x = "condition", y = "RT",
  color = "hgr_status", palette = "jco")
bxp

# Normality assumptions

# .....

# Two-way ANOVA
res.aov <- anova_test(data, dv = RT, wid=id, between=hgr_status, within=condition)
get_anova_table(res.aov)

# Posthocs

# Pairwise comparisons between condition levels
pwc <- data %>%
  group_by(hgr_status) %>%
  pairwise_t_test(RT ~ condition, p.adjust.method = "bonferroni")
pwc

# Pairwise comparisons between group levels
pwc <- data %>%
  group_by(condition) %>%
  pairwise_t_test(RT ~ hgr_status, p.adjust.method = "bonferroni")
pwc




### ACCURACY 

library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N174_KH.xlsx")
#data = VIA11_Flanker_everything_N174_KH
#data <- read_excel("VIA11_Flanker_everything_N174_KH.xlsx")


# ACC (ACC_con and ACC_incon) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "ACC", ACC_CON, ACC_INCON) %>%
  convert_as_factor(id, condition)

# Some summary statistics
data %>%
  group_by(condition, hgr_status) %>%
  get_summary_stats(ACC, type = "mean_sd")

# Data visualization
bxp <- ggboxplot(
  data, x = "condition", y = "ACC",
  color = "hgr_status", palette = "jco")
bxp

# Two-way ANOVA
res.aov <- anova_test(data, dv = ACC, wid=id, between=hgr_status, within=condition)
get_anova_table(res.aov)

# Posthocs

# Pairwise comparisons between condition levels
pwc <- data %>%
  group_by(hgr_status) %>%
  pairwise_t_test(ACC ~ condition, p.adjust.method = "bonferroni")
pwc

# Pairwise comparisons between group levels
pwc <- data %>%
  group_by(condition) %>%
  pairwise_t_test(ACC ~ hgr_status, p.adjust.method = "bonferroni")
pwc


# Barplots
barplot1<- ggplot(data, aes(x=condition, y=ACC, color=hgr_status))
barplot1

accuracy <- table(data$ACC_con, data$ACC_incon)
barplot(accuracy)





### CV

library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N174_KH.xlsx")
#data = VIA11_Flanker_everything_N174_KH
#data <- read_excel("VIA11_Flanker_everything_N174_KH.xlsx")

# CV (COV_RT_CC and COV_RT_IC) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "COV", COV_RT_CC, COV_RT_IC) %>%
  convert_as_factor(id, condition)

# Some summary statistics
data %>%
  group_by(condition, hgr_status) %>%
  get_summary_stats(COV, type = "mean_sd")

# Data visualization
bxp <- ggboxplot(
  data, x = "condition", y = "COV",
  color = "hgr_status", palette = "jco")
bxp

# Normality assumptions

# .....

# Two-way ANOVA
res.aov <- anova_test(data, dv = COV, wid=id, between=hgr_status, within=condition)
get_anova_table(res.aov)

# Posthocs

# Effect of group at each condition
one.way <- data %>%
  group_by(condition) %>%
  anova_test(dv = COV, wid = id, between = hgr_status) %>%
  get_anova_table() %>%
  adjust_pvalue(method = "bonferroni")
one.way

# Pairwise comparisons between condition levels
pwc <- data %>%
  group_by(hgr_status) %>%
  pairwise_t_test(COV ~ condition, p.adjust.method = "bonferroni")
pwc

# Pairwise comparisons between group levels
pwc <- data %>%
  group_by(condition) %>%
  pairwise_t_test(COV ~ hgr_status, p.adjust.method = "bonferroni")
pwc



