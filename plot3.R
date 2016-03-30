setwd("/Users/taraxmeyer/Desktop/data_science")
library(data.table)
library(dplyr)

#load and explore the "big" data
system.time(bigdata <- fread("power.txt", sep=";", na.strings = "?", stringsAsFactors = FALSE))
head(data)
str(data)

#subset data
data <- filter(bigdata, grep("^[1,2]/2/2007", Date))

#convert to numeric
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
gr                         <- data$Global_reactive_power
data$Global_active_power   <- as.numeric(as.character(data$Global_active_power))
ga                         <- data$Global_active_power
data$Sub_metering_1        <- as.numeric(as.character(data$Sub_metering_1))
s1                         <- data$Sub_metering_1
data$Sub_metering_2        <- as.numeric(as.character(data$Sub_metering_2))
s2                         <- data$Sub_metering_2
data$Sub_metering_3        <- as.numeric(as.character(data$Sub_metering_3))
s3                         <- data$Sub_metering_3
data$Voltage               <- as.numeric(as.character(data$Voltage))
v                          <- data$Voltage

#combine time and date
data$datetime <- paste(data$Date,data$Time)
when <- strptime(data$datetime,"%d/%m/%Y %H:%M:%S")

####----####

##graphing time! show the submetering in different colors and datetime
plot(when,s1,type="l",xlab="",ylab="Energy_Sub_Metering")
lines(when,s2,type="l",col="red")
lines(when,s3,type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="o",lwd=2.5,lty=,col=c("black","red","blue"))

#save graph to png
dev.copy(png,"plot3.png",width=480,height=480)
dev.off()

##---##
#taraxmeyer
Sys.Date()
##---##