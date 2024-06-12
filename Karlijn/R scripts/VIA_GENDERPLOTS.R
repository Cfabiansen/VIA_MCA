###############################################################
###############################################################
###############      VIA GENDERPLOTS           ################
###############################################################
###############################################################

### Loading packages ###

library(magrittr) 
library(dplyr) 
library(plyr)
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

VIA11_data <- VIA11_data %>%
  mutate(gender = factor(gender, levels = c(0, 1), labels = c("Female", "Male")))


# Data visualization
# Assuming 'data' is your dataframe
VIA11_data <- VIA11_data %>%
  mutate(condition_status = paste(condition, gender, sep = "_"))


# Define custom colors for each combination
custom_colors <- c("RT_CC_Female" = "#B2182B", 
                   "RT_CC_Male" = "#4393C3", 
                   "RT_IC_Female" = "#B2182B", 
                   "RT_IC_Male" = "#4393C3")

violin_VIA11_RT <- ggplot(VIA11_data, aes(x = gender, y = RT, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = gender, y = RT, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  labs(title = "VIA11 Reaction time distribution",x = "Gender", y = "Reaction time [ms]") +
  ylim(200,800)+
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA11_RT)



#######################
#        VIA 11       #
#######################

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

VIA11_data <- VIA11_data %>%
  mutate(gender = factor(gender, levels = c(0, 1), labels = c("Female", "Male")))


# Data visualization
# Assuming 'data' is your dataframe
VIA11_data <- VIA11_data %>%
  mutate(condition_status = paste(condition, gender, sep = "_"))


# Define custom colors for each combination
custom_colors <- c("ACC_CON_Female" = "#B2182B", 
                   "ACC_CON_Male" = "#4393C3", 
                   "ACC_INCON_Female" = "#B2182B", 
                   "ACC_INCON_Male" = "#4393C3")

violin_VIA11_RT <- ggplot(VIA11_data, aes(x = gender, y = ACCURACY, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = gender, y = ACCURACY, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  labs(title = "VIA11 Accuracy distribution",x = "Gender", y = "Accuracy") +
  ylim(0.6,1.05)+
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA11_RT)



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

VIA11_data <- VIA11_data %>%
  mutate(gender = factor(gender, levels = c(0, 1), labels = c("Female", "Male")))

VIA11_data <- VIA11_data %>%
  mutate(condition_status = paste(condition, gender, sep = "_"))
# Define custom colors for each combination
custom_colors <- c("COV_RT_CC_Female" = "#B2182B", 
                   "COV_RT_CC_Male" = "#4393C3", 
                   "COV_RT_IC_Female" = "#B2182B", 
                   "COV_RT_IC_Male" = "#4393C3")


violin_VIA11_CV <- ggplot(VIA11_data, aes(x = gender, y = CV_RT, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = gender, y = CV_RT, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  ylim(0.05,0.35)+ 
  labs(title = "VIA11 Coefficient of variation (RT) distribution", x = "Status", y = "CV RT") +
  
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA11_CV)

###############################################################
###############################################################
###############      VIA GENDERPLOTS           ################
###############################################################
###############################################################

### Loading packages ###

library(magrittr) 
library(dplyr) 
library(plyr)
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

VIA15_data <- VIA15_data %>%
  mutate(gender = factor(gender, levels = c(0, 1), labels = c("Female", "Male")))


# Data visualization
# Assuming 'data' is your dataframe
VIA15_data <- VIA15_data %>%
  mutate(condition_status = paste(condition, gender, sep = "_"))


# Define custom colors for each combination
custom_colors <- c("RT_CC_Female" = "brown1", 
                   "RT_CC_Male" = "cyan3", 
                   "RT_IC_Female" = "brown1", 
                   "RT_IC_Male" = "cyan3")

violin_VIA15_RT <- ggplot(VIA15_data, aes(x = gender, y = RT, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = gender, y = RT, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  labs(title = "VIA15 Reaction time distribution",x = "Gender", y = "Reaction time [ms]") +
  ylim(200,800)+
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA15_RT)



#######################
#        VIA 11       #
#######################

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

VIA15_data <- VIA15_data %>%
  mutate(gender = factor(gender, levels = c(0, 1), labels = c("Female", "Male")))


# Data visualization
# Assuming 'data' is your dataframe
VIA15_data <- VIA15_data %>%
  mutate(condition_status = paste(condition, gender, sep = "_"))


# Define custom colors for each combination
custom_colors <- c("ACC_CON_Female" = "brown1", 
                   "ACC_CON_Male" = "cyan3", 
                   "ACC_INCON_Female" = "brown1", 
                   "ACC_INCON_Male" = "cyan3")

violin_VIA15_RT <- ggplot(VIA15_data, aes(x = gender, y = ACCURACY, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = gender, y = ACCURACY, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  labs(title = "VIA15 Accuracy distribution",x = "Gender", y = "Accuracy") +
  ylim(0.6,1.05)+
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA15_RT)



### VIA 11 CVRT

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

VIA15_data <- VIA15_data %>%
  mutate(gender = factor(gender, levels = c(0, 1), labels = c("Female", "Male")))

VIA15_data <- VIA15_data %>%
  mutate(condition_status = paste(condition, gender, sep = "_"))
# Define custom colors for each combination
custom_colors <- c("COV_RT_CC_Female" = "brown1", 
                   "COV_RT_CC_Male" = "cyan3", 
                   "COV_RT_IC_Female" = "brown1", 
                   "COV_RT_IC_Male" = "cyan3")


violin_VIA15_CV <- ggplot(VIA15_data, aes(x = gender, y = CV_RT, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = gender, y = CV_RT, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  ylim(0.05,0.35)+ 
  labs(title = "VIA15 Coefficient of variation (RT) distribution", x = "Status", y = "CV RT") +
  
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA15_CV)



####################################################################################################################################################


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


VIA11_data <- VIA11_data %>%
  mutate(gender = factor(gender, levels = c(0, 1), labels = c("Female", "Male")))

VIA11_data <- VIA11_data %>%
  mutate(condition_status = paste(condition, gender, sep = "_"))
# Define custom colors for each combination
custom_colors <- c("CON_P3_PZ_AMP_Female" = "#B2182B", 
                   "CON_P3_PZ_AMP_Male" = "#4393C3", 
                   "INCON_P3_PZ_AMP_Female" = "#B2182B", 
                   "INCON_P3_PZ_AMP_Male" = "#4393C3")


violin_VIA11_P3 <- ggplot(VIA11_data, aes(x = gender, y = P3, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = gender, y = P3, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
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
gather(key= "condition", value= "N2", CON_N2_FCZ_AMP, INCON_N2_FCZ_AMP) %>%
  convert_as_factor(id, condition)


VIA11_data <- VIA11_data %>%
  mutate(gender = factor(gender, levels = c(0, 1), labels = c("Female", "Male")))

VIA11_data <- VIA11_data %>%
  mutate(condition_status = paste(condition, gender, sep = "_"))
# Define custom colors for each combination
custom_colors <- c("CON_N2_FCZ_AMP_Female" = "#B2182B", 
                   "CON_N2_FCZ_AMP_Male" = "#4393C3", 
                   "INCON_N2_FCZ_AMP_Female" = "#B2182B", 
                   "INCON_N2_FCZ_AMP_Male" = "#4393C3")


violin_VIA11_N2 <- ggplot(VIA11_data, aes(x = gender, y = N2, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = gender, y = N2, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  labs(title = "VIA11 N2 distribution",x = "Status", y = "Amplitude [μV]") +
  ylim(-17,5)+
  
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA11_N2)







#######################
#        VIA 11       #
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


VIA15_data <- VIA15_data %>%
  mutate(gender = factor(gender, levels = c(0, 1), labels = c("Female", "Male")))

VIA15_data <- VIA15_data %>%
  mutate(condition_status = paste(condition, gender, sep = "_"))
# Define custom colors for each combination
custom_colors <- c("CON_P3_PZ_AMP_Female" = "brown1", 
                   "CON_P3_PZ_AMP_Male" = "cyan3", 
                   "INCON_P3_PZ_AMP_Female" = "brown1", 
                   "INCON_P3_PZ_AMP_Male" = "cyan3")


violin_VIA15_P3 <- ggplot(VIA15_data, aes(x = gender, y = P3, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = gender, y = P3, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
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
gather(key= "condition", value= "N2", CON_N2_FCZ_AMP, INCON_N2_FCZ_AMP) %>%
  convert_as_factor(id, condition)


VIA15_data <- VIA15_data %>%
  mutate(gender = factor(gender, levels = c(0, 1), labels = c("Female", "Male")))

VIA15_data <- VIA15_data %>%
  mutate(condition_status = paste(condition, gender, sep = "_"))
# Define custom colors for each combination
custom_colors <- c("CON_N2_FCZ_AMP_Female" = "brown1", 
                   "CON_N2_FCZ_AMP_Male" = "cyan3", 
                   "INCON_N2_FCZ_AMP_Female" = "brown1", 
                   "INCON_N2_FCZ_AMP_Male" = "cyan3")


violin_VIA15_N2 <- ggplot(VIA15_data, aes(x = gender, y = N2, fill = condition_status)) +  # Use combined variable for fill
  geom_flat_violin(aes(fill = condition_status), position = position_nudge(x = 0.255, y = 0), trim = FALSE, alpha = .6, colour = NA, width = 0.7)+ 
  geom_boxplot(aes(x = gender, y = N2, fill = condition_status), show.legend = FALSE, alpha = 1, width = 0.5, colour = "black")+ 
  labs(title = "VIA15 N2 distribution",x = "Status", y = "Amplitude [μV]") +
  ylim(-17,5)+
  
  scale_fill_manual(values = custom_colors)   # Apply custom colors based on combined condition and status

# Print the plot
print(violin_VIA15_N2)




















