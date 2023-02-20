# Monitoring of ecosystems changes and functioning
# 2022/2023
# Margot Tura

# The goal of this project is to observed how the vegetation cover changed before and after the fire disturbance
# occured in Australia in the period June 2019- May 2020
# To do so, I analyzed the Fcover and the NDVI data from the January 2019, so the beginning of the year, and 
# and from December 2020, at the end of the year
# First of all, we open the packages from our library:

library(ncdf4) 
library(raster) 
library(ggplot2) 
library(RStoolbox) 
library(viridis) 
library(patchwork) 
library(rgdal)

# Now we set our working directory:

setwd("C:/Documenti/Laurea magistrale/Monitoring ecosystems change and functioning/Exam Project")

#NDVI

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

ndvi2019_plot <- ggplot() + geom_raster(Australia_ndvi2019, mapping=aes(x=x, y=y, fill= Normalized.Difference.Vegetation.Index.333M )) + scale_fill_viridis(option="rocket") + ggtitle("NDVI 2019")

#Let's add the legend:
ndvi2019_plot <- ndvi2019_plot + labs(fill= "NDVI")
ndvi2019_plot

# Now we save the new plot
ggsave(filename = "ndvi_2019.png" , plot = ndvi2019_plot)

#2020

ndvi2020_plot <- ggplot() + geom_raster(Australia_ndvi2020, mapping=aes(x=x, y=y, fill= Normalized.Difference.Vegetation.Index.333m )) + scale_fill_viridis(option="rocket") + ggtitle("NDVI 2020")

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

rlist <- list.files(pattern= "ndvi2")
rlist 

import <- lapply(rlist, raster)
import

# Let's stack the data:
ndvistacked <- stack(import)
ndvistacked

# Now for Australia
Australia_ndvistacked <- crop(ndvistacked, Australia)
Australia_ndvistacked

plot(Australia_ndvistacked)

# Now let's look at the difference between the NDVI in 2019 and in 2020

ndvi_difference <- Australia_ndvistacked[[2]]-Australia_ndvistacked[[1]]
ndvi_difference

ndvidifference_plot <- ggplot() + geom_raster(ndvi_difference, mapping=aes(x=x, y=y, fill= layer )) + scale_fill_viridis(option="rocket") + ggtitle("NDVI difference")
ndvidifference_plot

ggsave(filename = "NDVI_difference.png" , plot = ndvidifference_plot)

# Let's look at a graphical representation of the trend of NDVI between 2019 and 2020

ndvitrend <- plot(Australia_ndvi2019, Australia_ndvi2020, xlab="NDVI 2020", ylab="NDVI 2020", main="Trend of NDVI")
abline(0,1, col="red")

##################

#FCOVER

fcover2019 <- raster("fcover2019.nc")
fcover2020 <- raster("fcover2020.nc")

#Let's take a look at our data:

fcover2019
fcover2020

# Now let's crop our data to only look at Australia, using the coordinates
Australia <- c(110, 160, -45, -10) 

Australia_fcover2019 <- crop(fcover2019, Australia)
Australia_fcover2020 <- crop(fcover2020, Australia)

# Let's look at the new data:
Australia_fcover2019
Australia_fcover2020

# Let's plot the graphs
#2019

fcover2019_plot <- ggplot() + geom_raster(Australia_fcover2019, mapping=aes(x=x, y=y, fill= Fraction.of.green.Vegetation.Cover.333m )) + scale_fill_viridis(option="rocket") + ggtitle("FCOVER 2019")

#Let's add the legend:
fcover2019_plot <- fcover2019_plot + labs(fill= "FCOVER")
fcover2019_plot

# Now we save the new plot
ggsave(filename = "fcover_2019.png" , plot = fcover2019_plot)

#2020

fcover2020_plot <- ggplot() + geom_raster(Australia_fcover2020, mapping=aes(x=x, y=y, fill=  )) + scale_fill_viridis(option="rocket") + ggtitle("FCOVER 2020")

#Let's add the legend:
fcover2020_plot <- fcover2020_plot + labs(fill= "FCOVER")
fcover2020_plot

# Now we save the new plot
ggsave(filename = "fcover_2020.png" , plot = fcover2020_plot)

# Now let's look at the plots from 2019 and 2020 together to compare them:

fcover_comparison <- fcover2019_plot + fcover2020_plot
fcover_comparison

ggsave(filename = "fcover_comparison.png" , plot = fcover_comparison)

##############################

# Now let's look at the difference between the year 2019 and 2022:

rlist <- list.files(pattern= "fcover2")
rlist 

import <- lapply(rlist, raster)
import

# Let's stack the data:
fcoverstacked <- stack(import)
fcoverstacked

# Now for Australia
Australia_fcoverstacked <- crop(fcoverstacked, Australia)
Australia_fcoverstacked

plot(Australia_fcoverstacked)

# Now let's look at the difference between the NDVI in 2019 and in 2020

fcover_difference <- Australia_fcoverstacked[[2]]-Australia_fcoverstacked[[1]]
fcover_difference

fcoverdifference_plot <- ggplot() + geom_raster(fcover_difference, mapping=aes(x=x, y=y, fill= layer)) + scale_fill_viridis(option="rocket") + ggtitle("FCOVER difference")
fcoverdifference_plot

ggsave(filename = "FCOVER_difference.png" , plot = fcoverdifference_plot)

# Let's look at a graphical representation of the trend of NDVI between 2019 and 2020

fcovertrend <- plot(Australia_fcover2019, Australia_fcover2020, xlab="FCOVER 2020", ylab="FCOVER 2020", main="Trend of FCOVER")
abline(0,1, col="red")

############

#Finally, let's look at the correlation trend between NDVI and FCOVER:
#2019
trend1 <- plot(Australia_ndvi2019, Australia_fcover2019, xlab="NDVI 2019", ylab="FCOVER 2019", main="2019 trend")
abline(0,1, col="red")

#2020
trend2 <- plot(Australia_ndvi2020, Australia_fcover2020, xlab="NDVI 2020", ylab="FCOVER 2020", main="2020 trend")
abline(0,1, col="red")

#Difference
trend3 <- plot(ndvi_difference, fcover_difference, xlab="NDVI difference", ylab="FCOVER difference", main="Difference trend")
abline(0,1, col="red")



