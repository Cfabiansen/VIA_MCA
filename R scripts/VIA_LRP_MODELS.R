###############################################################
###############################################################
###############    VIA LRP MIXED MODELS       ################
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


#### VIA11 Peak to Peak

rm(list=ls())
library(readxl)
getwd
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_30_05.xlsx")
source("/mnt/projects/VIA_MCA/Scripts/Karlijn/R scripts/geom_flat_violin.R")

# Excluding trails with too many errors
ids_to_exclude <- c("4", "60", "97", "230", "350")
VIA11_data <- VIA11_data %>% 
  filter(!id %in% ids_to_exclude)


VIA11_data <- VIA11_data %>%
  gather(key= "condition", value= "P2P", CON_peaktopeak, INCON_peaktopeak) %>%
  convert_as_factor(id, condition)


modelRT <- lmer(P2P ~ age + gender + hgr_status + condition + hgr_status * condition + (1|id), data = VIA11_data, REML = FALSE)
summary(modelRT)
anova(modelRT)


library(psych)
describeBy(VIA11_data$CON_peaktopeak,VIA11_data$hgr_status)

plot(VIA11_data$CON_P3_PZ_AMP,VIA11_data$CON_peaktopeak)


#### VIA11 Positive Peak

rm(list=ls())
library(readxl)
getwd
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_30_05.xlsx")
source("/mnt/projects/VIA_MCA/Scripts/Karlijn/R scripts/geom_flat_violin.R")

# Excluding trails with too many errors
ids_to_exclude <- c("4", "60", "97", "230", "350")
VIA11_data <- VIA11_data %>% 
  filter(!id %in% ids_to_exclude)


VIA11_data <- VIA11_data %>%
  gather(key= "condition", value= "PP", CON_PP, INCON_PP) %>%
  convert_as_factor(id, condition)


modelRT <- lmer(PP ~ age + gender + hgr_status + condition + hgr_status * condition + (1|id), data = VIA11_data, REML = FALSE)
summary(modelRT)
anova(modelRT)



#### VIA11 Negative Peak

rm(list=ls())
library(readxl)
getwd
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_30_05.xlsx")
source("/mnt/projects/VIA_MCA/Scripts/Karlijn/R scripts/geom_flat_violin.R")

# Excluding trails with too many errors
ids_to_exclude <- c("4", "60", "97", "230", "350")
VIA11_data <- VIA11_data %>% 
  filter(!id %in% ids_to_exclude)


VIA11_data <- VIA11_data %>%
  gather(key= "condition", value= "NP", CON_NP, INCON_NP) %>%
  convert_as_factor(id, condition)


modelRT <- lmer(NP ~ age + gender + hgr_status + condition + hgr_status * condition + (1|id), data = VIA11_data, REML = FALSE)
summary(modelRT)
anova(modelRT)


#######################
#   VIA 11 VS VIA 15  #
#######################

### VIA 11 VS VIA 15 Peak to Peak

# Load data
rm(list=ls())
library(readxl)
getwd
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_30_05.xlsx")
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_30_05.xlsx")


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
  gather(key= "condition", value= "P2P", CON_peaktopeak, INCON_peaktopeak) %>%
  convert_as_factor(id, condition)


modelRT <- lmer(P2P ~ age + gender + hgr_status + condition + hgr_status * condition + hgr_status *age +(1|id), data = data, REML = FALSE)
summary(modelRT)
anova(modelRT)


### VIA 11 VS VIA 15 Positive Peak

# Load data
rm(list=ls())
library(readxl)
getwd
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_30_05.xlsx")
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_30_05.xlsx")


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
  gather(key= "condition", value= "PP", CON_PP, INCON_PP) %>%
  convert_as_factor(id, condition)


modelRT <- lmer(PP ~ age + gender + hgr_status + condition + hgr_status * condition + hgr_status *age +(1|id), data = data, REML = FALSE)
summary(modelRT)
anova(modelRT)





### VIA 11 VS VIA 15 Negative Peak

# Load data
rm(list=ls())
library(readxl)
getwd
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_30_05.xlsx")
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_30_05.xlsx")


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
  gather(key= "condition", value= "NP", CON_NP, INCON_NP) %>%
  convert_as_factor(id, condition)


modelRT <- lmer(NP ~ age + gender + hgr_status + condition + hgr_status * condition + hgr_status *age +(1|id), data = data, REML = FALSE)
summary(modelRT)
anova(modelRT)



