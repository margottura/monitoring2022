# how to download and analyse Copernicus data:

# Copernicus set:
# https://land.copernicus.vgt.vito.be/PDF/portal/Application.html

# Register and Login
# Download data from Criosphere
# The arrow should be blue
# Info: https://land.copernicus.eu/global/content/sce-nhemi-product-s-npp-viirs-data-affected

install.packages("ncdf4")
library(ncdf4) # reading .nc files
library(raster) # usual package
library(ggplot2) # beautiful plots
library(RStoolbox) # RS functions
library(viridis) # legends - color gamut
library(patchwork) # multiframe for ggplot

setwd("C:/Documenti/Laurea magistrale/Monitoring ecosystems change and functioning")

snow <- raster("c_gls_SCE_202012210000_NHEMI_VIIRS_V1.0.1.nc")

# Now let's look at the data
snow

# Exercise: based on your previous code, plot the data using ggplot and viridis, choose your own colorramp palette
ggplot(snow)
ggplot() + geom_raster(snow, mapping=aes(x=x, y=y, fill= Snow.Cover.Extent )) + scale_fill_viridis(option="mako")

# Do not use turbo/raimbow colors!!

# Now let's only look at european data:

ext <- c(-20, 70, 20, 75)
snow.europe <- crop(snow, ext)

ggplot() + geom_raster(snow.europe, mapping=aes(x=x, y=y, fill= Snow.Cover.Extent )) + scale_fill_viridis(option="mako")

# Plot the two sets with the patchwork package

p1 <- ggplot() + geom_raster(snow, mapping=aes(x=x, y=y, fill= Snow.Cover.Extent )) + scale_fill_viridis(option="mako")
p2 <- ggplot() + geom_raster(snow.europe, mapping=aes(x=x, y=y, fill= Snow.Cover.Extent )) + scale_fill_viridis(option="mako")

p1 + p2
