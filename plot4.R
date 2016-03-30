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

##graphing time! the 4 graphs in 1

#set the graphing parameters

png("plot4.png", width=480, height=480)
par(mfcol=c(2,2))

##compare datetime to power consumption 
plot(when,ga,type="l",xlab="", ylab="Global Active Power")

##compare datetime to submeterting (Quadrant LL)
plot(when,s1,type="l",xlab="",ylab ="Energy Sub Metering")
lines(when,s2,type="l",col="red")
lines(when,s3,type="l",col="blue")
legend("topright",c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),lwd=2.5,bty="o",lty=,col=c("black","red","blue"))

##compares datetime and voltage 
plot(when,v,type="l",xlab="datetime",ylab="Voltage")

##plots the datetime and global reactive power
plot(when,gr,type="l",xlab="datetime",ylab="Global_Reactive_Power")

#save graph to png
dev.off()

##---##
#taraxmeyer
Sys.Date()
##---##