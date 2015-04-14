library(raster)
library(ggmap)
library(rgeos)
library(rgdal)


#dem_spain_file = getData("SRTM", lon=-2, lat=41)
# dem_sp_1 = raster("downloaded/srtm_35_04.tif")
# dem_sp_2 = raster("downloaded/srtm_35_05.tif")
# dem_sp_3 = raster("downloaded/srtm_36_04.tif")
# dem_sp_4 = raster("downloaded/srtm_36_05.tif")
# dem_sp_5 = raster("downloaded/srtm_37_04.tif")
# dem_sp_6 = raster("downloaded/srtm_37_05.tif")
# dem_all_spain = mosaic(dem_sp_1,dem_sp_2,dem_sp_3,dem_sp_4,dem_sp_5,dem_sp_6, filename="downloaded/dem_all_spain.tif")

dem_spain = raster("downloaded/spain.tif")

stations = read.csv("Data files/spain_stations.csv", stringsAsFactors = FALSE)
coordinates(stations) = ~ longitude + latitude
proj4string(stations) = CRS("+proj=longlat +datum=WGS84")
stations = spTransform(stations, CRS(proj4string(dem_spain)))
#plot(dem_spain)
#plot(stations,add=TRUE)
stations$elev_dem = extract(dem_spain,stations)
plot(elev_dem ~ elevation, stations, xlim = c(0, 2000), 
  ylim = c(0, 2000), xlab = "Elevation from station record (m)",
  ylab = "Elevation from DEM (m)")
abline(a=0,b=1,lty="dotted")