library(raster)
library(rgdal)
# r1<- raster("downloaded/srtm_35_04.tif")
# r2<- raster("downloaded/srtm_35_05.tif")
# r3<- raster("downloaded/srtm_36_04.tif")
# r4<- raster("downloaded/srtm_36_05.tif")
# r5<- raster("downloaded/srtm_37_04.tif")
# r6<- raster("downloaded/srtm_37_05.tif")
# 
# x<- list(r1,r2,r3,r4,r5,r6)
# m<-do.call(merge,x)
# 
# writeRaster(m,"downloaded/spain.tif",format="GTiff",overwrite=TRUE)

#spain <- getData("GADM", country="ESP", level=0)
spain <- readOGR("downloaded", "spain", 
                   stringsAsFactors = FALSE)
attributi_spagna = spain@data
plot(spain)

dem_spain = raster("downloaded/spain.tif")
# now use the mask function
spain_elev <- mask(dem_spain, spain)
writeRaster(spain_elev,"downloaded/spain_elev.tif",format="GTiff",overwrite=TRUE)