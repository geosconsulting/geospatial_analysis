x = matrix(7:12, ncol=3, byrow=FALSE)
library(raster)
r1 = raster(x)

band1 = raster("../Data files/landsat_15_10_1998.tif")
band2 = raster("../Data files/landsat_15_10_1998.tif",band=2)
band3 = raster("../Data files/landsat_15_10_1998.tif",band=3)
band4 = raster("../Data files/landsat_15_10_1998.tif",band=4)

bande_1_4_stack=stack(band1,band4)
bande_1_4_brick=brick(band1,band4)

l_00 = brick("../Data files/landsat_04_10_2000.tif")
seconda_banda = class(l_00[[2]])

bande_visibile = stack(band1,band2,band3)

#writeRaster(bande_visibile,"landsat_1998_visibile.img",
#            format = "HFA",
#            overwrite = TRUE)

numero_righe = nrow(l_00)
numero_layers = nlayers(l_00)
numero_righe_colonne = dim(l_00)
numero_celle = ncell(l_00)
risoluzione = res(l_00)
estensione_geografica = extent(l_00)
proiezione = proj4string(l_00)
proiezione_CRS = CRS(proj4string(l_00))

names(l_00)=paste("Band",1:6,sep = "_")
hist(l_00)

library(rasterVis)
levelplot(l_00, par.settings = RdBuTheme, contour = FALSE)