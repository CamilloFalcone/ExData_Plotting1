Read_Data<- function() {
	datapath<-"/Users/camillof/Data/"
setwd(datapath)
df1 <- read.csv ("household_power_consumption.txt", sep=";", nrow=1)
command <- "egrep -w '1/2/2007|2/2/2007' household_power_consumption.txt > hpc.txt" #produces the file with the subset with the row required
system(command) # run the egrp command
#redefine the names of the columns in df according to df1
df<-read.csv("hpc.txt",sep=";") 
colnames(df)<- names(df1)
df$Date<-as.Date(df$Date, format="%d/%m/%Y")
df$Time<-strptime(df$Time, format="%H:%M:%S")
df <- cbind(df, weekdays(df$Date)) #add a column with the name of the week

return(df)
}

FirstPlot <-function(df){
#df<-Read_Data()
hist(df$Global_active_power, col="red", main="Global Active Power",xlab="Global Active Power (kilowatts)") # this is the first plot
}

#######
SecondPlot <-function(df){
# df<-Read_Data()
NumRow<- dim(df)[1]
plot(df$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", axes=FALSE, xlab="") #this is the second..change the x axis labels
atx<-c(0, NumRow/2,NumRow)
labx= c("Thu", "Fri", "Sat")
aty<- seq(0, 6, 2)
laby <- seq(0, 6, 2)
axis (1, atx, labx)
axis (2, aty, laby)
box()
}

#######this is the third plot
ThirdPlot <- function(df) {
#df<-Read_Data()
NumRow<- dim(df)[1]
plot(df$Sub_metering_1, axes=FALSE, xlab="", ylab="Energy sub metering",type="l")
lines(df$Sub_metering_2, col="red")
lines(df$Sub_metering_3, col="blue")
atx<-c(0, NumRow/2,NumRow)
labx= c("Thu", "Fri", "Sat")
aty<- seq(0, 30, 10)
laby <- seq(0, 30, 10)
axis (1, atx, labx)
axis (2, aty, laby)
box()
legend("topright", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
}

VoltagePlot<- function(df) {
	NumRow<- dim(df)[1]
plot(df$Voltage, type="l", ylab="Voltage", axes=FALSE, xlab="") #this is the second..change the x axis labels
atx<-c(0, NumRow/2,NumRow)
labx= c("Thu", "Fri", "Sat")
aty<- seq(234, 246, 2)
laby <- c(234,"",238,"",242,"",246)
axis (1, atx, labx)
axis(2, aty, laby)
mtext("datetime", 1, line=3)

box()
}


GlobalReactivePlot<- function(df) {
NumRow<- dim(df)[1]
plot(df$Global_reactive_power, type="l", ylab="Global Reactive Power", axes=FALSE, xlab="") 
atx<-c(0, NumRow/2,NumRow)
labx= c("Thu", "Fri", "Sat")
aty<- seq(0.0, 0.5, 0.1)
laby <- seq(0.0, 0.5, 0.1)
axis (1, atx, labx)
axis(2, aty, laby)
mtext("datetime", 1, line=3)
box()
}



#####
FourthPlot <- function() {
png("plot4.png")
wd<-getwd()
df<-Read_Data()
par(mfrow = c(2,2), mar = c(4,4,2,2))
SecondPlot(df)
VoltagePlot(df)
#plot(df$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", axes=FALSE, xlab="") 
ThirdPlot(df)
GlobalReactivePlot(df)
dev.off()
setwd(wd)
}

