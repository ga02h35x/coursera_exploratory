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
  png("plot4.png", width=480, height=480)

## Plot 4

  par(mfrow=c(2,2))

  # SubPlot 1
    plot( data[, DateTime], 
          data[, Global_active_power], 
          type="l", xlab="", 
          ylab="Global Active Power")

  # SubPlot 2
    plot( data[, DateTime],
          data[, Voltage], 
          type="l", 
          xlab="datetime", 
          ylab="Voltage")

  # SubPlot 3
    plot( data[, DateTime], 
          data[, Sub_metering_1], 
          type="l", 
          xlab="", 
          ylab="Energy sub metering")
    
    lines( data[, DateTime], 
           data[, Sub_metering_2], 
           col="red")
    
    lines( data[, DateTime], 
           data[, Sub_metering_3],
           col="blue")
    
    legend( "topright", 
            col=c("black","red","blue"),
            c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
            lty=c(1,1),
            bty="n",
            cex=.5) 

    # SubPlot 4
      plot( data[, DateTime], 
            data[,Global_reactive_power], 
            type="l", xlab="datetime", 
            ylab="Global_reactive_power")

dev.off()
