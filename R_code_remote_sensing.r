# R code for remote sensing data analysis in ecosystem monitoring

# We are using the "raster" package
install.packages("raster")

library(raster)

# We set the working directory:
setwd("C:/Documenti/Laurea magistrale/Monitoring ecosystems change and functioning")

# We are going to upload the data, using a function called "brick()"

p224r63_2011 <- brick("p224r63_2011_masked.grd")

plot(p224r63_2011)

cl <- colorRampPalette(c('black','grey','light grey'))(100)  
plot(p224r63_2011, col=cl)

# To see only the plot of the first band we do this
plot(p224r63_2011$B1_sre, col=cl)

# If you know the position of the band you can also do this
plot(p224r63_2011[[1]], col=cl)

# Excercise: change the color ramp palette with colours drom dark to light blue
cl <- colorRampPalette(c('dark blue','blue','light blue'))(100) 
plot(p224r63_2011, col=cl)

# If we want to put images in a row we do this:

par(mfrow=c(1,2))
plot(p224r63_2011[[1]], col=cl)
plot(p224r63_2011[[2]], col=cl)

# Excercise: put all the 4 images in 2 different rows

par(mfrow=c(2,2))
plot(p224r63_2011[[1]], col=cl)
plot(p224r63_2011[[2]], col=cl)
plot(p224r63_2011[[3]], col=cl)
plot(p224r63_2011[[4]], col=cl)


# Excercise: plot the four bands with four different legends (colour ramps) 
par(mfrow=c(2,2))
clb <- colorRampPalette(c('dark blue','blue','light blue'))(100) # 
plot(p224r63_2011$B1_sre, col=clb)

clg <- colorRampPalette(c('dark green','green','light green'))(100) # 
plot(p224r63_2011$B2_sre, col=clg)

clr <- colorRampPalette(c('dark red','red','pink'))(100) # 
plot(p224r63_2011$B3_sre, col=clr)

# Exercise: plot the final band, namely the NIR, band number 4
# red, orange, yellow
clnir <- colorRampPalette(c('red','orange','yellow'))(100) # 
plot(p224r63_2011$B4_sre, col=clnir)

# Now we plot the bands with multilayered colors:
# r is red component, g is green component and b is blue component

dev.off() # it closes the previous windows

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="lin")

# Now we remove color blue and we add the band n 4 for the infrared:

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="lin")

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="lin")

# Excercise: plot the previous 4 manners in a single multiframe

par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

# Now let's use the histogram stretch instead of the linear:

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="hist")

# To compare:
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="lin")
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="hist")

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="hist")

