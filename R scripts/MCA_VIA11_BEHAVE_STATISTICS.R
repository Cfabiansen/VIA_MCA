###############################################################
###############################################################
#################### VIA 11 BEHA STATISTICS ###################
###############################################################
###############################################################

### Loading packages ###

library(magrittr) 
library(dplyr) 
library(tidyverse)
library(ggpubr)
library(rstatix)

# Clear environment
rm(list=ls())


################################################
######### VIA 11 FHR VS PBS (2 GROUPS) #########
################################################

# Load data
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")

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
data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")
table(data$fhr_group,data$gender)
chisq.test(data$fhr_group,data$gender, correct=FALSE)


############## BEHAVIOURAL RESULTS ##############

### RT
rm(list=ls())
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")


# RT (RT_con and RT_incon) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "RT", RT_CC, RT_IC) %>%
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
data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")


# ACC (ACC_con and ACC_incon) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "ACC", ACC_CON, ACC_INCON) %>%
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


### CV
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")


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


# Two-way ANOVA
res.aov <- anova_test(data, dv = COV, wid=id, between=fhr_group, within=condition)
get_anova_table(res.aov)

# Posthocs

# Pairwise comparisons between condition levels
pwc <- data %>%
  group_by(fhr_group) %>%
  pairwise_t_test(COV ~ condition, p.adjust.method = "bonferroni")
pwc

# Pairwise comparisons between group levels
pwc <- data %>%
  group_by(condition) %>%
  pairwise_t_test(COV ~ fhr_group, p.adjust.method = "bonferroni")
pwc


################################################
####### VIA 11 HGR VS PBS (ALL 3 GROUPS) #######
################################################

# Clear environment
rm(list=ls())

# Load data
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")

# MEAN + SD
library(psych)
describeBy(data, data$hgr_status)

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
data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")
table(data$hgr_status,data$gender)
chisq.test(data$hgr_status,data$gender, correct=FALSE)

####### BEHAVIOURAL RESULTS

### RT

library(readxl)
getwd
data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")


# RT (RT_con and RT_incon) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "RT", RT_CC, RT_IC) %>%
  convert_as_factor(id, condition)

# Some summary statistics
data %>%
  group_by(condition, hgr_status) %>%
  get_summary_stats(RT, type = "mean_sd")

# Data visualization
# Assuming 'data' is your dataframe
data <- data %>%
  mutate(condition_status = paste(condition, hgr_status, sep = "_"))

# Define custom colors for each combination
custom_colors <- c("RT_CC_FHR_BP" = "#E49E6A", 
                   "RT_CC_FHR_SZ" = "#D6742F", 
                   "RT_CC_PBC" = "#B3D235", 
                   "RT_IC_FHR_BP" = "#E49E6A", 
                   "RT_IC_FHR_SZ" = "#D6742F", 
                   "RT_IC_PBC" = "#B3D235")

violin_VIA11_RT <- ggplot(data, aes(x = hgr_status, y = RT, fill = condition_status)) +  # Use combined variable for fill
  geom_violin(trim = FALSE, scale = "width") +
  geom_dotplot(binaxis = "y", stackdir = "center", stackratio = 1, dotsize = 0.5, 
               position = position_dodge(width = 0.9)) +
  labs(title = "VIA11 Reaction time distribution",x = "Status", y = "Reaction time") +
  theme_bw() +
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA11_RT)

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
data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")

#ACC (ACC_con and ACC_incon) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "ACC", ACC_CON, ACC_INCON) %>%
  convert_as_factor(id, condition)

# Some summary statistics
data %>%
  group_by(condition, hgr_status) %>%
  get_summary_stats(ACC, type = "mean_sd")

# Data visualization
# Assuming 'data' is your dataframe
data <- data %>%
  mutate(condition_status = paste(condition, hgr_status, sep = "_"))


# Define custom colors for each combination
custom_colors <- c("ACC_CON_FHR_BP" = "#E49E6A", 
                   "ACC_CON_FHR_SZ" = "#D6742F", 
                   "ACC_CON_PBC" = "#B3D235", 
                   "ACC_INCON_FHR_BP" = "#E49E6A", 
                   "ACC_INCON_FHR_SZ" = "#D6742F", 
                   "ACC_INCON_PBC" = "#B3D235")

violin_VIA11_ACC <- ggplot(data, aes(x = hgr_status, y = ACC, fill = condition_status)) +  # Use combined variable for fill
  geom_violin(trim = FALSE, scale = "width") +
  geom_dotplot(binaxis = "y", stackdir = "center", stackratio = 1, dotsize = 0.5, 
               position = position_dodge(width = 0.9)) +
  labs(title = "VIA11 Accuracy distribution", x = "Status", y = "Accuracy") +
  theme_bw() +
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA11_ACC)

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


### CV

library(readxl)
getwd
data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")


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










