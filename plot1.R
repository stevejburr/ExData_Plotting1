

#Read in all data from WD
#colClass doesn't seem to like numeric for this data so using character (don't want any factors)
Data<-read.csv2("./household_power_consumption.txt", na.strings = "?",colClasses=c("character"))

#subset data and replace large file in memory with filtered set
DataDay1<-subset(Data, Date=="1/2/2007")
DataDay2<-subset(Data, Date=="2/2/2007")
Data<-rbind(DataDay1,DataDay2)

#Make the variable we want to plot numeric
Data$Global_active_power<-as.numeric(as.character(Data$Global_active_power))
#480x480 png export
png(file = "plot1.png", width =480, height =480, bg = "transparent")
#make the plot
with(Data, hist(as.numeric(Global_active_power),col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
#close connection to output file
dev.off()
