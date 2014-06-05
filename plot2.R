#Read in text data from work directory
Data<-read.csv2("./household_power_consumption.txt", na.strings = "?",colClasses=c("character"))
#subset data and replace large file in memory with filtered set
DataDay1<-subset(Data, Date=="1/2/2007")
DataDay2<-subset(Data, Date=="2/2/2007")
Data<-rbind(DataDay1,DataDay2)

#Create a numeric vector for Global_active_power
Data$Global_active_power<-as.numeric(as.character(Data$Global_active_power))
GAP<-Data$Global_active_power

#Combine the time and date columns and convert to a Datetime format
Data$DateFull<-paste(Data$Date,Data$Time)
Data$DateFull<-strptime(Data$DateFull,"%d/%m/%Y %H:%M:%S")
DateList<-Data$DateFull

#Export plot to 480x480 .png file
png(file = "plot2.png", width =480, height =480, bg = "transparent")
#Plot a scatter plot of the data
plot(DateList,GAP, type = "l", xlab = "", ylab= "Global Active Power (kilowatts)")
#Close connection to output file
dev.off()
