## plot6.R -> plot6.png

## Read files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



## Subsetting data
motorSCC <- SCC[grep("Motor", SCC$Short.Name), 1]
twoCityNEI <- NEI[NEI$fips %in% c( "24510", "06037"), ] #baltimore-"24510",losAngeles-"06037"
twoCityMotor <- twoCityNEI[twoCityNEI$SCC %in% motorSCC,  ]

## Aggregate
annualTwoCityNEI <- aggregate(Emissions ~ year + fips, twoCityMotor, sum)

## Plot 
library(ggplot2)
png("plot6.png", width = 480, height = 480)
g <- ggplot(annualTwoCityNEI, aes(x = year, y = Emissions, colour = fips ))
g + geom_line(size = 2) +
		labs(x="Year", y=" PM2.5 Emissions from Motor[in Tons]") + 
    labs(title = "Annual Emissions by Diffenrent City") +
    scale_colour_discrete(name="City", labels=c("Los Angeles", "Baltimore"))
dev.off()