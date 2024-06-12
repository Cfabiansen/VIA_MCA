###################################################################
###################### VIA 11 Eriksen Flanker #####################
######################### Plotting EEG / BEHA VIA15_data #######################
###################################################################

# This script is made by Karlijn in April, 2022 for the EEG VIA15_data analysis of the Flanker task from VIA11


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


####################### N200 ###########################

# clear environment
rm(list=ls())

# load VIA15_data
library(readxl)
getwd
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_15_04.xlsx")
source("/mnt/projects/VIA_MCA/Scripts/Karlijn/R scripts/geom_flat_violin.R")
ids_to_exclude <- c("25", "73", "97", "129", "138", "141", "180")
VIA15_data <- VIA15_data %>% 
  data <- data %>% 
  filter(!id %in% ids_to_exclude)

# Order VIA15_data, SZ, BP then K
VIA15_data$hgr_status <- factor(VIA15_data$hgr_status, levels = c("FHR_SZ", "FHR_BP", "PBC"))

# VIA15 colours to hgr_status
VIA15_colours <- c(FHR_SZ = "#00afc2", FHR_BP ="#8cd0db", PBC = "#94c01c")

# Rename conditions
names(VIA15_data)[names(VIA15_data) == "CON_N2_FCZ_AMP"] <- "congruent"
names(VIA15_data)[names(VIA15_data) == "INCON_N2_FCZ_AMP"] <- "incongruent"

# Condition (congruent and incongruent) into long format + convert id and condition into factor variables
VIA15_data <- VIA15_data %>%
  gather(key= "condition", value= "amplitude", congruent, incongruent) %>%
  convert_as_factor(id, condition)

# PLOT N200: vertical
ggN200 <- ggplot(VIA15_data, aes(x = condition, y = amplitude, fill = hgr_status)) + 
  #geom_flat_violin: alpha = transparancy raincloud plot (0:1), colour = colour of edge plot
  geom_flat_violin(aes(fill = hgr_status), position = position_nudge(x = .1, y = 0), trim = FALSE, alpha = .4, colour = NA, width = 1)+ 
  #geom_boxplot: alpha = transparancy box plot (0:1)
  geom_boxplot(aes(x = condition, y = amplitude, fill = hgr_status), show.legend = FALSE, alpha = 1, width = .15, colour = "black")+
  scale_colour_manual(values = c("#00afc2", "#8cd0db", "#94C01C"))+
  scale_fill_manual(values = c("#00afc2", "#8cd0db", "#94C01C"))+
  labs(x = "Condition", y = "Mean amplitude (µV)", fill = "Group") +
  theme_bw() +
  ggtitle("N200 amplitude") +
  theme(plot.title = element_text(hjust = 0.5))
ggN200


####################### P300 ###########################

# clear environment
rm(list=ls())

# load VIA15_data
library(readxl)
getwd
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_15_04.xlsx")
source("/mnt/projects/VIA_MCA/Scripts/Karlijn/R scripts/geom_flat_violin.R")
VIA15_data <- VIA15_data %>% drop_na()

# Order VIA15_data, SZ, BP then K
VIA15_data$hgr_status <- factor(VIA15_data$hgr_status, levels = c("FHR_SZ", "FHR_BP", "PBC"))

# VIA15 colours to hgr_status
VIA15_colours <- c(FHR_SZ = "#00afc2", FHR_BP ="#8cd0db", PBC = "#94c01c")

# Rename conditions
names(VIA15_data)[names(VIA15_data) == "CON_P3_PZ_AMP"] <- "congruent"
names(VIA15_data)[names(VIA15_data) == "INCON_P3_PZ_AMP"] <- "incongruent"

# Condition (congruent and incongruent) into long format + convert id and condition into factor variables
VIA15_data <- VIA15_data %>%
  gather(key= "condition", value= "amplitude", congruent, incongruent) %>%
  convert_as_factor(id, condition)

# PLOT P3: vertical
ggp3 <- ggplot(VIA15_data, aes(x = condition, y = amplitude, fill = hgr_status)) + 
  #geom_flat_violin: alpha = transparancy raincloud plot (0:1), colour = colour of edge plot
  geom_flat_violin(aes(fill = hgr_status), position = position_nudge(x = .1, y = 0), trim = FALSE, alpha = .4, colour = NA, width = 1)+ 
  #geom_boxplot: alpha = transparancy box plot (0:1)
  geom_boxplot(aes(x = condition, y = amplitude, fill = hgr_status), show.legend = FALSE, alpha = 1, width = .15, colour = "black")+
  scale_colour_manual(values = c("#00afc2", "#8cd0db", "#94C01C"))+
  scale_fill_manual(values = c("#00afc2", "#8cd0db", "#94C01C"))+
  labs(x = "Condition", y = "Mean amplitude (µV)", fill = "Group") +
  theme_bw() +
  ggtitle("P3 amplitude") +
  theme(plot.title = element_text(hjust = 0.5))
ggp3


####################### ACC ###########################

# clear environment
rm(list=ls())

# load VIA15_data
library(readxl)
getwd
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_15_04.xlsx")
source("/mnt/projects/VIA_MCA/Scripts/Karlijn/R scripts/geom_flat_violin.R")
VIA15_data <- VIA15_data %>% drop_na()

# Order VIA15_data, SZ, BP then K
VIA15_data$hgr_status <- factor(VIA15_data$hgr_status, levels = c("FHR_SZ", "FHR_BP", "PBC"))

# VIA15 colours to hgr_status
VIA15_colours <- c(FHR_SZ = "#00afc2", FHR_BP ="#8cd0db", PBC = "#94c01c")

# Rename conditions
names(VIA15_data)[names(VIA15_data) == "ACC_CON"] <- "congruent"
names(VIA15_data)[names(VIA15_data) == "ACC_INCON"] <- "incongruent"

# Condition (congruent and incongruent) into long format + convert id and condition into factor variables
VIA15_data <- VIA15_data %>%
  gather(key= "condition", value= "amplitude", congruent, incongruent) %>%
  convert_as_factor(id, condition)

# PLOT ACC: vertical
ggACC <- ggplot(VIA15_data, aes(x = condition, y = amplitude, fill = hgr_status)) + 
  #geom_flat_violin: alpha = transparancy raincloud plot (0:1), colour = colour of edge plot
  geom_flat_violin(aes(fill = hgr_status), position = position_nudge(x = .1, y = 0), trim = FALSE, alpha = .4, colour = NA, width = 1)+ 
  #geom_boxplot: alpha = transparancy box plot (0:1)
  geom_boxplot(aes(x = condition, y = amplitude, fill = hgr_status), show.legend = FALSE, alpha = 1, width = .15, colour = "black")+
  scale_colour_manual(values = c("#00afc2", "#8cd0db", "#94C01C"))+
  scale_fill_manual(values = c("#00afc2", "#8cd0db", "#94C01C"))+
  labs(x = "Condition", y = "Accuracy", fill = "Group") +
  theme_bw() +
  ggtitle("Accuracy") +
  theme(plot.title = element_text(hjust = 0.5))
ggACC


####################### RT ###########################
# Clear environment
rm(list=ls())

# Load libraries
library(readxl)
library(tidyr)
library(ggplot2)
source("/mnt/projects/VIA_MCA/Scripts/Karlijn/R scripts/geom_flat_violin.R")
# Load VIA15_data
VIA15_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_15_04.xlsx")
VIA15_data <- VIA15_data %>% drop_na() # Remove NA

# Load VIA11_data
VIA11_data <- read_excel("/mnt/projects/VIA_MCA/VIA11/Clean_VIA11_Flanker_12_04.xlsx")
VIA11_data <- VIA11_data %>% drop_na() # Remove NA

# Order data, SZ, BP then K
VIA15_data$hgr_status <- factor(VIA15_data$hgr_status, levels = c("FHR_SZ", "FHR_BP", "PBC"))
VIA11_data$hgr_status <- factor(VIA11_data$hgr_status, levels = c("FHR_SZ", "FHR_BP", "PBC"))

# VIA15 and VIA11 colours to hgr_status
VIA15_colours <- c(FHR_SZ = "#00afc2", FHR_BP = "#8cd0db", PBC = "#94c01c")
VIA11_colours <- c(FHR_SZ = "#E49E6A", FHR_BP = "#E49E6A", PBC = "#94C01C")

# Rename conditions if needed
names(VIA15_data)[names(VIA15_data) == "CON_P3_PZ_AMP"] <- "congruent"
names(VIA15_data)[names(VIA15_data) == "INCON_P3_PZ_AMP"] <- "incongruent"
names(VIA11_data)[names(VIA11_data) == "CON_P3_PZ_AMP"] <- "congruent"
names(VIA11_data)[names(VIA11_data) == "INCON_P3_PZ_AMP"] <- "incongruent"
# Combine VIA15_data and VIA11_data
combined_data <- rbind(VIA15_data, VIA11_data)
# Check the structure of the combined data frame
str(combined_data)

# Print out the column names
colnames(combined_data)

# Plot for combined_data
ggp3_combined <- ggplot(combined_data, aes(x = condition, y = amplitude, fill = hgr_status)) + 
  geom_flat_violin(aes(fill = hgr_status), position = position_nudge(x = .1, y = 0), trim = FALSE, alpha = .4, colour = NA, width = 1) + 
  geom_boxplot(aes(x = condition, y = amplitude, fill = hgr_status), show.legend = FALSE, alpha = 1, width = .15, colour = "black") +
  scale_fill_manual(values = c(VIA15_colours, VIA11_colours), labels = c("FHR_SZ", "FHR_BP", "PBC", "FHR_SZ", "FHR_BP", "PBC")) +
  labs(x = "Condition", y = "Mean amplitude (µV)", fill = "Group") +
  facet_wrap(~hgr_status, scales = "free", ncol = 2) +  # Facet by hgr_status
  theme_bw() +
  ggtitle("P3 amplitude - VIA11 & VIA15") +
  theme(plot.title = element_text(hjust = 0.5))

# Display combined plot
print(ggp3_combined)