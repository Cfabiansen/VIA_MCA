##########################################################################
############ VIA11 ACCURACY REACTION TIME TRADE OFF ANALYSIS #############
##########################################################################

library(magrittr) 
library(dplyr) 
library(tidyverse)
library(ggpubr)
library(rstatix)
library(lme4)
library(lmerTest)
library(readxl)
library(plotly)
# Clear environment
rm(list=ls())


########### VIA 11 CON  ##########


VIA11_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/VIA11_Flanker_everything_N193.xlsx")




# 1. Divide reaction times into quartiles within each group
VIA11_data <- VIA11_data %>%
  group_by(hgr_status) %>%
  mutate(
    RT_quartile = ntile(RT_CC, 4) # Replace 'ReactionTime' with your actual reaction time column
  ) %>%
  ungroup()

# 2. Calculate mean accuracy rates and mean reaction times for each quartile within each group
summary_data <- VIA11_data %>%
  group_by(hgr_status, RT_quartile) %>%
  summarise(
    MeanRT = mean(RT_CC, na.rm = TRUE), # Replace 'ReactionTime' with your actual column name
    MeanAccuracy = mean(ACC_CON_RATE, na.rm = TRUE), # Replace 'Accuracy' with your actual column name
    SEAccuracy = sd(ACC_CON_RATE, na.rm = TRUE) / sqrt(n()), # Replace 'Accuracy' with your actual column name
    .groups = 'drop' # Drop the grouping for further operations
  )

# 3. Plot the accuracy rates as a function of mean reaction time per quartile
fig1<-ggplot(summary_data, aes(x = MeanRT, y = MeanAccuracy, group = hgr_status, color = hgr_status)) +
  geom_line() +
  geom_errorbar(aes(ymin = MeanAccuracy - SEAccuracy, ymax = MeanAccuracy + SEAccuracy), width = 0.1) +
  geom_point(size = 3) +
  theme_bw() +
  xlim(450,710) +
  ylim(55,100) +
  labs(title = "Congruent accuracy",
       x = "Reaction Time [ms]",
       y = "Accuracy [%]") +
  scale_color_manual(values = c("FHR_BP" = "#E49E6A", "FHR_SZ" = "#D6742F", "PBC" = "#B3D235")) # Customize colors as needed







###### VIA11 INCON ##########

VIA11_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/VIA11_Flanker_everything_N193.xlsx")


# 1. Divide reaction times into quartiles within each group
VIA11_data <- VIA11_data %>%
  group_by(hgr_status) %>%
  mutate(
    RT_quartile = ntile(RT_IC, 4) # Replace 'ReactionTime' with your actual reaction time column
  ) %>%
  ungroup()

# 2. Calculate mean accuracy rates and mean reaction times for each quartile within each group
summary_data <- VIA11_data %>%
  group_by(hgr_status, RT_quartile) %>%
  summarise(
    MeanRT = mean(RT_IC, na.rm = TRUE), # Replace 'ReactionTime' with your actual column name
    MeanAccuracy = mean(ACC_INCON_RATE, na.rm = TRUE), # Replace 'Accuracy' with your actual column name
    SEAccuracy = sd(ACC_INCON_RATE, na.rm = TRUE) / sqrt(n()), # Replace 'Accuracy' with your actual column name
    .groups = 'drop' # Drop the grouping for further operations
  )

# 3. Plot the accuracy rates as a function of mean reaction time per quartile
fig2<- ggplot(summary_data, aes(x = MeanRT, y = MeanAccuracy, group = hgr_status, color = hgr_status)) +
  geom_line() +
  geom_errorbar(aes(ymin = MeanAccuracy - SEAccuracy, ymax = MeanAccuracy + SEAccuracy), width = 0.1) +
  geom_point(size = 3) +
  theme_bw() +
  xlim(450,710) +
  ylim(55,100) +
  labs(title = "Incongruent accuracy",
       x = "Reaction Time [ms]",
       y = "Accuracy [%]") +
  scale_color_manual(values = c("FHR_BP" = "#E49E6A", "FHR_SZ" = "#D6742F", "PBC" = "#B3D235")) # Customize colors as needed



######### VIA11 CONGRUENCY EFFECT ACCURACY ########

VIA11_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/VIA11_Flanker_everything_N193.xlsx")

VIA11_data$mean_RT = rowMeans(VIA11_data[, c("RT_CC", "RT_IC")], na.rm = TRUE)

# 1. Divide reaction times into quartiles within each group
VIA11_data <- VIA11_data %>%
  group_by(hgr_status) %>%
  mutate(
    RT_quartile = ntile(mean_RT, 4) # Replace 'ReactionTime' with your actual reaction time column
  ) %>%
  ungroup()


# 2. Calculate mean accuracy rates and mean reaction times for each quartile within each group
summary_data <- VIA11_data %>%
  group_by(hgr_status, RT_quartile) %>%
  summarise(
    MeanRT = mean(mean_RT, na.rm = TRUE), # Replace 'ReactionTime' with your actual column name
    MeanAccuracy = 100*mean(Congruency_effect_ACC, na.rm = TRUE), # Replace 'Accuracy' with your actual column name
    SEAccuracy = 100*sd(Congruency_effect_ACC, na.rm = TRUE) / sqrt(n()), # Replace 'Accuracy' with your actual column name
    .groups = 'drop' # Drop the grouping for further operations
  )

# 3. Plot the accuracy rates as a function of mean reaction time per quartile
fig3<-ggplot(summary_data, aes(x = MeanRT, y = MeanAccuracy, group = hgr_status, color = hgr_status)) +
  geom_line() + 
  geom_errorbar(aes(ymin = MeanAccuracy - SEAccuracy, ymax = MeanAccuracy + SEAccuracy), width = 0.1) +
  geom_point(size = 3) +
  theme_bw() +
  xlim(450,710) +
  ylim(-25,5) +
  labs(title = "Congruency effect of accuracy",
       x = "Reaction Time [ms]",
       y = "Delta accuracy") +
  scale_color_manual(values = c("FHR_BP" = "#E49E6A", "FHR_SZ" = "#D6742F", "PBC" = "#B3D235")) # Customize colors as needed



############# VIA11 CONGRUENCY EFFECT RT ###############

VIA11_data <- read_excel("/mnt/projects/VIA_MCA/nobackup/VIA11_Flanker_everything_N193.xlsx")

VIA11_data$mean_RT = rowMeans(VIA11_data[, c("RT_CC", "RT_IC")], na.rm = TRUE)


# 1. Divide reaction times into quartiles within each group
VIA11_data <- VIA11_data %>%
  group_by(hgr_status) %>%
  mutate(
    RT_quartile = ntile(mean_RT, 4) # Replace 'ReactionTime' with your actual reaction time column
  ) %>%
  ungroup()


# 2. Calculate mean accuracy rates and mean reaction times for each quartile within each group
summary_data <- VIA11_data %>%
  group_by(hgr_status, RT_quartile) %>%
  summarise(
    MeanRT = mean(mean_RT, na.rm = TRUE), # Replace 'ReactionTime' with your actual column name
    MeanAccuracy =mean(Congruency_effect_RT, na.rm = TRUE), # Replace 'Accuracy' with your actual column name
    SEAccuracy = sd(Congruency_effect_RT, na.rm = TRUE) / sqrt(n()), # Replace 'Accuracy' with your actual column name
    .groups = 'drop' # Drop the grouping for further operations
  )

# 3. Plot the accuracy rates as a function of mean reaction time per quartile
fig4<-ggplot(summary_data, aes(x = MeanRT, y = MeanAccuracy, group = hgr_status, color = hgr_status)) +
  geom_line() +
  geom_errorbar(aes(ymin = MeanAccuracy - SEAccuracy, ymax = MeanAccuracy + SEAccuracy), width = 0.1) +
  geom_point(size = 3) +
  theme_bw() +
  xlim(450,710) +
  ylim(55,110) + 
  labs(title = "Congruency effect of reaction time",
       x = "Reaction Time [ms]",
       y = "Delta reaction time") +
  scale_color_manual(values = c("FHR_BP" = "#E49E6A", "FHR_SZ" = "#D6742F", "PBC" = "#B3D235")) # Customize colors as needed



fig <- subplot(fig1, fig2, fig3, fig4, nrows = 2, titleX = TRUE, titleY = TRUE)

# Add individual titles
fig <- fig %>% layout(
  
  title = "",
  annotations = list(
    # Title for the first plot
    list(
      text = "Congruent Accuracy", 
      x = 0.2, y = 1, 
      xref = 'paper', yref = 'paper',
      showarrow = FALSE, xanchor = 'center', yanchor = 'bottom'
    ),
    # Title for the second plot
    list(
      text = "Incongruent Accuracy", 
      x = 0.8, y = 1, 
      xref = 'paper', yref = 'paper',
      showarrow = FALSE, xanchor = 'center', yanchor = 'bottom'
    ),
    # Title for the third plot
    list(
      text = "Congruency Effect of Accuracy", 
      x = 0.2, y = 0.4, 
      xref = 'paper', yref = 'paper',
      showarrow = FALSE, xanchor = 'center', yanchor = 'bottom'
    ),
    # Title for the fourth plot
    list(
      text = "Congruency Effect of Reaction Time", 
      x = 0.8, y = 0.4, 
      xref = 'paper', yref = 'paper',
      showarrow = FALSE, xanchor = 'center', yanchor = 'bottom'
    )
  )
)

fig





