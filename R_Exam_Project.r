# Monitoring of ecosystems changes and functioning
# 2022/2023
# Margot Tura

# The goal of this project is to observed how the vegetation cover changed before and after the fire disturbance
# occured in Australia in the period June 2019- May 2020
# To do so, I analyzed the Fcover data from the January 2019, so the beginning of the year, and 
# and from December 2020, at the end of the year
# First of all, we open the packages from our library:

library(ncdf4) # reading .nc files
library(raster) # usual package
library(ggplot2) # beautiful plots
library(RStoolbox) # RS functions
library(viridis) # legends - color gamut
library(patchwork) # multiframe for ggplot
library(rgdal) # spatial software - sp package

# Now we set our working directory:

setwd("C:/Documenti/Laurea magistrale/Monitoring ecosystems change and functioning/Exam Project")

ndvi2019 <- raster("ndvi2019.nc")
ndvi2020 <- raster("ndvi2020.nc")

#Let's take a look at our data:

ndvi2019
ndvi2020

# Now let's crop our data to only look at Australia, using the coordinates
Australia <- c(110, 160, -45, -10) 

Australia_ndvi2019 <- crop(ndvi2019, Australia)
Australia_ndvi2020 <- crop(ndvi2020, Australia)

# Let's look at the new data:
Australia_ndvi2019
Australia_ndvi2020

# Let's plot the graphs
#2019

ndvi2019_plot <- ggplot() + geom_raster(Australia_ndvi2019, mapping=aes(x=x, y=y, fill= )) + scale_fill_viridis(option="rocket") + ggtitle("NDVI 2019")

#Let's add the legend:
ndvi2019_plot <- ndvi2019_plot + labs(fill= "NDVI")
ndvi2019_plot

# Now we save the new plot
ggsave(filename = "ndvi_2019.png" , plot = ndvi2019_plot)

#2020

ndvi2020_plot <- ggplot() + geom_raster(Australia_ndvi2020, mapping=aes(x=x, y=y, fill= )) + scale_fill_viridis(option="rocket") + ggtitle("NDVI 2020")

#Let's add the legend:
ndvi2020_plot <- ndvi2020_plot + labs(fill= "NDVI")
ndvi2020_plot

# Now we save the new plot
ggsave(filename = "ndvi_2020.png" , plot = ndvi2020_plot)

# Now let's look at the plots from 2019 and 2020 together to compare them:

ndvi_comparison <- ndvi2019_plot + ndvi2020_plot
ndvi_comparison

ggsave(filename = "ndvi_comparison.png" , plot = ndvi_comparison)

##############################

# Now let's look at the difference between the year 2019 and 2022:

rlist <- list.files(pattern= "ndvi")
rlist 

import <- lapply(rlist, raster)
import

# Let's stack the data:
ndvistacked <- stack(import)
ndvistacked

# Now for Italy
Australia_ndvistacked <- crop(ndvistacked, Italy)
Australia_ndvistacked

plot(Australia_ndvistacked)

# Now let's look at the difference between the NDVI in 2019 and in 2020

ndvi_difference <- Australia_ndvistacked[[2]]-Australia_ndvistacked[[1]]
ndvi_difference

ndvidifference_plot <- ggplot() + geom_raster(ndvi_difference, mapping=aes(x=x, y=y, fill= )) + scale_fill_viridis(option="rocket") + ggtitle("NDVI difference")
ndvidifference_plot

ggsave(filename = "NDVI_difference.png" , plot = ndvidifference_plot)

# Let's look at a graphical representation of the trend of NDVI between 2019 and 2020

dmptrend <- plot(Australia_ndvi2019, Australia_ndvi2020, xlab="NDVI 2020", ylab="NDVI 2020", main="Trend of NDVI")
abline(0,1, col="red")


