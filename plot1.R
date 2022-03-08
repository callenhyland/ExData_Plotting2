## JHU Exploratory Data Analysis
# Course Project 2
# Code for creating Plot 1
# Created by Callen Hyland, March 5, 2022

## Question 1: 
# Have total PM2.5 emissions decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the TOTAL PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

library(dplyr)

# Read data set
NEI <- readRDS("summarySCC_PM25.rds")

# Group by year and find sum of each year
Total.Em <- NEI %>%
  group_by(year) %>% 
  summarize(sumEm = sum(Emissions))

# Make plot and save as png
png("plot1.png", width = 480, height = 480)

barplot(Total.Em$sumEm, 
        names = Total.Em$year,
        main = "Total PM2.5 Emissions in the US, 1999-2008",
        ylab = "Total PM2.5 Emissions (tons)",
        xlab = "Year")

dev.off()
