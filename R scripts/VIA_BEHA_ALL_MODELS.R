###############################################################
###############################################################
###############    VIA BEHA MIXED MODELS       ################
###############################################################
###############################################################

### Loading packages ###

library(magrittr) 
library(dplyr) 
library(tidyverse)
library(ggpubr)
library(rstatix)
library(lme4)
library(lmerTest)
library(nparLD)
# Clear environment
rm(list=ls())

#######################
#        VIA 11       #
#######################


#### VIA11 REACTION TIME

rm(list=ls())
library(readxl)
getwd
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")
source("/mnt/projects/VIA_MCA/Scripts/Karlijn/R scripts/geom_flat_violin.R")

# Excluding trails with too many errors
ids_to_exclude <- c("4", "60", "97", "230", "350")
VIA11_data <- VIA11_data %>% 
  filter(!id %in% ids_to_exclude)


VIA11_data <- VIA11_data %>%
  gather(key= "condition", value= "RT", RT_CC, RT_IC) %>%
  convert_as_factor(id, condition)

pwc <- VIA11_data %>%
  group_by(condition) %>%
  pairwise_t_test(RT ~ gender, p.adjust.method = "bonferroni")
pwc

modelRT <- lmer(RT ~ age + gender + hgr_status + condition + hgr_status * condition + (1|id), data = VIA11_data, REML = FALSE)
summary(modelRT)
anova(modelRT)

# Data visualization
# Assuming 'data' is your dataframe
VIA11_data <- VIA11_data %>%
  mutate(condition_status = paste(condition, hgr_status, sep = "_"))

# Define custom colors for each combination
custom_colors <- c("RT_CC_FHR_BP" = "#E49E6A", 
                   "RT_CC_FHR_SZ" = "#D6742F", 
                   "RT_CC_PBC" = "#B3D235", 
                   "RT_IC_FHR_BP" = "#E49E6A", 
                   "RT_IC_FHR_SZ" = "#D6742F", 
                   "RT_IC_PBC" = "#B3D235")

violin_VIA11_RT <- ggplot(VIA11_data, aes(x = hgr_status, y = RT, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = hgr_status, y = RT, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  ylim(200,800)+
  labs(title = "VIA11 Reaction time distribution",x = "Status", y = "Reaction time [ms]") +
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA11_RT)


### VIA11 ACCURACY

rm(list=ls())
library(readxl)
getwd
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")
source("/mnt/projects/VIA_MCA/Scripts/Karlijn/R scripts/geom_flat_violin.R")

# Excluding trails with too many errors
ids_to_exclude <- c("4", "60", "97", "230", "350")
VIA11_data <- VIA11_data %>% 
  filter(!id %in% ids_to_exclude)


VIA11_data <- VIA11_data %>%
  gather(key= "condition", value= "ACCURACY", ACC_CON, ACC_INCON) %>%
  convert_as_factor(id, condition)

pwc <- VIA11_data %>%
  group_by(condition) %>%
  pairwise_t_test(ACCURACY ~ gender, p.adjust.method = "bonferroni")
pwc



library(psych)
describeBy(VIA11_data,VIA11_data$age)

plot(VIA11_data$age,VIA11_data$ACCURACY)

modelACC <- lmer(ACCURACY ~ age + gender + hgr_status + condition + hgr_status * condition + (1|id), data = VIA11_data, REML = FALSE)
summary(modelACC)
anova(modelACC)

# non parametric manwhi u test
wilcox_test(ACCURACY ~ gender, data = VIA11_data)
wilcox_test(ACCURACY ~ condition, data = VIA11_data)


VIA11_data <- VIA11_data %>%
  mutate(condition_status = paste(condition, hgr_status, sep = "_"))
# Define custom colors for each combination
custom_colors <- c("ACC_CON_FHR_BP" = "#E49E6A", 
                   "ACC_CON_FHR_SZ" = "#D6742F", 
                   "ACC_CON_PBC" = "#B3D235", 
                   "ACC_INCON_FHR_BP" = "#E49E6A", 
                   "ACC_INCON_FHR_SZ" = "#D6742F", 
                   "ACC_INCON_PBC" = "#B3D235")

violin_VIA11_ACC <- ggplot(VIA11_data, aes(x = hgr_status, y = ACCURACY, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = hgr_status, y = ACCURACY, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  ylim(0.6,1.05)+ 
  labs(title = "VIA11 Accuracy distribution", x = "Status", y = "Accuracy") +
   
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA11_ACC)



### VIA 11 CVRT

rm(list=ls())
library(readxl)
getwd
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")
source("/mnt/projects/VIA_MCA/Scripts/Karlijn/R scripts/geom_flat_violin.R")

# Excluding trails with too many errors
ids_to_exclude <- c("4", "60", "97", "230", "350")
VIA11_data <- VIA11_data %>% 
  filter(!id %in% ids_to_exclude)


VIA11_data <- VIA11_data %>%
  gather(key= "condition", value= "CV_RT", COV_RT_CC, COV_RT_IC) %>%
  convert_as_factor(id, condition)

modelCV <- lmer(CV_RT ~ age + gender + hgr_status + condition + hgr_status * condition + (1|id), data = VIA11_data, REML = FALSE)
summary(modelCV)
anova(modelCV)


pwc <- VIA11_data %>%
  group_by(condition) %>%
  pairwise_t_test(CV_RT ~ hgr_status, p.adjust.method = "bonferroni")
pwc


library(psych)
describeBy(VIA11_data,VIA11_data$age)





VIA11_data <- VIA11_data %>%
  mutate(condition_status = paste(condition, hgr_status, sep = "_"))
# Define custom colors for each combination
custom_colors <- c("COV_RT_CC_FHR_BP" = "#E49E6A", 
                   "COV_RT_CC_FHR_SZ" = "#D6742F", 
                   "COV_RT_CC_PBC" = "#B3D235", 
                   "COV_RT_IC_FHR_BP" = "#E49E6A", 
                   "COV_RT_IC_FHR_SZ" = "#D6742F", 
                   "COV_RT_IC_PBC" = "#B3D235")

violin_VIA11_CV <- ggplot(VIA11_data, aes(x = hgr_status, y = CV_RT, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = hgr_status, y = CV_RT, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  ylim(0.05,0.35)+ 
  labs(title = "VIA11 Coefficient of variation (RT) distribution", x = "Status", y = "CV RT") +
   
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA11_CV)

#######################
#        VIA 15       #
#######################

### VIA 15 REACTION TIME
rm(list=ls())
library(readxl)
getwd
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_23_04.xlsx")
source("/mnt/projects/VIA_MCA/Scripts/Karlijn/R scripts/geom_flat_violin.R")

# Excluding trails with too many errors
ids_to_exclude <- c("25", "73", "97", "129", "138", "141", "180")
VIA15_data <- VIA15_data %>% 
  filter(!id %in% ids_to_exclude)


VIA15_data <- VIA15_data %>%
  gather(key= "condition", value= "RT", RT_CC, RT_IC) %>%
  convert_as_factor(id, condition)

pwc <- VIA15_data %>%
  group_by(condition) %>%
  pairwise_t_test(RT ~ gender, p.adjust.method = "bonferroni")
pwc

library(psych)
describeBy(VIA15_data$RT,VIA15_data$gender)



modelRT <- lmer(RT ~ age + gender + hgr_status + condition + hgr_status * condition + (1|id), data = VIA15_data, REML = FALSE)
summary(modelRT)
anova(modelRT)



# Data visualization
# Assuming 'data' is your dataframe
VIA15_data <- VIA15_data %>%
  mutate(condition_status = paste(condition, hgr_status, sep = "_"))


# Define custom colors for each combination
custom_colors <- c("RT_CC_FHR_BP" = "#8cd0db", 
                   "RT_CC_FHR_SZ" = "#00afc2", 
                   "RT_CC_PBC" = "#B3D235", 
                   "RT_IC_FHR_BP" = "#8cd0db", 
                   "RT_IC_FHR_SZ" = "#00afc2", 
                   "RT_IC_PBC" = "#B3D235")

violin_VIA15_RT <- ggplot(VIA15_data, aes(x = hgr_status, y = RT, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = hgr_status, y = RT, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  ylim(200,800)+
  labs(title = "VIA15 Reaction time distribution",x = "Status", y = "Reaction time [ms]") +
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status
# Print the plot
print(violin_VIA15_RT)



### VIA 15 ACCURACY
rm(list=ls())
library(readxl)
getwd
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_23_04.xlsx")
source("/mnt/projects/VIA_MCA/Scripts/Karlijn/R scripts/geom_flat_violin.R")

# Excluding trails with too many errors
ids_to_exclude <- c("25", "73", "97", "129", "138", "141", "180")
VIA15_data <- VIA15_data %>% 
  filter(!id %in% ids_to_exclude)


VIA15_data <- VIA15_data %>%
  gather(key= "condition", value= "ACCURACY", ACC_CON, ACC_INCON) %>%
  convert_as_factor(id, condition)

modelACC <- lmer(ACCURACY ~ age + gender + hgr_status + condition + hgr_status * condition + (1|id), data = VIA15_data, REML = FALSE)
summary(modelACC)
anova(modelACC)

plot(VIA15_data$age,VIA15_data$CV_RT)

VIA15_data <- VIA15_data %>%
  mutate(condition_status = paste(condition, hgr_status, sep = "_"))

# Define custom colors for each combination
custom_colors <- c("ACC_CON_FHR_BP" = "#8cd0db", 
                   "ACC_CON_FHR_SZ" = "#00afc2", 
                   "ACC_CON_PBC" = "#B3D235", 
                   "ACC_INCON_FHR_BP" = "#8cd0db", 
                   "ACC_INCON_FHR_SZ" = "#00afc2", 
                   "ACC_INCON_PBC" = "#B3D235")

violin_VIA15_ACC <- ggplot(VIA15_data, aes(x = hgr_status, y = ACCURACY, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = hgr_status, y = ACCURACY, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  ylim(0.6,1.05)+ 
  labs(title = "VIA15 Accuracy distribution", x = "Status", y = "Accuracy") +
   
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA15_ACC)


### VIA 15 CV

rm(list=ls())
library(readxl)
getwd
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_23_04.xlsx")
source("/mnt/projects/VIA_MCA/Scripts/Karlijn/R scripts/geom_flat_violin.R")

# Excluding trails with too many errors
ids_to_exclude <- c("25", "73", "97", "129", "138", "141", "180")
VIA15_data <- VIA15_data %>% 
  filter(!id %in% ids_to_exclude)


VIA15_data <- VIA15_data %>%
  gather(key= "condition", value= "CV_RT", COV_RT_CC, COV_RT_IC) %>%
  convert_as_factor(id, condition)


modelCV <- lmer(CV_RT ~ age + gender + hgr_status + condition + hgr_status * condition + (1|id), data = VIA15_data, REML = FALSE)
summary(modelCV)
anova(modelCV)

plot(VIA15_data$age,VIA15_data$CV_RT)



# Data visualization
# Assuming 'data' is your dataframe
VIA15_data <- VIA15_data %>%
  mutate(condition_status = paste(condition, hgr_status, sep = "_"))


# Define custom colors for each combination
custom_colors <- c("COV_RT_CC_FHR_BP" = "#8cd0db", 
                   "COV_RT_CC_FHR_SZ" = "#00afc2", 
                   "COV_RT_CC_PBC" = "#B3D235", 
                   "COV_RT_IC_FHR_BP" = "#8cd0db", 
                   "COV_RT_IC_FHR_SZ" = "#00afc2", 
                   "COV_RT_IC_PBC" = "#B3D235")

violin_VIA15_CV <- ggplot(VIA15_data, aes(x = hgr_status, y = CV_RT, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = hgr_status, y = CV_RT, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  ylim(0.05,0.35)+ 
  labs(title = "VIA15 Coefficient of variation (RT) distribution",x = "Status", y = "CV RT") +
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status
  
# Print the plot
print(violin_VIA15_CV)


#######################
#   VIA 11 VS VIA 15  #
#######################

### VIA 11 VS VIA 15 REACTION TIME

# Load data
rm(list=ls())
library(readxl)
getwd
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_23_04.xlsx")
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")


# Excluding trails with too many errors
ids_to_exclude <- c("4", "60", "97", "230", "350")
VIA11_data <- VIA11_data %>% 
  filter(!id %in% ids_to_exclude)

# Excluding trails with too many errors
ids_to_exclude <- c("25", "73", "97", "129", "138", "141", "180")
VIA15_data <- VIA15_data %>% 
  filter(!id %in% ids_to_exclude)

data <- bind_rows(VIA11_data,VIA15_data)


data <- data %>%
  gather(key= "condition", value= "RT", RT_CC, RT_IC) %>%
  convert_as_factor(id, condition)


modelRT <- lmer(RT ~ age + gender + hgr_status + condition + hgr_status * condition + hgr_status *age +(1|id), data = data, REML = FALSE)
summary(modelRT)
anova(modelRT)


### VIA 11 VS VIA 15 ACCURACY

rm(list=ls())
library(readxl)
getwd
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_23_04.xlsx")
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")

# Excluding trails with too many errors
ids_to_exclude <- c("4", "60", "97", "230", "350")
VIA11_data <- VIA11_data %>% 
  filter(!id %in% ids_to_exclude)

# Excluding trails with too many errors
ids_to_exclude <- c("25", "73", "97", "129", "138", "141", "180")
VIA15_data <- VIA15_data %>% 
  filter(!id %in% ids_to_exclude)

VIA11_data <- VIA11_data %>%
  mutate(time_point = "VIA11")

VIA15_data <- VIA15_data %>%
  mutate(time_point = "VIA15")

data <- bind_rows(VIA11_data,VIA15_data)



data <- data %>%
  gather(key= "condition", value= "ACCURACY", ACC_CON, ACC_INCON) %>%
  convert_as_factor(id, condition)

modelACC <- lmer(ACCURACY ~ age + gender + hgr_status + condition + hgr_status * condition +hgr_status *age+ (1|id), data = data, REML = FALSE)
summary(modelACC)
anova(modelACC)

wilcox_test(ACCURACY ~ condition, data = data)
wilcox_test(ACCURACY ~ gender, data = data)
wilcox_test(ACCURACY ~ time_point, data = data)


### VIA 11 VS VIA 15 CVRT

rm(list=ls())
# Load data
library(readxl)
getwd
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_23_04.xlsx")
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")

# Excluding trails with too many errors
ids_to_exclude <- c("4", "60", "97", "230", "350")
VIA11_data <- VIA11_data %>% 
  filter(!id %in% ids_to_exclude)

# Excluding trails with too many errors
ids_to_exclude <- c("25", "73", "97", "129", "138", "141", "180")
VIA15_data <- VIA15_data %>% 
  filter(!id %in% ids_to_exclude)

data <- bind_rows(VIA11_data,VIA15_data)


data <- data %>%
  gather(key= "condition", value= "CV_RT", COV_RT_CC, COV_RT_IC) %>%
  convert_as_factor(id, condition)

modelCV <- lmer(CV_RT ~ age + gender + hgr_status + condition + hgr_status * condition + hgr_status*age + (1|id), data = data, REML = FALSE)
summary(modelCV)
anova(modelCV)


pwc <- data %>%
  group_by(condition) %>%
  pairwise_t_test(CV_RT ~ hgr_status, p.adjust.method = "bonferroni")
pwc

pwc <- data %>%
  group_by(condition) %>%
  pairwise_t_test(CV_RT ~ age, p.adjust.method = "bonferroni")
pwc
