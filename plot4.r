
#Read in text data from WD
Data<-read.csv2("./household_power_consumption.txt", na.strings = "?",colClasses=c("character"))
#subset data and replace large file in memory with filtered set
DataDay1<-subset(Data, Date=="1/2/2007")
DataDay2<-subset(Data, Date=="2/2/2007")
Data<-rbind(DataDay1,DataDay2)

#Create a combined datetime formated variable
Data$DateFull<-paste(Data$Date,Data$Time)
Data$DateFull<-strptime(Data$DateFull,"%d/%m/%Y %H:%M:%S")
DateList<-Data$DateFull

#Open connection to 480*480 png file
png(file = "plot4.png", width =480, height =480, bg = "transparent")
#Lay out the plots in a 2x2 matrix
par(mfcol = c(2,2)) 


#Create First Plot(top left)
Data$Global_active_power<-as.numeric(as.character(Data$Global_active_power))
GAP<-Data$Global_active_power
plot(DateList,GAP, type = "l",xlab="",ylab="Global Active Power")

#Create second Plot (bottom left)
Data$Sub_metering_1<-as.numeric(Data$Sub_metering_1)
Data$Sub_metering_2<-as.numeric(Data$Sub_metering_2)
Data$Sub_metering_3<-as.numeric(Data$Sub_metering_3)
Sub_metering_1<-Data$Sub_metering_1
Sub_metering_2<-Data$Sub_metering_2
Sub_metering_3<-Data$Sub_metering_3
plot(DateList,Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(DateList,Sub_metering_2, col="red")
lines(DateList,Sub_metering_3, col="blue")

legend("topright",bty="n",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1), pt.cex=1, cex=0.95)

#Create Third Plot (top right)
Data$Voltage<-as.numeric(Data$Voltage)
Voltage<-Data$Voltage
Voltage
plot(DateList,Voltage, type = "l", xlab = "datetime",ylab="Voltage")

#Create Fourth (final) plot (bottom right)
Data$Global_reactive_power<-as.numeric(Data$Global_reactive_power)
GRP<-Data$Global_reactive_power
plot(DateList,GRP, xlab="datetime",ylab="Global_reactive_power",type="l")

#close connection to the output file
dev.off()