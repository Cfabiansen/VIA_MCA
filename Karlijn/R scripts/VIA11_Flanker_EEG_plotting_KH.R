###################################################################
###################### VIA 11 Eriksen Flanker #####################
######################### Plotting EEG Data #######################
###################################################################

# This script is made by Karlijn in April, 2022 for the EEG data analysis of the Flanker task from VIA11



### PACKAGES ###

## install CRAN packages if needed
#pckgs <- c("ggplot2", "systemfonts", "ggforce", 
#"ggdist", "ggbeeswarm", "devtools")
#new_pckgs <- pckgs[!(pckgs %in% installed.packages()[,"Package"])]
#if(length(new_pckgs)) install.packages(new_pckgs)

## install gghalves from GitHub if needed
#if(!require(gghalves)) {  
#devtools::install_github('erocoar/gghalves')
#}

library(magrittr) 
library(dplyr) 
library(tidyverse)
library(tidyquant)
library(ggpubr)
library(rstatix)
library(ggplot2) ## plotting
library(systemfonts) ## custom fonts
library(cowplot)
library(readr)
library(ggforce)
library(ggdist)
library(ggbeeswarm)
library(devtools)

# run script geom_flat_violin.R

###########################
######## BAR PLOTS ########
###########################

####################### N200 ###########################

# load data
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N34_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N34_KH.xlsx")

# Condition (congruent and incongruent) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "amplitude", CON_N2_FCZ, INCON_N2_FCZ) %>%
  convert_as_factor(id, condition)


### Rearrange data
library(reshape2)
data_N200 = melt(data, id.vars = c("CON_N2_FCZ", "INCON_N2_FCZ"))
head(data_N200)

bxp <- ggboxplot(
  data, x = "condition", y = "amplitude",
  color = "fhr_group", palette = c(FHR = "#D6742F", PBC = "#94C01C"))
bxp

bxp <- ggbarplot(
  data, x = "condition", y = "amplitude",
  color = "fhr_group", palette = c(FHR = "#D6742F", PBC = "#94C01C") +
    geom_bar(position = "dodge"))
bxp

barplot_N200= ggplot(data, aes(x="condition", y = "amplitude", group = "fhr_group", fill= "fhr_group")) +
  geom_bar(stat="identity", color="black", position="dodge")
barplot_N200

###########################
##### RAINCLOUD PLOTS #####
###########################


##############
### N = 34 ###
##############

####################### N200 ###########################

# clear environment
rm(list=ls())

# load data
library(readxl)
getwd
data <- read_excel("VIA11_EEG_N34_KH.xlsx")

# Order data, FHR, then PBC
data$fhr_group <- factor(data$fhr_group, levels = c("FHR", "PBC"))

# VIA11 colours to fhr_group
VIA11_colours_N34 <- c(FHR = "#D6742F", PBC = "#94C01C")

# Rename conditions
names(data)[names(data) == "CON_N2_FCZ"] <- "congruent"
names(data)[names(data) == "INCON_N2_FCZ"] <- "incongruent"

# Condition (congruent and incongruent) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "amplitude", congruent, incongruent) %>%
  convert_as_factor(id, condition)

# PLOT 1: vertical
ggp1 <- ggplot(data, aes(x = condition, y = amplitude, fill = fhr_group)) + #geom_flat_violin: alpha = transparancy raincloud plot (0:1), colour = colour of edge plot
  geom_flat_violin(aes(fill = fhr_group),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .9, colour = NA)+ 
  geom_point(aes(x = as.numeric(condition)-.15, y = amplitude, colour = fhr_group), show.legend = FALSE, position = position_jitter(width = .05), size = .9, shape = 16)+ #geom_boxplot: alpha = transparancy box plot (0:1)
  geom_boxplot(aes(x = condition, y = amplitude, fill = fhr_group), show.legend = FALSE, outlier.shape = NA, alpha = 1, width = .15, colour = "black")+
  scale_colour_manual(values = c("#D6742F", "#94C01C"))+
  scale_fill_manual(values = c("#D6742F", "#94C01C"))+
  labs(x = "Condition", y = "Mean amplitude (µV)", fill = "Group") +
  theme_bw() +
  ggtitle("N200 amplitude") +
  theme(plot.title = element_text(hjust = 0.5))
ggp1

# PLOT 2: horizontal (coord_flip)
ggp2 <- ggplot(data, aes(x = condition, y = amplitude, fill = fhr_group)) + #geom_flat_violin: alpha = transparancy raincloud plot (0:1), colour = colour of edge plot
  geom_flat_violin(aes(fill = fhr_group),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .9, colour = NA)+ 
  geom_point(aes(x = as.numeric(condition)-.15, y = amplitude, colour = fhr_group), show.legend = FALSE, position = position_jitter(width = .05), size = .9, shape = 16)+ #geom_boxplot: alpha = transparancy box plot (0:1)
  geom_boxplot(aes(x = condition, y = amplitude, fill = fhr_group), show.legend = FALSE, outlier.shape = NA, alpha = 1, width = .15, colour = "black")+
  scale_colour_manual(values = c("#D6742F", "#94C01C"))+
  scale_fill_manual(values = c("#D6742F", "#94C01C"))+
  labs(x = "Condition", y = "Mean amplitude (µV)", fill = "Group") +
  theme_bw() +
  ggtitle("N200 amplitude") +
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_flip()
ggp2

ggp2 <- ggplot(data, aes(x = condition, y = amplitude, fill = fhr_group)) +
  #geom_flat_violin: alpha = transparancy raincloud plot (0:1), colour = colour of edge plot
  geom_flat_violin(aes(fill = fhr_group),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .8, colour = NA)+ 
  geom_point(aes(x = as.numeric(condition)-.15, y = amplitude, colour = fhr_group),position = position_jitter(width = .05), size = .9, shape = 16)+
  #geom_boxplot: alpha = transparancy box plot (0:1)
  geom_boxplot(aes(x = condition, y = amplitude, fill = fhr_group), position = "dodge2", outlier.shape = NA, alpha = 1, width = .15, colour = "black")+
  scale_colour_manual(values = c("#D6742F", "#94C01C"))+
  scale_fill_manual(values = c("#D6742F", "#94C01C"))+
  labs(x = "Condition", y = "Mean amplitude (µV)") +
  ggtitle("N200 amplitude")+
  theme(plot.title = element_text(hjust = 0.5)) + # center title
  theme_bw() +
  coord_flip() + 
  scale_x_discrete(limits=rev(levels(data$condition)))
ggp2

####################### P3b ###########################

# clear environment
rm(list=ls())

# load data
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N34_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N34_KH.xlsx")

# Order data, FHR, then CON
data$fhr_group <- factor(data$fhr_group, levels = c("FHR", "PBC"))

# VIA11 colours to fhr_group
VIA11_colours_N34 <- c(FHR = "#D6742F", PBC = "#94C01C")

# Rename conditions
names(data)[names(data) == "CON_P3_PZ"] <- "congruent"
names(data)[names(data) == "INCON_P3_PZ"] <- "incongruent"

# Condition (congruent and incongruent) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "amplitude", congruent, incongruent) %>%
  convert_as_factor(id, condition)

# PLOT 3: vertical
ggp3 <- ggplot(data, aes(x = condition, y = amplitude, fill = fhr_group)) + #geom_flat_violin: alpha = transparancy raincloud plot (0:1), colour = colour of edge plot
  geom_flat_violin(aes(fill = fhr_group),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .9, colour = NA)+ 
  geom_point(aes(x = as.numeric(condition)-.15, y = amplitude, colour = fhr_group), show.legend = FALSE, position = position_jitter(width = .05), size = .9, shape = 16)+ #geom_boxplot: alpha = transparancy box plot (0:1)
  geom_boxplot(aes(x = condition, y = amplitude, fill = fhr_group), show.legend = FALSE, outlier.shape = NA, alpha = 1, width = .15, colour = "black")+
  scale_colour_manual(values = c("#D6742F", "#94C01C"))+
  scale_fill_manual(values = c("#D6742F", "#94C01C"))+
  labs(x = "Condition", y = "Mean amplitude (µV)", fill = "Group") +
  theme_bw() +
  ggtitle("P3b amplitude") +
  theme(plot.title = element_text(hjust = 0.5))
ggp3

# PLOT 4: horizontal (coord_flip)
ggp4 <- ggplot(data, aes(x = condition, y = amplitude, fill = fhr_group)) + #geom_flat_violin: alpha = transparancy raincloud plot (0:1), colour = colour of edge plot
  geom_flat_violin(aes(fill = fhr_group),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .9, colour = NA)+ 
  geom_point(aes(x = as.numeric(condition)-.15, y = amplitude, colour = fhr_group), show.legend = FALSE, position = position_jitter(width = .05), size = .9, shape = 16)+ #geom_boxplot: alpha = transparancy box plot (0:1)
  geom_boxplot(aes(x = condition, y = amplitude, fill = fhr_group), show.legend = FALSE, outlier.shape = NA, alpha = 1, width = .15, colour = "black")+
  scale_colour_manual(values = c("#D6742F", "#94C01C"))+
  scale_fill_manual(values = c("#D6742F", "#94C01C"))+
  labs(x = "Condition", y = "Mean amplitude (µV)", fill = "Group") +
  theme_bw() +
  ggtitle("P3b amplitude") +
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_flip()
ggp4




###############
### N = 174 ###
###############

####################### N200 ###########################

# clear environment
rm(list=ls())

# load data
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N174_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N174_KH.xlsx")

# Order data, SZ, BP then K
data$hgr_status <- factor(data$hgr_status, levels = c("FHR_SZ", "FHR_BP", "PBC"))

# VIA11 colours to hgr_status
VIA11_colours <- c(FHR_SZ = "#D6742F", FHR_BP ="#E49E6A", PBC = "#94C01C")

# Rename conditions
names(data)[names(data) == "CON_N2_FCZ"] <- "congruent"
names(data)[names(data) == "INCON_N2_FCZ"] <- "incongruent"

# Condition (congruent and incongruent) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "amplitude", congruent, incongruent) %>%
  convert_as_factor(id, condition)

# PLOT 5: vertical
ggp5 <- ggplot(data, aes(x = condition, y = amplitude, fill = hgr_status)) + 
  #geom_flat_violin: alpha = transparancy raincloud plot (0:1), colour = colour of edge plot
  geom_flat_violin(aes(fill = hgr_status),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .9, colour = NA)+ 
  geom_point(aes(x = as.numeric(condition)-.15, y = amplitude, colour = hgr_status), show.legend = FALSE, position = position_jitter(width = .05), size = .9, shape = 16)+ 
  #geom_boxplot: alpha = transparancy box plot (0:1)
  geom_boxplot(aes(x = condition, y = amplitude, fill = hgr_status), show.legend = FALSE, outlier.shape = NA, alpha = 1, width = .15, colour = "black")+
  scale_colour_manual(values = c("#D6742F", "#E49E6A", "#94C01C"))+
  scale_fill_manual(values = c("#D6742F", "#E49E6A", "#94C01C"))+
  labs(x = "Condition", y = "Mean amplitude (µV)", fill = "Group") +
  theme_bw() +
  ggtitle("N200 amplitude") +
  theme(plot.title = element_text(hjust = 0.5))
ggp5

# PLOT 6: horizontal
ggp6 <- ggplot(data, aes(x = condition, y = amplitude, fill = hgr_status)) + 
  #geom_flat_violin: alpha = transparancy raincloud plot (0:1), colour = colour of edge plot
  geom_flat_violin(aes(fill = hgr_status),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .9, colour = NA)+ 
  geom_point(aes(x = as.numeric(condition)-.15, y = amplitude, colour = hgr_status), show.legend = FALSE, position = position_jitter(width = .05), size = .9, shape = 16)+ 
  #geom_boxplot: alpha = transparancy box plot (0:1)
  geom_boxplot(aes(x = condition, y = amplitude, fill = hgr_status), show.legend = FALSE, outlier.shape = NA, alpha = 1, width = .15, colour = "black")+
  scale_colour_manual(values = c("#D6742F", "#E49E6A", "#94C01C"))+
  scale_fill_manual(values = c("#D6742F", "#E49E6A", "#94C01C"))+
  labs(x = "Condition", y = "Mean amplitude (µV)", fill = "Group") +
  theme_bw() +
  ggtitle("N200 amplitude") +
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_flip()
ggp6


####################### P3b ###########################

# clear environment
rm(list=ls())

# load data
library(readxl)
getwd
data <- read_excel("/mnt/projects/VIAKH/data_tables/VIA11_everything_N174_KH.xlsx")
#data <- read_excel("VIA11_Flanker_everything_N174_KH.xlsx")

# Order data, SZ, BP then K
data$hgr_status <- factor(data$hgr_status, levels = c("FHR_SZ", "FHR_BP", "PBC"))

# VIA11 colours to hgr_status
VIA11_colours <- c(FHR_SZ = "#D6742F", FHR_BP ="#E49E6A", PBC = "#94C01C")

# Rename conditions
names(data)[names(data) == "CON_P3_PZ"] <- "congruent"
names(data)[names(data) == "INCON_P3_PZ"] <- "incongruent"

# Condition (congruent and incongruent) into long format + convert id and condition into factor variables
data <- data %>%
  gather(key= "condition", value= "amplitude", congruent, incongruent) %>%
  convert_as_factor(id, condition)

# PLOT 7: vertical
ggp7 <- ggplot(data, aes(x = condition, y = amplitude, fill = hgr_status)) + 
  #geom_flat_violin: alpha = transparancy raincloud plot (0:1), colour = colour of edge plot
  geom_flat_violin(aes(fill = hgr_status),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .9, colour = NA)+ 
  geom_point(aes(x = as.numeric(condition)-.15, y = amplitude, colour = hgr_status), show.legend = FALSE, position = position_jitter(width = .05), size = .9, shape = 16)+ 
  #geom_boxplot: alpha = transparancy box plot (0:1)
  geom_boxplot(aes(x = condition, y = amplitude, fill = hgr_status), show.legend = FALSE, outlier.shape = NA, alpha = 1, width = .15, colour = "black")+
  scale_colour_manual(values = c("#D6742F", "#E49E6A", "#94C01C"))+
  scale_fill_manual(values = c("#D6742F", "#E49E6A", "#94C01C"))+
  labs(x = "Condition", y = "Mean amplitude (µV)", fill = "Group") +
  theme_bw() +
  ggtitle("P3b amplitude") +
  theme(plot.title = element_text(hjust = 0.5))
ggp7

# PLOT 8: horizontal
ggp8 <- ggplot(data, aes(x = condition, y = amplitude, fill = hgr_status)) + 
  #geom_flat_violin: alpha = transparancy raincloud plot (0:1), colour = colour of edge plot
  geom_flat_violin(aes(fill = hgr_status),position = position_nudge(x = .1, y = 0), adjust = 1.5, trim = FALSE, alpha = .9, colour = NA)+ 
  geom_point(aes(x = as.numeric(condition)-.15, y = amplitude, colour = hgr_status), show.legend = FALSE, position = position_jitter(width = .05), size = .9, shape = 16)+ 
  #geom_boxplot: alpha = transparancy box plot (0:1)
  geom_boxplot(aes(x = condition, y = amplitude, fill = hgr_status), show.legend = FALSE, outlier.shape = NA, alpha = 1, width = .15, colour = "black")+
  scale_colour_manual(values = c("#D6742F", "#E49E6A", "#94C01C"))+
  scale_fill_manual(values = c("#D6742F", "#E49E6A", "#94C01C"))+
  labs(x = "Condition", y = "Mean amplitude (µV)", fill = "Group") +
  theme_bw() +
  ggtitle("P3b amplitude") +
  theme(plot.title = element_text(hjust = 0.5)) +
  coord_flip()
ggp8
