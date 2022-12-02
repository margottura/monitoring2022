# R code on Greenland ice melt
library(raster)
library(viridis)
library(RStoolsbox)
library(patchwork)

setwd("C:/Documenti/Laurea magistrale/Monitoring ecosystems change and functioning")

lst_2000 <- raster("lst_2000.tif")

# Excercise: plot the lst_2000 with ggplot()

ggplot() + geom_raster(lst_2000, mapping=aes(x=x, y=y, fill= lst_2000)) + scale_fill_viridis(option="mako")

# To better 'see the increase of temperature we use the colors "magma"
# We use + ggtitle to add a title to the plot
# We change direction in -1
# We can use the alpha argument to put a certain level of transparency; the higher the alpha, the lower will be the transparency, it can go until one
ggplot() + geom_raster(lst_2000, mapping=aes(x=x, y=y, fill= lst_2000)) + scale_fill_viridis(option="magma", alpha=0,8, direction=-1) + ggtitle("Temperature 2000")

# Now let's compare what happens with different alphas:
p1 <- ggplot() + geom_raster(lst_2000, mapping=aes(x=x, y=y, fill= lst_2000)) + scale_fill_viridis(option="magma", alpha=0,2, direction=-1) + ggtitle("Temperature 2000")
p2 <- ggplot() + geom_raster(lst_2000, mapping=aes(x=x, y=y, fill= lst_2000)) + scale_fill_viridis(option="magma", alpha=0,8, direction=-1) + ggtitle("Temperature 2000")

p1 + p2

lst_2005 <- raster ("lst_2005.tif")
lst_2010 <- raster ("lst_2010.tif")
lst_2015 <- raster ("lst_2015.tif")

par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

# Let's list the files
# First of all we are making the list of the files with list.files

rlist <- list.files(pattern="lst")

# Excercise: list: rlist, function: the function we need to import is lapply(X, FUN)
import <- lapply(rlist, raster)
import

# stack
TGr <- stack(import)
TGr

plot(TGr)

p1 <- ggplot() + geom_raster(TGr [[1]], mapping=aes(x=x, y=y, fill= lst_2000)) + scale_fill_viridis(option="magma", alpha=0,2, direction=-1) + ggtitle("Temperature 2000")

p2 <-ggplot() + geom_raster(TGr [[1]], mapping=aes(x=x, y=y, fill= lst_2000)) + scale_fill_viridis(option="magma", alpha=0,2, direction=-1) + ggtitle("Temperature 2000")
