## JHU Exploratory Data Analysis
# Course Project 2
# Code for creating Plot 2
# Created by Callen Hyland, March 5, 2022

## Question 2: 
# Have TOTAL emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make
# a plot answering this question.

library(dplyr)

# Read data set
NEI <- readRDS("summarySCC_PM25.rds")

# Filter to get just records from Baltimore
balt <- filter(NEI, fips == "24510")
rm(NEI) # remove large dataset

# Group by year and find sum of each year
Total.Em <- balt %>%
  group_by(year) %>% 
  summarize(sumEm = sum(Emissions))

# Make plot and save as png
png("plot2.png", width = 480, height = 480)

barplot(Total.Em$sumEm, 
        names = Total.Em$year,
        main = "Total PM2.5 Emissions in Baltimore, 1999-2008",
        ylab = "Total PM2.5 Emissions (tons)",
        xlab = "Year")

dev.off()
