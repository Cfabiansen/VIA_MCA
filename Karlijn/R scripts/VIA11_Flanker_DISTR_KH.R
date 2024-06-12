###################################################################
###################### VIA 11 Eriksen Flanker #####################
################ Distributional analysis EEG Data #################
###################################################################

# This script is made by Karlijn Hendriks in June, 2022 for the distributional analysis of the Flanker task from VIA11

# ANNAŚ THESIS:
# Accuracy rate, mean RT, as well as the congruency effect of RT were
# calculated for each time bin and compared across the three groups 
# with an RM-ANOVA with either accuracy rate, mean RT, or the congruency
# effect as dependent variable and group as between-subject factor
# (FHR-SZ, FHR-BP, PBC). Post hoc multiple comparisons by means of Bonferroni corrections were performed



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


# ! For the N31 dataset, group = fhr_group (FHR or PBC)
# ! For the N171 (?) dataset, group = hgr_status (SZ, BP or K)


