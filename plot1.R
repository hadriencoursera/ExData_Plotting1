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

#make the first plot
png("plot1.png", width=480, height=480, units="px")
hist(table$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",col="red")
dev.off()