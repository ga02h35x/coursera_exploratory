# Packages used
  require("data.table")

# Download the data 
  path <- getwd()
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, file.path(path, "data.zip"))
  unzip(zipfile = "data.zip")

# Read the data 
  data_power <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# Alert with scientific notation in histogram
  data_power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Using data format and class
  data_power[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Select the data to process: dates for 2007-02-01 to 2007-02-02
  data <- data_power[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# Create graphic
  png("plot1.png", width=480, height=480)

## Plot 1
  hist( data[, Global_active_power], 
        main="Global Active Power", 
        xlab="Global Active Power (kilowatts)", 
        ylab="Frequency", col="Red")

dev.off()
