# SDM package at work!

install.packages("sdm")
install.packages("rgdal", dependencies=T)

library(rgdal)
library(sdm)

system.file("external/species.shp", package="sdm")

file <- system.file("external/species.shp", package="sdm")
file

# Now in file we have the path to the data

library(raster)

species <- shapefile(file)
species

# Let's plot the species data!

plot(species)

species$Occurrence


presences <- species[species$Occurrence == 1, ]
presences

presences$Occurrence

# Excercise: select the absences

absences <- species[species$Occurrence == 0, ]
absences$Occurrence

plot(presences, col="red", pch=19)

points(absences, col="blue", pch=1)

# Predictors: look at the path

path <- system.file("external", package="sdm")
path

lst <- list.files(path=path, pattern="asc$", full.names=T)
lst

#Stack

preds <- stack(lst)

preds

plot(preds)

# Model
# Set the data for the sdm

datasdm <- sdmData(train=species, predictors=preds)
datasdm

m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods="glm")
m1

p1 <- predict(m1, newdata=preds)
p1

plot(p1)

finalstack <- stack(preds, p1)
plot(finalstack)
