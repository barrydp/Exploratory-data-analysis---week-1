# Save current path, then set new path to where the data is
oldpath <- getwd()
path <- "C:\\Coursera\\DataScientist\\Exploratory Data Analysis\\Week 1\\exdata_data_household_power_consumption"
setwd(path)

#  Read in the original data
mData <- read.table("household_power_consumption.txt", sep=";", stringsAsFactor=FALSE, header=TRUE, fill=TRUE)

#  Get only the rows we're interested in
x <- subset(mData, as.Date(mData$Date, "%d/%m/%Y") >= "2007-02-01" & as.Date(mData$Date,"%d/%m/%Y") <= "2007-02-02")

#  Get rid of superfluous data to free up memory
rm(mData)

# Get rid of ? (NA) in x
x <- subset(x, x$Global_active_power != "?")

# Get new column with date/time as a date object
x$DateTime <- sprintf("%s %s", x$Date, x$Time)
x$DateTime <- as.POSIXct(x$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Set the graphics device to png
png(file = "plot3.png",
    width = 480,
    height = 480, 
    units = "px", 
    pointsize = 12,
    bg = "white",
    )

#  Draw the plot
# First draw the empty frame
plot(x$DateTime, as.numeric(x$Sub_metering_1),
     ylab = "Energy sub metering",
     xlab = "",
     type = "n"
     )
# Add the three different meterings plots
lines(x$DateTime, as.numeric(x$Sub_metering_1),col="black")
lines(x$DateTime, as.numeric(x$Sub_metering_2),col="red")
lines(x$DateTime, as.numeric(x$Sub_metering_3),col="blue")
# Add legend
legend("topright", pch = "-", col = c("black", "red", "blue"), legend = c("Sub Metering 1", "Sub metering 2", "Sub metering 3"))

# Switch graphics device back to screen and reset path
dev.off()
setwd(oldpath)