## plot5.R -> plot5.png

## Read files 
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subsetting data
motorSCC <- SCC[grep("Motor", SCC$Short.Name), 1]
baltimoreNEI <- NEI[NEI$fips %in% c( "24510"), ]
baltimoreMotor <-  baltimoreNEI[baltimoreNEI$SCC %in% motorSCC,  ]

## Aggregate
annualBaltimoreMotor <- aggregate(Emissions ~ year, baltimoreMotor, sum)

# Plot 5

png("plot5.png", width = 480, height = 480)
opar <- par(no.readonly = TRUE)
par( mfrow= c(2,1))
plot(annualBaltimoreMotor$year, annualBaltimoreMotor$Emissions, 
		type="b", ylab="Total Emissions[in Tons]", xlab="Year", col = "blue",
		main="Annual PM2.5 Emissions in Baltimore From Motor Vehicle(1999~2008)")

plot5 <- barplot(annualBaltimoreMotor$Emissions,
								main = "Annual PM2.5 Emissions in Baltimore From Motor Vehicle(1999~2008)",
								names.arg = annualBaltimoreMotor$year,
								xlab = "Year",
								ylab = "Total Emissions [in Tons]",
								col = rainbow(10, start = 0, end = 1, alpha = 0.5))
text(plot5, 0, round(annualBaltimoreMotor$Emissions, 0), cex = .8, pos = 3)
par(opar)
dev.off()