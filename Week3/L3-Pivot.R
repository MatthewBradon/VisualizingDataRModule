#CMPU4091 - Visualizing Data

#This script includes an example of working with pivot_longer and pivot_wider

#Install and Load libraries
if (!require("tidyverse")) install.packages("tidyverse", dependencies = TRUE)
if (!require("knitr")) install.packages("knitr", dependencies = TRUE)
if (!require("janitor")) install.packages("janitor", dependencies = TRUE)


library(tidyverse)

# Set up the location of your data file
mydata = file.path("/Users/xsmoked/Desktop/College/Sem2/VisualizingData/Week3/")


#SECTION ONE: Wide to Long
#Working with a dataset which contains Counts of Malaria Cases at facilites
#Each observation in this dataset refers to the malaria counts at one of 65 
#facilities on a given date, ranging from 2020-05-16 to 2020-08-12
#The facilities are located in one Province (North) and four Districts (Spring, Bolo, Dingo, and Barnard).
#The dataset provides the overall counts of malaria, as well as age-specific 
#counts in each of three age groups - <4 years, 5-14 years, and 15 years and older.


# Use file.path to construct the path to your in a form readable to R
malariafile <- file.path(mydata, 'malaria_facility_count_data.rds')
# Read the file into your dataframe (it is .rds so use readRDS)
count_data <- readRDS(malariafile )

# Visualize total Malaria Counts over time
ggplot(count_data) +
  geom_col(aes(x = data_date, y = malaria_tot), width = 1, fill = "steelblue") +
  labs(
    title = "Total Malaria Count from 2020-05-16 to 2020-08-12",
    x = "Date",
    y = "Total Malaria Count"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold", size = 14),
    axis.text.x = element_text(angle = 45, hjust = 1),
    axis.title = element_text(face = "bold")
  )

# Reshape the data from wide to long format using pivot_longer()
# This converts the malaria count columns for different age groups and total count
# into a single column, making it easier for visualization and analysis.
df_long <- count_data %>% 
  pivot_longer(
    cols = c(`malaria_rdt_0-4`, `malaria_rdt_5-14`, `malaria_rdt_15`, `malaria_tot`)
  )

df_long
#Notice this dataframe will have more rows now that the original

# Pivot again but this time give names to the two columns
df_long <- 
  count_data %>% 
  pivot_longer(
    cols = starts_with("malaria_"),
    names_to = "age_group",
    values_to = "counts"
  )

df_long

# Now we can create a stacked bar chart showing malaria counts by age group
# Mapping the new column counts to the y-axis and new column age_group to the fill = argument (the column internal 
# color). 
ggplot(data = df_long) +
  geom_col(
    mapping = aes(x = data_date, y = counts, fill = age_group),
    width = 1
  )

# Filtering out overall malaria total count
df_long %>% 
  filter(age_group != "malaria_tot") %>% 
  ggplot() +
  geom_col(
    aes(x = data_date, y = counts, fill = age_group),
    width = 1
  )

# Now we can create a stacked bar chart showing malaria counts by age group
ggplot(data = df_long) +
  geom_col(
    mapping = aes(x = data_date, y = counts, fill = age_group),
    width = 1
  )

# You could also do it when you do the pivot
df_long <-count_data %>% 
  pivot_longer(
    cols = `malaria_rdt_0-4`:malaria_rdt_15,   # does not include the totals column
    names_to = "age_group",
    values_to = "counts"
  )

#SECTION TWO: LONG TO WIDE
#The dataset contains one row per malaria case presenting with details of the 
#patient (including age group) and their symptoms and the outcome of the case

cleanedlinefile <-file.path(mydata,'linelist_cleaned.rds')
# Read the data into the dataframe
linelist <- readRDS(cleanedlinefile)

#Use pivot_wider to getthe counts of individuals in the different age groups, by gender
df_wide <- 
  linelist %>% 
  count(age_cat, gender)

df_wide


# Create stacked bar chart
ggplot(df_wide) +
  geom_col(aes(x = age_cat, y = n, fill = gender)) +
  labs(
    title = "Total Malaria Count By Age Category and Gender from 2020-05-16 to 2020-08-12",
    x = "Age Category",
    y = "Total Malaria Count"
  )

#Create a table
table_wide <- 
  df_wide %>% 
  pivot_wider(
    id_cols = age_cat,
    names_from = gender,
    values_from = n
  )

table_wide

