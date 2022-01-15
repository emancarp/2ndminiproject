plotdata <- read.table("specdata/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
plotdata$Date <- as.Date(plotdata$Date, "%d/%m/%Y")
plotdata <- subset(plotdata,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
plotdata <- plotdata[complete.cases(plotdata),]
dateTime <- paste(plotdata$Date, plotdata$Time)
dateTime <- setNames(dateTime, "DateTime")
plotdata <- plotdata[ ,!(names(plotdata) %in% c("Date","Time"))]
plotdata <- cbind(dateTime, plotdata)
plotdata$dateTime <- as.POSIXct(dateTime)

#==========================================================================
#plot1 - this section creates the histogram using the hist() function
#==========================================================================

png("plot1.png", width = 480, height = 480, units = "px", bg = "white")
hist(plotdata$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.off()


#==========================================================================
#plot 2
#==========================================================================

png("plot2.png", width = 480, height = 480, units = "px", bg = "white")
plot(t$Global_active_power~t$dateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()

#==========================================================================
#plot 3
#==========================================================================
png("plot3.png", width = 480, height = 480, units = "px", bg = "white")
with(t, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

#==========================================================================
#plot 4
#==========================================================================
png("plot4.png", width = 480, height = 480, units = "px", bg = "white")
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(t, {
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
dev.off()




