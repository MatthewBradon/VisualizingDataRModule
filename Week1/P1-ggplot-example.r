# CMPU4091 Visualising Data
# Week 1 - Getting Started with R
# Run this line by line (CTRl + enter or position the cursor on the relvant line and hit run)


# Preliminaries:

# Install 'tidyverse' package if not installed
if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages("tidyverse")
}


# Load the 'tidyverse' package, which includes various data manipulation and visualization tools
library("tidyverse") # need to install

#SECTION ONE Displaying documentation for the 'mtcars' dataset (Motor Trend Car Road Tests)
# Details will appear in the bottom right-hand pane in RStudio 

# Load datasets from the base R package
data(package="datasets")

# Load datasets from the 'ggplot2' package (included with tidyverse)
data(package="ggplot2")

# Displaying the documentation for the 'mtcars' dataset (Motor Trend Car Road Tests) 
# Details will appear in bottom right hand pane
?mtcars

# Loading the 'mtcars' dataset
data("mtcars")

# Display the first few rows of the 'mtcars' dataset
head(mtcars)

# Display the number of rows in the 'mtcars' dataset
nrow(mtcars)

# Displaying the number of columns in the 'mtcars' dataset
ncol(mtcars)

# Viewing the row names of the 'mtcars' dataset
rownames(mtcars)

# Display the column names of the 'mtcars' dataset
colnames(mtcars)

# Display a statistical summary of the 'mtcars' dataset (min, max, 1st and 3rd quantile, median, mean)
summary(mtcars)

# Display the structure of the 'mtcars' dataset 
str(mtcars)
# Type of Object: The type of the object (data.frame in this case).
# Dimensions: The number of rows and columns (32 rows, 11 columns).
# Column Names: The names of all columns (e.g., mpg, cyl, disp, etc.).
# Data Types: The data type of each column (e.g., numeric, factor, etc.).
# Sample Values: A preview of the first few values for each column.

# Checking the class/type of the 'hp' column in 'mtcars'
class(mtcars$hp)

# Display the 'hp' column values from 'mtcars'
mtcars$hp

# Display just the 'hp' column using square brackets
mtcars['hp']

# Display the entire 'mtcars' dataset
mtcars

# View the 'mtcars' dataset(spreadsheet style)
View(mtcars)
# Allows you to filter and sort the data in the View

# Accessing the 'cyl' column from 'mtcars'
mtcars$cyl

# Displaying the unique values in the 'cyl' column
unique(mtcars$cyl)

# Checking the class/type of the 'cyl' column
class(mtcars$cyl)


# Checking the class/type of the 'gear' column in 'mtcars'
class(mtcars$gear)

# SECTION TWO - Creating BAR CHARTS for the 'cyl' variable of 'mtcars'
# Plots will appear in the right hand pane of RStudio - note, only the last plot created will be displayed
# use the left and right arrows on the Plots plane to move through the plots created

# Create a basic bar plot for the 'cyl' variable
ggplot(mtcars, aes(cyl)) + geom_bar()
#Behavior: The cyl column is treated as a numeric variable (default in mtcars).
#Plot Result: A continuous bar plot is created where the x-axis is treated as 
#a numeric scale (e.g., 4, 6, 8). Gaps may appear between bars, as geom_bar() assumes the x values are continuous.

# Change the fill colour and add a border
ggplot(mtcars, aes(x = factor(cyl))) + 
  geom_bar(fill = "red", color = "black")   # Fill bars with red and add a black border
#fill = "red": This sets the fill color of the bars to red.
#color = "black": This adds a black outline to the bars.
#the colors() function will return a list of available colours (run in the console)

# Add a theme and a title
# Create the bar chart and apply the minimal theme
ggplot(mtcars, aes(cyl)) + 
  geom_bar() + 
  theme_minimal() +
  labs(title = "Bar Chart showing Actual Count of Cars by Cylinders", 
       x = "Number of Cylinders", 
       y = "Count")
#labs(): Adds a title and labels for the x and y axes.
#theme_minimal(): Applies a minimal theme to the plot, removing unnecessary elements and focusing on the data.


# Create the bar chart with different colors for each cylinder category
ggplot(mtcars, aes(x = cyl, fill = factor(cyl))) + 
  geom_bar() + 
  labs(title = "Bar Chart Count of Cars by Cylinders (using different colours)", 
       x = "Number of Cylinders", 
       y = "Count") +
  scale_fill_manual(values = c("red", "blue", "green")) +  # Custom colors for the bars
  theme_minimal()
#fill = factor(cyl): This maps the fill color to the cyl variable, which is treated as a factor. 
#This ensures that each unique cyl value gets a different color.
#scale_fill_manual(values = c("red", "blue", "green")):This function allows you to manually 
#specify the colors for each level of the cyl factor. You can customize the colors to whatever you prefer. In this example, the colors are set to red, blue, and green for the 3 levels of cyl (which are likely 4, 6, and 8).




# Convert the 'cyl' column to a factor for plotting - store in a new variable cyl2 in the dataframe
# A factor is an R data type used to represent categorical variables. 
# Factors are useful when you have a variable with a fixed set of possible values (levels), 
#such as "Male" and "Female" for a gender variable or "Low", "Medium", and "High" for a rating variable

mtcars$cyl2 = as.factor(mtcars$cyl)
#In this case, the number of cylinders (4, 6, 8) will be treated as distinct categories, 
#rather than numeric values

# Create a bar plot again after converting 'cyl' to a factor
ggplot(mtcars, aes(cyl2)) + geom_bar()
#Behavior: The cyl2 column is now treated as a categorical variable (factor).
#Plot Result: A categorical bar plot is created, where the x-axis shows distinct 
#categories (4, 6, 8). Each unique value is treated as a separate category, and 
#bars are evenly spaced.

ggplot(mtcars, aes(x = cyl2, fill = factor(cyl2))) + 
  geom_bar() + 
  labs(title = "Count of Cars by Cylinders (Treated as Categories)", 
       x = "Number of Cylinders", 
       y = "Count") +
  scale_fill_manual(values = c("red", "blue", "green")) +  # Custom colors for the bars
  theme_minimal()

# Using a variable to build a bar chart
# Assign a base plot to a 'p' variable for cyl
p <- ggplot(mtcars, aes(cyl)) 
p <- p + geom_bar() # Add a layer to the plot - a bar chart 
p <- p +   labs(title = "Bar Chart Count of Cars by Cylinders - stored in a variable p", 
                x = "Number of Cylinders", 
                y = "Count")
p # display the variable to display the plot


# SECTION THREE - Creating PIE CHARTS for the 'cyl' variable of 'mtcars'
#Create a PIE CHART of cylinders (using cyl converted to a factor (cyl2))
ggplot(data = mtcars, aes(x = "", fill = cyl2)) + 
  geom_bar(stat = "count", width = 1) + 
  coord_polar(theta = "y") + 
  labs(title = "Distribution of Cylinders in mtcars") 

# The x aesthetic is set to an empty string, ensuring that all bars in the pie chart start from the center of the circle. 
# This is typical when creating pie charts, as it avoids any need for an x-axis.
# fill = cyl2: The fill aesthetic is set to the cyl2 variable (a factor variable representing a different classification of cylinders). 
# This means each slice of the pie chart will be colored based on the values in cyl2 rather than the original cyl variable.
# geom_bar(stat = "count"): This adds a bar chart layer to the plot. Since stat = "count", geom_bar() will count the number of occurrences of each level of cyl2. 
# It creates bars, where each bar corresponds to a level in the cyl2 variable.
# width = 1: This ensures that the bars have no space between them, which is ideal for transforming the bar chart into a pie chart.
# coord_polar(theta = "y"): This transforms the bar chart into a pie chart by applying polar coordinates. The theta = "y" specifies that the size of each section (the angle of the pie slice) will be determined by the y-values, which are the counts of each level of cyl2.
# labs(): This adds a title to the plot. In this case, the title will be "Distribution of Cylinders in mtcars".

# Remove the outer circle showing polar co-ordinates 
ggplot(data = mtcars, aes(x = "", fill = cyl2)) + 
  geom_bar(stat = "count", width = 1) + 
  coord_polar(theta = "y") + 
  labs(title = "Distribution of Cylinders in mtcars") + 
  theme_void()
# Use theme_void() function removes the axis lines, labels, and gridlines

# Create a pie chart displaying the total for each cylinder type in the relevant segment
# First Calculate the count for each 'cyl2' category
cyl_count <- as.data.frame(table(mtcars$cyl2))
colnames(cyl_count) <- c("cyl2", "count")

# Create the pie chart adding text to each segment
ggplot(cyl_count, aes(x = "", y = count, fill = cyl2)) + 
  geom_bar(stat = "identity", width = 1) + 
  coord_polar(theta = "y") + 
  labs(title = "Distribution of Cylinders in mtcars") + 
  theme_void() +
  geom_text(aes(label = paste(cyl2, "\n", count)), 
            position = position_stack(vjust = 0.5), 
            color = "white", fontface = "bold",
            check_overlap = TRUE)  # Prevent text overlap)
#geom_text() function in ggplot2 is used to add text labels to a plot
#You apply aesthetics - here - position, colour and font are set, 
#also forces text not to overlap between segments

# Force the pie chart to use specific colours
ggplot(cyl_count, aes(x = "", y = count, fill = cyl2)) + 
  geom_bar(stat = "identity", width = 1) + 
  coord_polar(theta = "y") + 
  labs(title = "Distribution of Cylinders in mtcars") + 
  theme_void() +
  geom_text(aes(label = paste(cyl2, "\n", count)), 
            position = position_stack(vjust = 0.5), 
            color = "white", fontface = "bold",
            check_overlap = TRUE) +  # Prevent text overlap
  scale_fill_manual(values = c("orange", "blue", "green"))  # Custom colors for the segments


#SECTION FOUR - Creating HISTOGRAMS for the 'cyl' variable of 'mtcars'
# Variable needs to be converted to an integer 
# Creating a histogram for the 'cyl' variable as an integer
ggplot(mtcars, aes(x = as.integer(cyl))) + geom_histogram(bins=3)

# Add meaningful labels and use a theme
ggplot(mtcars, aes(x = as.integer(cyl))) + 
  geom_histogram(bins = 3) +
  labs(title = "Histogram of Cars by Cylinders", 
       x = "Number of Cylinders",  # Renaming the x-axis
       y = "Count of Cars") +      # Adding a label for the y-axis
  theme_linedraw()

# Change the bin width (bin =a range or interval into which the data values are grouped) 
ggplot(mtcars, aes(x = as.integer(cyl))) + 
  geom_histogram(binwidth = 1) +  # Change the bin width to 1
  labs(title = "Histogram of Cars by Cylinders", 
       x = "Number of Cylinders",  # Renaming the x-axis
       y = "Count of Cars") +      # Adding a label for the y-axis
  theme_linedraw()# Using a different theme (linedraw)


# SECTION FIVE  - PRACTICE
# EXERCISE 1
# Create a bar plot to visualize the frequency of different gear types in the mtcars dataset.
# Variable: mtcars$gear
# Map the gear type to the x-axis, and  the count of each type to the y axis
# Add a title to reflect the graph content
# Create a bar plot to visualize the frequency of different gear types in the mtcars dataset
# Map the gear type to the x-axis, and the count of each type to the y-axis

p <- ggplot(mtcars, aes(x = factor(gear)))
p <- p + geom_bar()
p <- p + labs(title = "Frequency of Gear Types in mtcars", x = "Gear Type", y = "Count")

print(p)

# EXERCISE 2
# Convert the gear column into a factor.
# Create the bar plot using this factor.
# Add labels and use a theme
# Experiment with colours

a <- ggplot(mtcars, aes(x = factor(gear)))
a <- a + geom_bar(fill = "red", color = "black")
a <- a + labs(title = "Frequency of Gear Types in mtcars", x = "Gear Type", y = "Count")
a <- a + theme_minimal()

print(a)

# EXERCISE 3
# Create a pie chart of 'mpg' as categories
# Code is provided below to convert it to meaningful categories:

# Convert 'mpg' to a categorical variable based on ranges mpg_category
mtcars$mpg_category <- cut(mtcars$mpg, 
                           breaks = c(10, 20, 30, 40), 
                           labels = c("10-20 mpg", "20-30 mpg", "30-40 mpg"), 
                           right = FALSE)

# Calculate the count for each mpg category
mpg_count <- as.data.frame(table(mtcars$mpg_category))

# Print pie chart


# This will populate a variable mpg_category for each row based on the vaule of mpg
# The cut() function in R is used to categorize continuous data into discrete intervals, or "bins." 
# It takes a numeric vector and divides it into intervals (ranges), assigning each value to a corresponding category or factor level.


# Calculate the count for each mpg category
mpg_count <- as.data.frame(table(mtcars$mpg_category))
colnames(mpg_count) <- c("mpg_category", "count")
# Create a pie chart to visualize mpg (miles per gallon) as categories (mpgcount) 

# Add labels and text


# EXERCISE 3
# Create a histogram to visualize the distribution of hp (horsepower) in the mtcars dataset.
# Set the binwidth to 20.
# Set the fill colour using fill="colour" 
# You can find a list of colours to use by entering the colors() command in the console



# EXERCISE 4
# Experiment with changing colour, labels, binwidth etc for any/all of the above

