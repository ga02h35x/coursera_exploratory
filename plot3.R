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

# Using POSIXct format and class
  data_power[, DateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Select the data to process: dates for 2007-02-01 to 2007-02-02 (note the time problem)
  data <- data_power[(DateTime >= "2007-02-01") & (DateTime < "2007-02-03")]

# Create graphic
  png("plot3.png", width=480, height=480)

## Plot 3
  plot( data[, DateTime], 
        data[, Sub_metering_1], 
        type="l", 
        xlab="", 
        ylab="Energy sub metering")

  lines( data[, DateTime], 
         data[, Sub_metering_2], 
         col="red" )

  lines( data[, DateTime], 
         data[, Sub_metering_3], 
         col="blue" )

  legend( "topright",
          col=c("black","red","blue"),
          c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
          lty=c(1,1), 
          lwd=c(1,1))

dev.off()
