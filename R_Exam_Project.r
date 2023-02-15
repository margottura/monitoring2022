# Monitoring of ecosystems changes and functioning
# 2022/2023
# Margot Tura

# First, I downloaded data from copernicus about Dry Mass Productivity DMP 300m 
# and about the NDVI 300m
# The goal of the analysis is to see how the DMP and the NDVI changed during 
# the last 8 years in Italy
# To do so, I analyzed the data from January 2014 (the oldest avaliable) 
# and January 2023 (the latest available)

# Let's open the packages we need from our library:

library(ncdf4) # reading .nc files
library(raster) # usual package
library(ggplot2) # beautiful plots
library(RStoolbox) # RS functions
library(viridis) # legends - color gamut
library(patchwork) # multiframe for ggplot
library(rgdal) # spatial software - sp package

# Now we set our working directory:

setwd("C:/Documenti/Laurea magistrale/Monitoring ecosystems change and functioning/Exam Project")

# And we assign our data to a variable:

dmp_2014 <- raster("dmp2014.nc")
dmp_2023 <- raster("dmp2023.nc")

ndvi_2014 <- raster("ndvi2014.nc")
ndvi_2023 <- raster("ndvi2023.nc")

lai_2014 <- raster("lai2014.nc")
lai_2023 <- raster("lai2023.nc")

# Let's start with DMP for the year 2014:
# Let's take a look at our data

dmp_2014

# Let's only look at the data from Italy, by using the geographical coordinates as the minimum and maximum x and y:

Italy <- c(6, 21, 36, 48) 

italydmp2014 <- crop(dmp_2014, Italy)

italydmp2014

# Let's plot the graph of 2014 for Italy

italydmp2014_plot <- ggplot() + geom_raster(italydmp2014, mapping=aes(x=x, y=y, fill= Dry.matter.productivity.333M )) + scale_fill_viridis(option="rocket") + ggtitle("DMP 2014 Italy")
italydmp2014_plot <- italydmp2014_plot + labs(fill= "DMP")
italydmp2014_plot

# Now we save the new plot
ggsave(filename = "global_DMP_2014_Italy.png" , plot = italydmp2014_plot)

# Let's repeat everything for the DMP for the year 2023:

italydmp2023 <- crop(dmp_2023, Italy)

italydmp2023

italydmp2023_plot <- ggplot() + geom_raster(italydmp2023, mapping=aes(x=x, y=y, fill= Dry.Matter.Productivity.333m )) + scale_fill_viridis(option="rocket") + ggtitle("DMP 2023 Italy")
italydmp2023_plot <- italydmp2023_plot + labs(fill= "DMP")
italydmp2023_plot

ggsave(filename = "global_DMP_2023_Italy.png" , plot = italydmp2023_plot)

# Now let's look at the DMP plots from 2014 and 2023 together to compare them:

Italy_DMP_comparison <- italydmp2014_plot + italydmp2023_plot
Italy_DMP_comparison

ggsave(filename = "Italy_DMP_comparison.png" , plot = Italy_DMP_comparison)

# Now let's look at the difference between the year 2014 and 2022:

rlist <- list.files(pattern= "dmp2")
rlist 

import <- lapply(rlist, raster)
import

# Let's stack the data:
dmpstacked <- stack(import)
dmpstacked

# Now for Italy
italydmpstacked <- crop(dmpstacked, Italy)
italydmpstacked

plot(italydmpstacked)

# Now let's look at the difference between DMP in 2014 and in 2023

Italy_DMP_difference <- italydmpstacked[[2]]-italydmpstacked[[1]]
Italy_DMP_difference

italydmpdifference_plot <- ggplot() + geom_raster(Italy_DMP_difference, mapping=aes(x=x, y=y, fill=layer )) + scale_fill_viridis(option="rocket") + ggtitle("DMP Italy difference")
italydmpdifference_plot

ggsave(filename = "DMP_Italy_difference.png" , plot = italydmpdifference_plot)

# Let's look at a graphical representation of the trend of DMP between 2014 and 2023

dmptrend <- plot(italydmp2014, italydmp2023, xlab="Italy DMP 2014", ylab="Italy DMP 2023", main="Trend of Italy DMP")
abline(0,1, col="red")

# Now let's do the same for the NDVI data
# Let's start with NDVI for the year 2014:
# Let's take a look at our data

ndvi_2014

# Now we only look at Italy:
Italy <- c(6, 21, 36, 48) 

italyndvi2014 <- crop(ndvi_2014, Italy)
italyndvi2014

# Let's plot the graph of 2014 for Italy

italyndvi2014_plot <- ggplot() + geom_raster(italyndvi2014, mapping=aes(x=x, y=y, fill= Normalized.Difference.Vegetation.Index.333M )) + scale_fill_viridis(option="rocket") + ggtitle("NDVI 2014 Italy")
italyndvi2014_plot <- italyndvi2014_plot + labs(fill= "NDVI")
italyndvi2014_plot

# Now we save the new plot
ggsave(filename = "global_NDVI_2014_Italy.png" , plot = italyndvi2014_plot)

# Let's repeat everything for the NDVI for the year 2023:

ndvi_2023

italyndvi2023 <- crop(ndvi_2023, Italy)
italyndvi2023

# Let's plot the graph of 2023 for Italy

italyndvi2023_plot <- ggplot() + geom_raster(italyndvi2023, mapping=aes(x=x, y=y, fill= Normalized.Difference.Vegetation.Index.333m )) + scale_fill_viridis(option="rocket") + ggtitle("NDVI 2023 Italy")
italyndvi2023_plot <- italyndvi2023_plot + labs(fill= "NDVI")
italyndvi2023_plot

# Now we save the new plot
ggsave(filename = "global_NDVI_2023_Italy.png" , plot = italyndvi2023_plot) 


# Now let's look at the NDVI plots from 2014 and 2023 together to compare them:
Italy_NDVI_comparison <- italyndvi2014_plot + italyndvi2023_plot
Italy_NDVI_comparison

ggsave(filename = "Italy_NDVI_comparison.png" , plot = Italy_NDVI_comparison)

# Now let's look at the difference between the year 2014 and 2022:

rlist <- list.files(pattern= "ndvi")
rlist 

import <- lapply(rlist, raster)
import

# Let's stack the data:

dnvistacked <- stack(import)
ndvistacked

# For Italy:
italyndvistacked <- crop(ndvistacked, Italy)
italyndvistacked

plot(italyndvistacked)

# Now let's look at the difference between NDVI in 2014 and in 2023


Italy_NDVI_difference <- italyndvistacked[[2]]-italyndvistacked[[1]]
Italy_NDVI_difference

italyndvidifference_plot <- ggplot() + geom_raster(Italy_NDVI_difference, mapping=aes(x=x, y=y, fill=layer )) + scale_fill_viridis(option="rocket") + ggtitle("NDVI Italy difference")
italyndvidifference_plot

ggsave(filename = "NDVI_Italy_difference.png" , plot = italyndvidifference_plot)

# Let's look at the trend of NDVI during the years:

ndvitrend <- plot(italyndvi2014, italyndvi2023, xlab="Italy NDVI 2014", ylab="Italy NDVI 2023", main="Trend of Italy NDVI")
abline(0,1, col="red")

# Now let's do the same for the LAI data
# Let's start with LAI for the year 2014:
# Let's take a look at our data

lai_2014

# Now we only look at Italy:
Italy <- c(6, 21, 36, 48) 

italylai2014 <- crop(lai_2014, Italy)
italylai2014

# Let's plot the graph of 2014 for Italy

italylai2014_plot <- ggplot() + geom_raster(italylai2014, mapping=aes(x=x, y=y, fill= Leaf.Area.Index.333m )) + scale_fill_viridis(option="rocket") + ggtitle("LAI 2014 Italy")
italylai2014_plot <- italylai2014_plot + labs(fill= "LAI")
italylai2014_plot

# Now we save the new plot
ggsave(filename = "global_LAI_2014_Italy.png" , plot = italylai2014_plot)

# Let's repeat everything for the NDVI for the year 2023:

lai_2023

italylai2023 <- crop(lai_2023, Italy)
italylai2023

# Let's plot the graph of 2023 for Italy

italylai2023_plot <- ggplot() + geom_raster(italylai2023, mapping=aes(x=x, y=y, fill= Leaf.Area.Index.333m )) + scale_fill_viridis(option="rocket") + ggtitle("LAI 2023 Italy")
italylai2023_plot <- italylai2014_plot + labs(fill= "LAI")
italylai2023_plot

# Now we save the new plot
ggsave(filename = "global_LAI_2023_Italy.png" , plot = italylai2023_plot) 


# Now let's look at the NDVI plots from 2014 and 2023 together to compare them:
Italy_LAI_comparison <- italylai2014_plot + italylai2023_plot
Italy_LAI_comparison

ggsave(filename = "Italy_LAI_comparison.png" , plot = Italy_LAI_comparison)

# Now let's look at the difference between the year 2014 and 2022:

rlist <- list.files(pattern= "lai")
rlist 

import <- lapply(rlist, raster)
import

# Let's stack the data:

laistacked <- stack(import)
laistacked

# For Italy:
italylaistacked <- crop(laistacked, Italy)
italylaistacked

plot(italylaistacked)

# Now let's look at the difference between LAI in 2014 and in 2023


Italy_LAI_difference <- italylaistacked[[2]]-italylaistacked[[1]]
Italy_LAI_difference

italylaidifference_plot <- ggplot() + geom_raster(Italy_LAI_difference, mapping=aes(x=x, y=y, fill=layer )) + scale_fill_viridis(option="rocket") + ggtitle("LAI Italy difference")
italylaidifference_plot

ggsave(filename = "LAI_Italy_difference.png" , plot = italylaidifference_plot)

# Let's look at the trend of LAI during the years:

laitrend <- plot(italylai2014, italylai2023, xlab="Italy LAI 2014", ylab="Italy LAI 2023", main="Trend of Italy LAI")
abline(0,1, col="red")

# Now we can look at the correlation trand between DMP and NDVI:
# For 2014

DNVI_DMP_trend_first <- plot(italyndvi2014, italydmp2014, xlab="Italy NDVI 2014", ylab="Italy DMP 2014", main="Trend of NDVI and DMP 2014")
abline(0,1, col="red")

# For 2023
DNVI_DMP_trend_second <- plot(italyndvi2023, italydmp2023, xlab="Italy NDVI 2023", ylab="Italy DMP 2023", main="Trend of NDVI and DMP 2023")
abline(0,1, col="red")

# Let's also look at the correlation between DMP and LAI:
# For 2014

LAI_DMP_trend_first <- plot(italylai2014, italydmp2014, xlab="Italy LAI 2014", ylab="Italy DMP 2014", main="Trend of LAI and DMP 2014")
abline(0,1, col="red")

# For 2023
LAI_DMP_trend_second <- plot(italylai2023, italydmp2023, xlab="Italy LAI 2023", ylab="Italy DMP 2023", main="Trend of LAI and DMP 2023")
abline(0,1, col="red")

# Finally, let's also look at the correlation between LAI and NDVI:
# For 2014

LAI_NDVI_trend_first <- plot(italyndvi2014, italylai2014, xlab="Italy NDVI 2014", ylab="Italy LAI 2014", main="Trend of LAI and NDVI 2014")
abline(0,1, col="red")

# For 2023
LAI_NDVI_trend_second <- plot(italyndvi2023, italylai2023, xlab="Italy NDVI 2023", ylab="Italy LAI 2023", main="Trend of LAI and NDVI 2023")
abline(0,1, col="red")

