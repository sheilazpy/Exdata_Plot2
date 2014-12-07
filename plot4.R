## plot4.R -> plot4.png

## Read files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting coal combustion-related sources
coalCombustion <- NEI[NEI$SCC %in% SCC[grep("Coal", SCC$EI.Sector),1], ]
coalCombustionSources <- SCC[, c(1, 4)]
coal <- merge(coalCombustion, coalCombustionSources, by.x = "SCC", by.y = "SCC")[, c(4,6,7)]
## Aggregate by year and EI.Sector
aggreCoal <- aggregate(Emissions ~ year + EI.Sector, coal, sum)

## Plot 4
png("plot4.png", width = 960, height = 480)
library(ggplot2)
g <- ggplot(aggreCoal, aes(x = factor(year), y = Emissions/1000, fill = EI.Sector)) 
g + geom_bar(stat = "identity" ) +
    facet_grid(.~EI.Sector) + 
    guides(fill = guide_legend(title = "Coal Combustion-Related Sources")) +
    xlab("Year") +
    ylab(expression("Total PM"[2.5] * " Emission [in Million Tons]")) +
    ggtitle(expression("Total PM"[2.5] * " Emissions from Coal Combustion-Related Sources (1999 - 2008)"))
dev.off()
