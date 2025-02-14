library(datasets) # Package included with base R

# Access the Anscombe's quartet dataset
data(anscombe)


# Create separate plots for each dataset
par(mfrow = c(2, 2))  # Set up a 2x2 grid for plotting

# Plot 1
plot(anscombe$x1, anscombe$y1, main = "Dataset 1", xlab = "x1", ylab = "y1")
abline(lm(y1 ~ x1, data = anscombe), col = "red", lwd = 2)

# Plot 2
plot(anscombe$x2, anscombe$y2, main = "Dataset 2", xlab = "x2", ylab = "y2")
abline(lm(y2 ~ x2, data = anscombe), col = "blue", lwd = 2)

# Plot 3
plot(anscombe$x3, anscombe$y3, main = "Dataset 3", xlab = "x3", ylab = "y3")
abline(lm(y3 ~ x3, data = anscombe), col = "green", lwd = 2)

# Plot 4
plot(anscombe$x4, anscombe$y4, main = "Dataset 4", xlab = "x4", ylab = "y4")
abline(lm(y4 ~ x4, data = anscombe), col = "purple", lwd = 2)
