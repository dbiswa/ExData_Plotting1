# Download data set, household_power_consumption.txt.
# Use awk in command line (in the directory containing household_power_consumption.txt) to extract the header, and data corresponding to dates 2007-02-01 and 2007-02-02 from household_power_consumption.txt data set
# awk -F";" 'FNR == 1 || $1 ~ /^1\/2\/2007/ || $1 ~ /^2\/2\/2007/' household_power_consumption.txt > subset.txt
# The above command thus, created a suitable subset (subset.txt) from the original data set.
# Assuming the working directory contains subset.txt, commands below can be used to generated required plots. 
# use read.csv2 to read semicolon (;) delimited file, subset.txt
hpc <- read.csv2(file="subset.txt", header = TRUE, stringsAsFactors = FALSE)
# combined Date and Time to a single datetime object
hpc$Date  <- with(hpc, as.POSIXct(paste(as.Date(Date, format="%d/%m/%Y"), Time)))
# remove Time column from the data frame hpc
hpc <- hpc [, -2]
# load library magrittr
library(magrittr)
# convert the character classes to numeric
hpc[, c(2:8)] %<>% lapply(function(x) as.numeric(x))

# Command to generate Plot2.png
# Open a png plot device to create Plot2.png with a width of 480 pixels and a height of 480 pixels
png(file = "Plot2.png", width = 480, height = 480, units = "px")
# use par command to set the number of rows and columns with mfrow, background (transparent is default), and margin
par(mfrow = c(1,1), bg = "transparent", mar = c(4,4,2,1))
# command to generate plot
with(hpc, plot(Date, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "", main = NULL))
dev.off()