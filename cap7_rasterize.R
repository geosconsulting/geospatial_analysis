library(raster)
library(ggmap)
library(rgeos)
library(rgdal)

#l_00 = brick("Data files/landsat_04_10_2000.tif")
#r = brick("Data files/modis.tif")

#towns_names = c("Lahav Kibbutz", "Lehavim")
#towns = geocode(towns_names)
#coordinates(towns)= ~ lon + lat

#proj4string(towns)= CRS("+proj=longlat +datum=WGS84")
#towns = spTransform(towns,CRS(proj4string(l_00)))

#plotRGB(l_00,r=3,g=2,b=1,stretch="lin")
#plot(towns,col="red",pch=16,add=TRUE)
#text(coordinates(towns),towns_names,col="white")

#towns_r = rasterize(towns,r)
#towns_r = crop(towns_r, extent(towns) + 3000)
# plot(towns_r, col = c("lightblue", "brown"))
# plot(towns, add = TRUE)
# text(coordinates(towns), towns_names, pos = 3)

dem = raster("dem_crop.tif")
haifa_buildings = readOGR("Data files", "haifa_buildings")
haifa_natural = readOGR("Data files", "haifa_natural")

#haifa_buildings = spTransform(haifa_buildings, CRS(proj4string(dem)))

#haifa_natural = spTransform(haifa_natural, CRS(proj4string(dem)))
haifa_ext = extent(haifa_buildings) + 2000
bldg_data = haifa_buildings@data

#plot(haifa_buildings, ext = haifa_ext)
#dem1 = getData("SRTM", lon=33, lat=33)
#dem2 = getData("SRTM", lon=38, lat=33)

#dem1 = raster("srtm_43_06.tif")
#dem2 = raster("srtm_44_06.tif")
#dem = merge(dem1, dem2)
#writeRaster(dem,"dem.tif")

#dem_crop = crop(dem, haifa_ext)
#writeRaster(dem_crop,"dem_crop.tif",overwrite = TRUE)
dem_crop = raster("dem_crop.tif")
dem_ext = extent(dem_crop) 
slope = terrain(dem_crop, "slope")
 
plot(slope,ext = dem_ext)
plot(haifa_buildings, add = TRUE)
plot(haifa_natural, col = "lightgreen", add = TRUE)


natural_mask = mask(slope, haifa_natural)
natural_mask = crop(natural_mask, haifa_ext)
buildings_mask = mask(slope, haifa_buildings)
buildings_mask = crop(buildings_mask, haifa_ext)

