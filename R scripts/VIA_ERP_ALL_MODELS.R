###############################################################
###############################################################
###############    VIA ERP  MIXED MODELS       ################
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
# Clear environment
rm(list=ls())

#######################
#        VIA 11       #
#######################


#### VIA11 P3

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
  gather(key= "condition", value= "P3", CON_P3_PZ_AMP, INCON_P3_PZ_AMP) %>%
  convert_as_factor(id, condition)


modelP3 <- lmer(P3 ~ age + gender + hgr_status + condition + hgr_status * condition + (1|id), data = VIA11_data, REML = FALSE)
anova(modelP3)


## Pairwise t-test
pwc <- VIA11_data %>%
  group_by(condition) %>%
  pairwise_t_test(P3 ~ hgr_status, p.adjust.method = "bonferroni")
pwc

pwc <- VIA11_data %>%
  group_by(condition) %>%
  pairwise_t_test(P3 ~ gender, p.adjust.method = "bonferroni")
pwc

library(psych)
describeBy(VIA11_data,VIA11_data$gender)

pwc <- VIA11_data%>%
  group_by(hgr_status)%>%
  pairwise_t_test(P3 ~ condition, p.adjust.method = "bonferroni")
pwc



# Data visualization
# Assuming 'data' is your dataframe
VIA11_data <- VIA11_data %>%
  mutate(condition_status = paste(condition, hgr_status, sep = "_"))

# Define custom colors for each combination
custom_colors <- c("CON_P3_PZ_AMP_FHR_BP" = "#E49E6A", 
                   "CON_P3_PZ_AMP_FHR_SZ" = "#D6742F", 
                   "CON_P3_PZ_AMP_PBC" = "#B3D235", 
                   "INCON_P3_PZ_AMP_FHR_BP" = "#E49E6A", 
                   "INCON_P3_PZ_AMP_FHR_SZ" = "#D6742F", 
                   "INCON_P3_PZ_AMP_PBC" = "#B3D235")

violin_VIA11_P3 <- ggplot(VIA11_data, aes(x = hgr_status, y = P3, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = hgr_status, y = P3, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  labs(title = "VIA11 P3 distribution",x = "Status", y = "Amplitude [μV]") +
  ylim(-5,20)+
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA11_P3)


#### VIA11 N2

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
  gather(key= "condition", value= "N2", CON_N2_FCZ_AMP, INCON_N2_FCZ_AMP) %>%
  convert_as_factor(id, condition)


modelN2 <- lmer(N2 ~ age + gender + hgr_status + condition + hgr_status * condition + (1|id), data = VIA11_data, REML = FALSE)
anova(modelN2)



## Pairwise t-test
pwc <- VIA11_data %>%
  pairwise_t_test(N2 ~ condition, p.adjust.method = "bonferroni")
pwc

pwc <- VIA11_data %>%
  group_by(condition) %>%
  pairwise_t_test(P3 ~ gender, p.adjust.method = "bonferroni")
pwc



# Data visualization
# Assuming 'data' is your dataframe
VIA11_data <- VIA11_data %>%
  mutate(condition_status = paste(condition, hgr_status, sep = "_"))

# Define custom colors for each combination
custom_colors <- c("CON_N2_FCZ_AMP_FHR_BP" = "#E49E6A", 
                   "CON_N2_FCZ_AMP_FHR_SZ" = "#D6742F", 
                   "CON_N2_FCZ_AMP_PBC" = "#B3D235", 
                   "INCON_N2_FCZ_AMP_FHR_BP" = "#E49E6A", 
                   "INCON_N2_FCZ_AMP_FHR_SZ" = "#D6742F", 
                   "INCON_N2_FCZ_AMP_PBC" = "#B3D235")

violin_VIA11_N2 <- ggplot(VIA11_data, aes(x = hgr_status, y = N2, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = hgr_status, y = N2, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  labs(title = "VIA11 N2 distribution",x = "Status", y = "Amplitude [μV]") +
  ylim(-17,5)+
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA11_N2)












#######################
#        VIA 15       #
#######################


#### VIA15 P3

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
  gather(key= "condition", value= "P3", CON_P3_PZ_AMP, INCON_P3_PZ_AMP) %>%
  convert_as_factor(id, condition)


modelP3 <- lmer(P3 ~ age + gender + hgr_status + condition + hgr_status * condition + (1|id), data = VIA15_data, REML = FALSE)
anova(modelP3)


pwc <- VIA15_data%>%
  group_by(hgr_status)%>%
  pairwise_t_test(P3 ~ condition, p.adjust.method = "bonferroni")
pwc


# Data visualization
# Assuming 'data' is your dataframe
VIA15_data <- VIA15_data %>%
  mutate(condition_status = paste(condition, hgr_status, sep = "_"))

# Define custom colors for each combination
custom_colors <- c("CON_P3_PZ_AMP_FHR_BP" = "#8cd0db", 
                   "CON_P3_PZ_AMP_FHR_SZ" = "#00afc2", 
                   "CON_P3_PZ_AMP_PBC" = "#B3D235", 
                   "INCON_P3_PZ_AMP_FHR_BP" = "#8cd0db", 
                   "INCON_P3_PZ_AMP_FHR_SZ" = "#00afc2", 
                   "INCON_P3_PZ_AMP_PBC" = "#B3D235")

violin_VIA15_P3 <- ggplot(VIA15_data, aes(x = hgr_status, y = P3, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = hgr_status, y = P3, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  labs(title = "VIA15 P3 distribution",x = "Status", y = "Amplitude [μV]") +
  ylim(-5,20)+
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA15_P3)









#### VIA15 N2

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
  gather(key= "condition", value= "N2", CON_N2_FCZ_AMP, INCON_N2_FCZ_AMP) %>%
  convert_as_factor(id, condition)


modelN2 <- lmer(N2 ~ age + gender + hgr_status + condition + hgr_status * condition + (1|id), data = VIA15_data, REML = FALSE)
anova(modelN2)


## Pairwise t-test
pwc <- VIA15_data %>%
  group_by(hgr_status) %>%
  pairwise_t_test(N2 ~ condition, p.adjust.method = "bonferroni")
pwc


# Data visualization
# Assuming 'data' is your dataframe
VIA15_data <- VIA15_data %>%
  mutate(condition_status = paste(condition, hgr_status, sep = "_"))

# Define custom colors for each combination
custom_colors <- c("CON_N2_FCZ_AMP_FHR_BP" = "#8cd0db", 
                   "CON_N2_FCZ_AMP_FHR_SZ" = "#00afc2", 
                   "CON_N2_FCZ_AMP_PBC" = "#B3D235", 
                   "INCON_N2_FCZ_AMP_FHR_BP" = "#8cd0db", 
                   "INCON_N2_FCZ_AMP_FHR_SZ" = "#00afc2", 
                   "INCON_N2_FCZ_AMP_PBC" = "#B3D235")

violin_VIA15_N2 <- ggplot(VIA15_data, aes(x = hgr_status, y = N2, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = hgr_status, y = N2, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  labs(title = "VIA15 N2 distribution",x = "Status", y = "Amplitude [μV]") +
  ylim(-17,5)+
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA15_N2)




#######################
#   VIA 11 VS VIA 15  #
#######################

### VIA 11 VS VIA 15 P3

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

VIA11_data <- VIA11_data %>%
  mutate(time_point = "VIA11")

VIA15_data <- VIA15_data %>%
  mutate(time_point = "VIA15")

data <- bind_rows(VIA11_data,VIA15_data)

data <- data %>%
  gather(key= "condition", value= "P3", CON_P3_PZ_AMP, INCON_P3_PZ_AMP) %>%
  convert_as_factor(id, condition)


modelP3 <- lmer(P3 ~ age + gender + hgr_status + condition + hgr_status * condition + hgr_status*age + (1|id), data = data, REML = FALSE)
anova(modelP3)

pwc <- data%>%
  group_by(hgr_status)%>%
  pairwise_t_test(P3 ~ time_point, p.adjust.method = "bonferroni")
pwc

pwc <- data%>%
  group_by(condition)%>%
  pairwise_t_test(P3 ~ hgr_status, p.adjust.method = "bonferroni")
pwc



### VIA 11 VS VIA 15 N2

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

VIA11_data <- VIA11_data %>%
  mutate(time_point = "VIA11")

VIA15_data <- VIA15_data %>%
  mutate(time_point = "VIA15")

data <- bind_rows(VIA11_data,VIA15_data)

data <- data %>%
  gather(key= "condition", value= "N2", CON_N2_FCZ_AMP, INCON_N2_FCZ_AMP) %>%
  convert_as_factor(id, condition)


modelN2 <- lmer(N2 ~ age + gender + hgr_status + condition + hgr_status * condition + hgr_status*age + (1|id), data = data, REML = FALSE)
anova(modelN2)


pwc <- data%>%
  group_by(hgr_status)%>%
  pairwise_t_test(N2 ~ time_point, p.adjust.method = "bonferroni")
pwc

pwc <- data%>%
  group_by(condition)%>%
  pairwise_t_test(N2 ~ time_point, p.adjust.method = "bonferroni")
pwc


pwc <- data%>%
  group_by(hgr_status)%>%
  pairwise_t_test(N2 ~ condition, p.adjust.method = "bonferroni")
pwc











