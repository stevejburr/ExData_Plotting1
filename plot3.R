
#Read in text data from WD
Data<-read.csv2("./household_power_consumption.txt", na.strings = "?",colClasses=c("character"))

#subset data and replace large file in memory with filtered set
DataDay1<-subset(Data, Date=="1/2/2007")
DataDay2<-subset(Data, Date=="2/2/2007")
Data<-rbind(DataDay1,DataDay2)

#Combine Date and Time columns and convert to datetime format
Data$DateFull<-paste(Data$Date,Data$Time)
Data$DateFull<-strptime(Data$DateFull,"%d/%m/%Y %H:%M:%S")
DateList<-Data$DateFull

#Produce numeric vectors of each column we wish to plot
Data$Sub_metering_1<-as.numeric(Data$Sub_metering_1)
Data$Sub_metering_2<-as.numeric(Data$Sub_metering_2)
Data$Sub_metering_3<-as.numeric(Data$Sub_metering_3)
Sub_metering_1<-Data$Sub_metering_1
Sub_metering_2<-Data$Sub_metering_2
Sub_metering_3<-Data$Sub_metering_3

#Output the plot as 480*480 .png file
png(file = "plot3.png", width =480, height =480, bg = "transparent")
#Set up plot with correct lables, plot the first line
plot(DateList,Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
#Add the second line and colour red
lines(DateList,Sub_metering_2, col="red")
#Add the third and final line and make it blue
lines(DateList,Sub_metering_3, col="blue")
#Put a legend in the top right hand corner with correct colours
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))
#Close connection to output file
dev.off()