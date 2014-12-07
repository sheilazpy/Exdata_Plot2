## plot1.R -> plot1.png

## Read files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Aggregate Emissions by year
annualEmissions <- aggregate(Emissions ~ year, NEI, sum)

## Plot 
png("plot1.png")
opar <- par(no.readonly = TRUE)
par(mfrow = c(2, 1))
with(annualEmissions, 
			plot(year, Emissions/1000000, 
					main = "Scatterplot of Total PM2.5 Emissions in US(1999~2008)",
					type = "b", col = "red",
					xlab = "Year",
					ylab = "Total PM2.5 Emissions [in Million Tons]"
			))
	
plot1 <- barplot(annualEmissions$Emissions/1000000,
								main = "Barplot of Total PM2.5 Emissions in US(1999~2008)",
								names.arg = annualEmissions$year,
								xlab = "Year",
								ylab = "Total PM2.5 Emissions [in Million Tons]",
								ylim = c(0, 8),
								col = rainbow(10, start = 0, end = 1, alpha = 0.5))
text(plot1, 0, round(annualEmissions$Emissions, 0), cex = .8, pos = 3)
par(opar)
dev.off()
