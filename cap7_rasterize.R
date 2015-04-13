library(raster)
library(ggmap)

l_00 = brick("../Data files/landsat_04_10_2000.tif")
r = brick("../Data files/modis.tif")

towns_names = c("Lahav Kibbutz", "Lehavim")
towns = geocode(towns_names)
coordinates(towns)= ~ lon + lat

proj4string(towns)= CRS("+proj=longlat +datum=WGS84")
towns = spTransform(towns,CRS(proj4string(l_00)))

plotRGB(l_00,r=3,g=2,b=1,stretch="lin")
plot(towns,col="red",pch=16,add=TRUE)
text(coordinates(towns),towns_names,col="white")

towns_r = rasterize(towns,r)
towns_r = crop(towns_r, extent(towns) + 3000)
plot(towns_r, col = c("lightblue", "brown"))
plot(towns, add = TRUE)
text(coordinates(towns), towns_names, pos = 3)