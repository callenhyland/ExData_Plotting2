## JHU Exploratory Data Analysis
# Course Project 2
# Code for creating Plot 6
# Created by Callen Hyland, March 7, 2022

## Question 6: 
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, CA (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
# Can use any plotting system.

library(dplyr)
library(ggplot2)

# Read data set
NEI <- readRDS("summarySCC_PM25.rds")
codes <- readRDS("Source_Classification_Code.rds")

# get motor vehicle codes
mv.codes <- codes$SCC[grepl("Vehicle", codes$EI.Sector, ignore.case = TRUE)]

# Filter to get just records from Baltimore + LA
balt.mv <- filter(NEI, fips == "24510" & is.element(NEI$SCC, mv.codes))
la.mv <- filter(NEI, fips == "06037" & is.element(NEI$SCC, mv.codes))
rm(NEI, codes) # remove large datasets

# Add a column for city and combine datasets
balt.mv$city <- rep("Baltimore")
la.mv$city <-  rep("Los Angeles")
balt.la.mv <- rbind(balt.mv, la.mv)

# Group by year and city
Total.Em <- balt.la.mv %>%
  group_by(year, city) %>% 
  summarize(sumEm = sum(Emissions))

# Make plots
png("plot6.png", width = 600, height = 480)

ggplot(data = Total.Em, aes(x = year, y = sumEm)) +
  geom_line(aes(color = city)) +
  xlab("Year") + ylab("Emissions (tons)") + 
  ggtitle("Vehicle emissions in Baltimore and LA (1999-2008)") +
  theme(axis.text = element_text(size = 14), 
        axis.title = element_text(size = 16),
        plot.title = element_text(size = 18),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 16))

dev.off()
