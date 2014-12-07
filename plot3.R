## plot3.R -> plot3.png
library(ggplot2)
## Read files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset 
Baltimore <- NEI[NEI$fips == "24510",]

## Aggregate Emissions by year
annualTypeBaltimoreEmissions <- aggregate(Emissions ~ year + type, Baltimore, sum)
annualTypeBaltimoreEmissions$type <- factor(annualTypeBaltimoreEmissions$type)
## Plot 3
png("plot3.png", width = 960, height = 480)

g <- ggplot(data = annualTypeBaltimoreEmissions,
						aes(x = factor(year), y = Emissions, colour = type, fill = type)) +
		geom_bar(stat = "identity", alpha = 0.5) + facet_grid(.~type)
g  + xlab("Year") +
    ylab(expression("Total PM"[2.5] * " Emission [in Tons]")) +
    ggtitle(expression("Total PM"[2.5] * " Emission from Baltimore City by Type (1999 - 2008)")) 
dev.off()