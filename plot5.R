#set your working directory here#
setwd("/Users/aymaneldahrawy/Documents/Coursera/Exploratory data analysis assignment")
#read the files#
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
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