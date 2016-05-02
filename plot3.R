################################################################
##
## Exploratory Data Analysis
## Course Project 2
## Olmer Nunez-Sosa
## 2016-04-30
##
################################################################

################################################################
# Data

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

################################################################
#Question 3
#Of the four types of sources indicated by the type (point, nonpoint, onroad, 
#nonroad) variable, which of these four sources have seen decreases in emissions 
#from 1999-2008 for Baltimore City? Which have seen increases in emissions from 
#1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

table(NEI$type[NEI$fips=="24510"])
table(NEI$fips[NEI$fips=="24510"])


#Subsetting to Baltimore ("24510") information
subsetNEI  <- NEI[NEI$fips=="24510", ]
aggregatedTotalByYearAndType <- aggregate(Emissions ~ year + type, subsetNEI, sum)


#Making the plot with ggplot2 plotting system
library("ggplot2")
png("plot3.png", width=640, height=480)
g <- ggplot(aggregatedTotalByYearAndType, aes(year, Emissions, color = type))
g <- g + geom_line() +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions in Baltimore City, Maryland from 1999 to 2008')
print(g)
dev.off()