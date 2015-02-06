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

# Set the graphics device to png
png(file = "plot1.png",
    width = 480, 
    height = 480, 
    units = "px", 
    pointsize = 12,
    bg = "white",
    )

#  Draw the histogram
hist(as.numeric(x$Global_active_power), 
     col="red", 
     xlab = "Global Active Power (kilowats)",
     main = "Global Active Power"
     )

# Switch graphics device back to screen
dev.off()
setwd(oldpath)