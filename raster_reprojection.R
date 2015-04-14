library(raster)

dem1 = getData("SRTM", lon=33, lat=33)
dem2 = getData("SRTM", lon=38, lat=33)
dem = merge(dem1, dem2)
