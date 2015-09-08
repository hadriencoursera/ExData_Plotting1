#download the file

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(fileUrl,destfile="./exdata-data-household_power_consumption.zip")

#Unzip the zip
unzip("./exdata-data-household_power_consumption.zip")


#read the table
table<-read.table("household_power_consumption.txt",header=TRUE,colClasses=c(rep("character",2),rep("numeric",7)),sep=";" ,na.strings = "?")

#select the 1th and 2d of january 2007
table<-table[as.character(table$Date) %in% c("1/2/2007", "2/2/2007"),]

#create a datetime variable
table$dateTime = paste(table$Date, table$Time)

#put the right format for the datetime variable
table$dateTime <- strptime(table$dateTime, "%d/%m/%Y %H:%M:%S")

#delete the date and time variable to have a tidy data
table<-table[,-c(1,2)]


#make the third plot
png("plot3.png", width=480, height=480, units="px")
plot(table$dateTime,table$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(table$dateTime,table$Sub_metering_1,type="l",col="black")
lines(table$dateTime,table$Sub_metering_2,type="l",col="red")
lines(table$dateTime,table$Sub_metering_3,type="l",col="blue")
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
