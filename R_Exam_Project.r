# Monitoring of ecosystems changes and functioning
# 2022/2023
# Margot Tura

# First, I downloaded data from copernicus about Dry Mass Productivity
# DMP 300m V1
# The goal of the analysis is to see how the DMP changed during 
# the last 8 years in Italy
# To do so, I analyzed the data from the 10/01/2014 (the oldest data available)
# and from the 10/01/2023 (the latest data available)


# First of all, we install the packages we need:

install.packages("raster")
install.packages("ggplot2")
install.packages("RStoolbox")
install.packages("viridis")
install.packages("patchwork")
install.packages("ncdf4")

# Then we open the packages from our library:

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
# Let's take a look at our data

dmp_2014

globaldmp2014 <- ggplot() + geom_raster(dmp_2014, mapping=aes(x=x, y=y, fill=Dry.matter.productivity.333M)) + scale_fill_viridis(option="rocket") + ggtitle("DMP 2014")

globaldmp2014

# Now let's add the legend

globaldmp2014 <- globaldmp2014 + labs(fill= "DMP")
globaldmp2014

# We can export and save the plot by using the ggsave function:
ggsave(filename = "global_DMP_2022.png" , plot = globaldmp2014)

# Now we crop the graph to only look at Italy
# By using the geographical coordinates as the 
# minimum and maximum x and y:

Italy <- c(6, 21, 36, 48) 

italydmp2014 <- crop(dmp_2014, Italy)

italydmp2014

# Let's plot the graph of 2022 for Italy

italydmp2014_plot <- ggplot() + geom_raster(italydmp2014, mapping=aes(x=x, y=y, fill= Dry.matter.productivity.333M )) + scale_fill_viridis(option="rocket") + ggtitle("DMP 2014 Italy")

# Let's also add the legend

italydmp2014_plot <- italydmp2014_plot + labs(fill= "DMP")
italydmp2014_plot

# Now we save the new plot
ggsave(filename = "global_DMP_2014_Italy.png" , plot = italydmp2014_plot)

# Now we repeat everything for the year 2023:

dmp_2023

globaldmp2023 <- ggplot() + geom_raster(dmp_2023, mapping=aes(x=x, y=y, fill=Dry.Matter.Productivity.333m )) + scale_fill_viridis(option="rocket") + ggtitle("DMP 2023")
globaldmp2023 <- globaldmp2023 + labs(fill= "DMP")
globaldmp2023

ggsave(filename = "global_DMP_2023.png" , plot = globaldmp2023)

italydmp2023 <- crop(dmp_2023, Italy)

italydmp2023


italydmp2023_plot <- ggplot() + geom_raster(italydmp2023, mapping=aes(x=x, y=y, fill= Dry.Matter.Productivity.333m )) + scale_fill_viridis(option="rocket") + ggtitle("DMP 2023 Italy")


italydmp2023_plot <- italydmp2023_plot + labs(fill= "DMP")
italydmp2023_plot

ggsave(filename = "global_DMP_2014_Italy.png" , plot = italydmp2023_plot)

# Now let's look at the plots from 2014 and 2023 together to compare them:
# First globally:

global_DMP_comparison <- globaldmp2014 + globaldmp2023 
global_DMP_comparison

# Let's save the file
ggsave(filename = "global_DMP_comparison.png" , plot = global_DMP_comparison)

# Now let's do the same thing for Italy:
Italy_DMP_comparison <- italydmp2014_plot + italydmp2023_plot
Italy_DMP_comparison

ggsave(filename = "Italy_DMP_comparison.png" , plot = Italy_DMP_comparison)

# Now let's look at the difference between the year 2014 and 2022:

rlist <- list.files(pattern= "dmp2")
rlist 

import <- lapply(rlist, raster)
import

# Now let's stack the data

dmpstacked <- stack(import)
dmpstacked

plot(dmpstacked)

# Lets' do the same for Italy

italydmpstacked <- crop(dmpstacked, Italy)
italydmpstacked

plot(italydmpstacked)

# Let's look at the difference 
# between DMP in 2014 and in 2023

# Globally:
difference <- dmpstacked[[2]]-dmpstacked[[1]]
difference

Italy_difference <- italydmpstacked[[2]]-italydmpstacked[[1]]
Italy_difference

difference_plot <- ggplot() + geom_raster(difference, mapping=aes(x=x, y=y, fill=layer )) + scale_fill_viridis(option="rocket") + ggtitle("DMP global difference")
difference_plot

ggsave(filename = "DMP_global_difference.png" , plot = difference_plot)

italydifference_plot <- ggplot() + geom_raster(Italy_difference, mapping=aes(x=x, y=y, fill=layer )) + scale_fill_viridis(option="rocket") + ggtitle("DMP Italy difference")
italydifference_plot

ggsave(filename = "DMP_Italy_difference.png" , plot = italydifference_plot)
