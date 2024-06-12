####################################
######## VIA11 vs VIA15 model#######
####################################

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

# Load data
library(readxl)
getwd
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_15_04.xlsx")
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_12_04.xlsx")

### Adding time-point
VIA15_data <- VIA15_data %>%
  mutate(time_point = "VIA15")

VIA11_data <- VIA11_data %>%
  mutate(time_point = "VIA11")

### Combining data frames
VIA_data <- bind_rows(VIA11_data,VIA15_data)

### Creating a new conditons row for congruency (combined data)
VIA_data <- VIA_data %>%
  gather(key= "condition_P3", value= "P3_AMP", CON_P3_PZ_AMP, INCON_P3_PZ_AMP) %>%
  convert_as_factor(id, condition_P3)

VIA_data <- VIA_data %>%
  gather(key= "condition_N2", value= "N2_AMP", CON_N2_FCZ_AMP, INCON_N2_FCZ_AMP) %>%
  convert_as_factor(id, condition_N2)

### Creating a new conditons row for congruency (VIA11)
VIA11_data <- VIA11_data %>%
  gather(key= "condition_P3", value= "P3_AMP", CON_P3_PZ_AMP, INCON_P3_PZ_AMP) %>%
  convert_as_factor(id, condition_P3)

VIA11_data <- VIA11_data %>%
  gather(key= "condition_N2", value= "N2_AMP", CON_N2_FCZ_AMP, INCON_N2_FCZ_AMP) %>%
  convert_as_factor(id, condition_N2)

### Creating a new conditons row for congruency (VIA15)
VIA15_data <- VIA15_data %>%
  gather(key= "condition_P3", value= "P3_AMP", CON_P3_PZ_AMP, INCON_P3_PZ_AMP) %>%
  convert_as_factor(id, condition_P3)

VIA15_data <- VIA15_data %>%
  gather(key= "condition_N2", value= "N2_AMP", CON_N2_FCZ_AMP, INCON_N2_FCZ_AMP) %>%
  convert_as_factor(id, condition_N2)

################ Proposed model (VIA11, P3)
modelP3_VIA11 <- lmer(P3_AMP ~ age + gender + hgr_status + condition_P3 + hgr_status * condition_P3 + (1|id), data = VIA11_data, REML = FALSE)
summary(modelP3_VIA11)

anova(modelP3_VIA11)

################ Proposed model (VIA11 N2)
modelN2_VIA11 <- lmer(N2_AMP ~ age + gender + hgr_status + condition_N2 + hgr_status * condition_N2 + (1|id), data = VIA11_data, REML = FALSE)
summary(modelN2_VIA11)

anova(modelN2_VIA11)


################ Proposed model (VIA15, P3)
modelP3_VIA15 <- lmer(P3_AMP ~ age + gender + hgr_status + condition_P3 + hgr_status * condition_P3 + (1|id), data = VIA15_data, REML = FALSE)
summary(modelP3_VIA15)

anova(modelP3_VIA15)

################ Proposed model (VIA11 N2)
modelN2_VIA15 <- lmer(N2_AMP ~ age + gender + hgr_status + condition_N2 + hgr_status * condition_N2 + (1|id), data = VIA15_data, REML = FALSE)
summary(modelN2_VIA15)

anova(modelN2_VIA15)


################ Proposed model (Combined Data P3)
modelP3 <- lmer(P3_AMP ~ age + gender + hgr_status + condition_P3 + hgr_status * condition_P3 + (1|id), data = VIA_data, REML = FALSE)
summary(modelP3)

anova(modelP3)

################ Proposed model (Combined Data N2)
modelN2 <- lmer(N2_AMP ~ age + gender + hgr_status + condition_N2 + hgr_status * condition_N2 + (1|id), data = VIA_data, REML = FALSE)
summary(modelN2)

anova(modelN2)

