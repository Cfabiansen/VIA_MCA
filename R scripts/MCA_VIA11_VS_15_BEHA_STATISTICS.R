###############################################################
###############################################################
############### VIA11 VS 15 BEHA STATISTICS ###################
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

# Load data
library(readxl)
getwd
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_23_04.xlsx")
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_23_04.xlsx")

### Adding time-point
VIA15_data <- VIA15_data %>%
  mutate(time_point = "VIA15") %>%
  select(-Comments)

VIA11_data <- VIA11_data %>%
  mutate(time_point = "VIA11")

### Combining data frames
data <- bind_rows(VIA11_data,VIA15_data)

#### Pairwise comparisons between group levels

# CONGRUENT RT
pwc <- data %>%
  group_by(hgr_status) %>%
  pairwise_t_test(RT_CC ~ time_point, p.adjust.method = "bonferroni")
pwc

# INCONGRUENT RT
pwc <- data %>%
  group_by(hgr_status) %>%
  pairwise_t_test(RT_IC ~ time_point, p.adjust.method = "bonferroni")
pwc


# CONGRUENT ACCURACY
pwc <- data %>%
  group_by(hgr_status) %>%
  pairwise_t_test(ACC_CON ~ time_point, p.adjust.method = "bonferroni")
pwc

# INCONGRUENT ACCURACY
pwc <- data %>%
  group_by(hgr_status) %>%
  pairwise_t_test(ACC_INCON ~ time_point, p.adjust.method = "bonferroni")
pwc








