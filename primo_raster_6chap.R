library(ggmap)
haifa = geocode("Haifa")

library(raster)
library(rgdal)
dem1 = getData("SRTM",lon=33,lat=33)
dem2 = getData("SRTM",lon=38,lat=33)

dem1 = raster("srtm_43_06.tif")
dem2 = raster("srtm_44_06.tif")

dem = merge(dem1,dem2,progress="text")

haifa_buildings = readOGR("../Data files", "haifa_buildings")
haifa_surrounding = extent(haifa_buildings) + 0.25

plot(dem)
plot(haifa_surrounding,add = TRUE)
dem = crop(dem,haifa_surrounding)
plot(dem)

dem_agg8  =aggregate(dem,fact=8)
dem_agg16 =aggregate(dem,fact=16)

par(mfrow = c(1,3), mai = rep(0.5, 4))
plot(dem,main="Original image")
plot(dem_agg8, main = "8x8 aggregated")
plot(dem_agg16, main = "16x16 aggregated")