#set your working directory here#
setwd("/Users/aymaneldahrawy/Documents/Coursera/Exploratory data analysis assignment")
#read the files#
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Question 3
install.packages("ggplot2")
library(ggplot2)
png(file="plot3.png")
g <- aggregate(Emissions ~ year + type, subset(NEI,fips=="24510"), sum)
graph3 <- ggplot(data=g,aes(y=Emissions,x=year,color=type))
graph3+geom_line()+labs(y="Total PM 2.5 Emissions",title="Total emissions in Baltimore")
dev.off()
