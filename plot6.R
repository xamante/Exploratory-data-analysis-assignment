#set your working directory here#
setwd("/Users/aymaneldahrawy/Documents/Coursera/Exploratory data analysis assignment")
#read the files#
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Question 6#
vehicles_balt <- merge(subset(NEI,NEI$fips=="24510"), sub_SCC2, by="SCC")
vehicles_cal <- merge(subset(NEI,NEI$fips=="06037"), sub_SCC2, by="SCC")
emissions_balt <- tapply(vehicles_balt$Emissions,vehicles_balt$year,sum)
emissions_cal <- tapply(vehicles_cal$Emissions,vehicles_cal$year,sum)
png(file="plot6.png")
par(mfrow=c(1,2), mar = c(4, 4, 2, 1))
barplot( emissions_balt, xlab = "Year", ylab = "Total Emission (ton) in Baltimore", main = "Baltimore")
barplot( emissions_cal, xlab = "Year" , ylab = "Total Emission (ton) in LA",  main = "Los Angeles")
dev.off()
