#Data Preparation

class1 <- read.table(file.choose(), header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

class1$Date <- as.Date(class1$Date, "%d/%m/%Y") ## Format date to Type Date

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
class1 <- subset(class1,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
class1 <- class1[complete.cases(class1),]

## Combine Date and Time column
dateTime <- paste(class1$Date, class1$Time)

## Name the vector
dateTime <- setNames(dateTime, "DateTime")

## Remove Date and Time column
class1 <- class1[ ,!(names(class1) %in% c("Date","Time"))]

## Add DateTime column
class1 <- cbind(dateTime, class1)

## Format dateTime Column
class1$dateTime <- as.POSIXct(dateTime)

#Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(class1, {
  plot(Global_active_power~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dateTime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dateTime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dateTime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

#dev.copy(png, file="plot4.png", height=480, width=480)
#dev.off()