## plot2.R -> plot2.png

## Read files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset 
Baltimore <- NEI[NEI$fips == "24510",]

## Aggregate Emissions by year
annualBaltimoreEmissions <- aggregate(Emissions ~ year, Baltimore, sum)

## Plot 2
png("plot2.png", width = 480, height = 480)
opar <- par(no.readonly = TRUE)
par(mfrow = c(2, 1))
with(annualBaltimoreEmissions, 
			plot(year, Emissions, 
					main = "Scatterplot of Total PM2.5 Emissions in Baltimore(1999~2008)",
					type = "b",  col = "magenta",
					xlab = "Year",
					ylab = "Total PM2.5 Emissions [in Tons]"
					
					)
			)
plot2 <- barplot(annualBaltimoreEmissions$Emissions,
								main = "Barplot of Total PM2.5 Emissions in Baltimore (1999~2008)",
								names.arg = annualBaltimoreEmissions$year,
								xlab = "Year",
								ylab = "Total PM2.5 Emissions [in Tons]",
								ylim = c(0, 4000),
								col = heat.colors(4))
text(plot2, 0, round(annualBaltimoreEmissions$Emissions, 0), cex = .8, pos = 3)
par(opar)
dev.off()