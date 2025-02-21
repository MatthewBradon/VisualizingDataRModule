#CMPU4091 - Exploratory Data Analysis
# Using Olympics Dataset

# Load necessary libraries
if (!require("tidyverse")) install.packages("tidyverse", dependencies = TRUE)
if (!require("cowplot")) install.packages("cowplot", dependencies = TRUE)

library(tidyverse)
library(cowplot)

# Load dataset - format the location using file.path to ensure it will locate it correctly
# mydata <- file.path("/Users/xsmoked/Desktop/College/Sem2/VisualizingData/Week3/")
mydata = file.path("C:/Users/Matt/Desktop/VisualizingDataRModule/Week3")
datapath <- file.path(mydata,'Olympics.csv')
df <- read.csv(datapath)

# Filter non-missing Medal data
df <- subset(df, !is.na(Medal))

# Keep top 10 NOCs (National Olympic Committees) in the dataframe
keeplist <- df %>% count(NOC, sort = TRUE) %>% slice(1:10) %>% select(NOC)
df <- df %>% filter(NOC %in% keeplist$NOC)

# Select relevant columns NOC, Year, Season and Medal into the dataframe
df <- df %>% select(NOC, Year, Season, Medal)

# Count medals won per group
df <- df %>%
  group_by(NOC, Year, Season, Medal) %>%
  summarise(Medals_Won = n(), .groups = 'drop')

# Reshape data using pivot_wider to create Medal type columns
adf <- df %>%
  pivot_wider(names_from = Medal, values_from = Medals_Won, values_fill = list(Medals_Won = 0)) %>%
  mutate(total = rowSums(select(., -c(NOC, Year, Season))))

# Apply a log Log transformation
#The total number of medals won can be highly skewed, with some countries winning
# a large number of medals while others win only a few.
# Applying a log transformation makes the distribution more normal-like, 
# making visualizations (e.g., violin plots, histograms) more interpretable.

adf <- adf %>% mutate(logmedals = log1p(total))

# Histograms and Boxplots
ggplot(adf, aes(x=total, na.rm = TRUE)) + 
  geom_histogram(bins=25) +
  labs(x='Total Medals won') + theme_bw()

ggplot(adf, aes(y=total)) + 
  geom_boxplot(fill="slateblue", alpha=0.2) + 
  xlab("Total Medals Won") + theme_classic()

ggplot(adf, aes(x=logmedals, na.rm = TRUE)) + 
  geom_histogram(bins=25) +
  labs(x='Log of Medals won') + theme_bw()

# Explore the impact of the log transformation
ggplot(adf, aes(y=logmedals)) + 
  geom_boxplot(fill="slateblue", alpha=0.2) + 
  xlab("Medals Won") + theme_classic()

# Violin plots
p1 <- ggplot(adf, aes(x = Season, y = logmedals, fill = Season)) +
  geom_violin(alpha = 0.5) +
  labs(title = "Distribution of Medals by Season", x = "Season", y = "Log Medals Won") +
  theme_bw()

p2 <- ggplot(adf, aes(x = NOC, y = logmedals, fill = Season)) +
  geom_violin(alpha = 0.5) +
  labs(title = "Medals Distribution by NOC", x = "NOC", y = "Log Medals Won") +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Arrange plots in a grid
cowplot::plot_grid(p1, p2, labels = c("A", "B"), label_size = 12)


