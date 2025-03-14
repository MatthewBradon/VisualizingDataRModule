# Load necessary libraries
library(ggplot2)
library(dplyr)
library(readr)
library(stringr)

# Load the dataset
df <- read_csv("C:/Users/Matt/Desktop/VisualizingDataRModule/FYP/full_translation_scores.csv")

# Convert 'Parameters' to a factor for better visualization
df$Parameters <- factor(df$Parameters, levels = df$Parameters)

# Wrap long labels for readability
df$Parameters <- str_wrap(df$Parameters, width = 50)

# Plot BLEU Score with rotated labels
p1 <- ggplot(df, aes(x = Parameters, y = `Helsinki-NLP BLEU Score`, fill = "Helsinki-NLP")) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_bar(aes(y = `Fine-tuned Model BLEU Score`, fill = "Fine-tuned Model"), stat = "identity", position = "dodge") +
  labs(title = "Comparison of BLEU Scores",
       x = "Translation Settings",
       y = "BLEU Score") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + # Rotate labels
  scale_fill_manual(values = c("Helsinki-NLP" = "blue", "Fine-tuned Model" = "red")) +
  coord_flip() # Swap axes to make it more readable

# Plot METEOR Score with rotated labels
p2 <- ggplot(df, aes(x = Parameters, y = `Helsinki-NLP METEOR Score`, fill = "Helsinki-NLP")) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_bar(aes(y = `Fine-tuned Model METEOR Score`, fill = "Fine-tuned Model"), stat = "identity", position = "dodge") +
  labs(title = "Comparison of METEOR Scores",
       x = "Translation Settings",
       y = "METEOR Score") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + # Rotate labels
  scale_fill_manual(values = c("Helsinki-NLP" = "blue", "Fine-tuned Model" = "red")) +
  coord_flip() # Swap axes for better readability

# Print plots
print(p1)
print(p2)
