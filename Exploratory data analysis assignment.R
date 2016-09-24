#set your working directory here#
setwd("/Users/aymaneldahrawy/Documents/Coursera/Exploratory data analysis assignment")
getwd()
#read the files#
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Question 1#
NEI_1999 <- subset(NEI,NEI$year==1999)
NEI_2002 <- subset(NEI,NEI$year==2002)
NEI_2005 <- subset(NEI,NEI$year==2005)
NEI_2008 <- subset(NEI,NEI$year==2008)

sum_1999 <- sum(NEI_1999$Emissions)
sum_2002 <- sum(NEI_2002$Emissions)
sum_2005 <- sum(NEI_2005$Emissions)
sum_2008 <- sum(NEI_2008$Emissions)
x <- c(1999,2002,2005,2008)
y <- c(sum_1999,sum_2002,sum_2005,sum_2008)/1000000

rng <- range(y)

png(file="plot1.png")
plot(x,y,ylim = c(0,rng[2]+.5))
title(main = "Total emissions (millions of tons)", xlab = "year" )
dev.off()

#Question 2
balt_1999 <- subset(NEI_1999,NEI$fips=="24510")
balt_2008 <- subset(NEI_2008,NEI$fips=="24510")
sum_balt_1999 <- sum(balt_1999$Emissions,na.rm = TRUE)
sum_balt_2008 <- sum(balt_2008$Emissions,na.rm = TRUE)
x <- c(1999,2008)
y <- c(sum_balt_1999,sum_balt_2008)/1000000
png(file="plot2.png")
plot(x,y)
title(main = "Total emissions (millions of tons) in Baltimore", xlab = "year" )
dev.off()
#Question 3
install.packages("ggplot2")
library(ggplot2)
png(file="plot3.png")
g <- aggregate(Emissions ~ year + type, subset(NEI,fips=="24510"), sum)
graph3 <- ggplot(data=g,aes(y=Emissions,x=year,color=type))
graph3+geom_line()+labs(y="Total PM 2.5 Emissions",title="Total emissions in Baltimore")
dev.off()

#Question 4

str(SCC)
#identify which column holds the combustion-related sources
for (i in (1:length(SCC))){
  x[i] <- sum(grepl(SCC[,i],pattern = "coal"))
}
which(x>1)
#inspect the 2 possible columns containing the label 
SCC$Short.Name[which(grepl(SCC$Short.Name,pattern = "coal")==TRUE)]
SCC$SCC.Level.Three[which(grepl(SCC$SCC.Level.Three,pattern = "coal")==TRUE)]
SCC$coal <- grepl(SCC$Short.Name,pattern = "coal",ignore.case = TRUE)
(SCC$Short.Name[which(coal==TRUE)])
sub_SCC <- subset(SCC,coal==TRUE)
sum(sub_SCC$coal)
#merge data with NEI dataframe
png(file="plot4.png")
merged_data <- merge(NEI,sub_SCC,by = "SCC")
sub_merged <- subset(merged_data,coal==TRUE)
total_coal_emissions <- tapply(sub_merged$Emissions,sub_merged$year,sum)
barplot(total_coal_emissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission from coal sources")
dev.off()
#Question 5
#identify which column holds the combustion-related sources
x <- rep(0,length(SCC))
for (i in (1:length(SCC))){
  x[i] <- sum(grepl(SCC[,i],pattern = "veh",ignore.case=TRUE))
}
y <- which(x>0)

candidates <- rep(0,length(7))
for (i in y) {
  candidates[i] <- sum(grepl(SCC[,i],pattern="veh",ignore.case=TRUE))
}
candidates
#create subset pf data from the subset of pollutants emitted by vehicles

vehicles <-grepl(SCC$SCC.Level.Two,pattern="veh",ignore.case=TRUE)
#merge the new subset of pollutions emitted by vehicles with the baltimore data
sub_SCC2 <- subset(SCC,vehicles==TRUE)
merged_data2 <- merge(subset(NEI,NEI$fips=="24510"), sub_SCC2, by="SCC")
names(merged_data2)
# summing emission data per year per type
totalEmissions <- tapply(merged_data2$Emissions, merged_data2$year, sum)

# plotting
png(file="plot5.png")
barplot(totalEmissions, xlab = "Year", ylab = "Total Emission (ton)", 
        main = "Total Emission from motor vehicle sources in Baltimore")
dev.off()
#Question 6#
vehicles_balt <- merge(subset(NEI,NEI$fips=="24510"), sub_SCC2, by="SCC")
vehicles_cal <- merge(subset(NEI,NEI$fips=="06037"), sub_SCC2, by="SCC")
emissions_balt <- tapply(vehicles_balt$Emissions,vehicles_balt$year,sum)
emissions_cal <- tapply(vehicles_cal$Emissions,vehicles_cal$year,sum)
png(file="plot6.png")
par(mfrow=c(1,2), mar = c(4, 4, 2, 1))
barplot(emissions_balt, xlab = "Year", ylab = "Total Emission (ton) in Baltimore", main = "Total Emission from motor sources)
barplot(emissions_cal, xlab = "Year", ylab = "Total Emission (ton) in LA")
dev.off()
