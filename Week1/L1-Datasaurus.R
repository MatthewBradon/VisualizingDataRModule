# Install and load required libraries
library(datasauRus) # install.packages("datasauRus")
library(tidyverse)  # install.packages("tidyverse")

# Access the dinosaur and star datasets
data(datasaurus_dozen)

# Filter the data for the "dino" dataset
dino_data <- datasaurus_dozen %>% 
  filter(dataset == "dino")

# Filter the data for the "star" dataset
star_data <- datasaurus_dozen %>% 
  filter(dataset == "star")

# Create the dinosaur plot
dino_plot <- ggplot(dino_data, aes(x = x, y = y)) +
  geom_point(color = "blue") +
  labs(
    title = "Dinosaur Plot",
    x = "x",
    y = "y"
  )

# Create the star plot
star_plot <- ggplot(star_data, aes(x = x, y = y)) +
  geom_point(color = "gold") +
  labs(
    title = "Star Plot",
    x = "x",
    y = "y"
  )

# Load patchwork for combining plots
library(patchwork)

# Combine and display the plots side by side
dino_plot + star_plot
plot(dino_plot+star_plot)
