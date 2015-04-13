library(raster)
library(RColorBrewer)
library(lattice)
library(rasterVis)

r = stack("../Data files/modis.tif")
min_div = min(r,na.rm=TRUE)
min_val = min(r[[1]],na.rm = TRUE)
range_ndvi = range(r,na.rm = TRUE)
numero_layers = nlayers(range_ndvi)

levelplot(stack(r[[1]]), par.settings = RdBuTheme, contour = FALSE)