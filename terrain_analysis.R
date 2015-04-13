library(raster)
library(rgeos)
library(ggmap)
library(rgdal)
library(rasterVis)

dem = raster("srtm_43_06.tif")

#haifa_buildings = readOGR("../Data files", "haifa_buildings")
#haifa_surrounding = extent(haifa_buildings) + 0.25

#plot(dem)
#plot(haifa_surrounding, add = TRUE)
#dem = crop(dem, haifa_surrounding)
#plot(dem)

slope = terrain(dem,"slope")
aspect = terrain(dem,"aspect")

#plot(stack(slope,aspect))

hill = hillShade(slope,aspect,20,235)
plot(hill)