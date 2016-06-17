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

FirstPlot <-function(){
png("plot1.png")
wd<-getwd()
df<-Read_Data()
hist(df$Global_active_power, col="red", main="Global Active Power",xlab="Global Active Power (kilowatts)") # this is the first plot
dev.off()
setwd(wd)
}




