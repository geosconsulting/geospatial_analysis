library(raster)
library(RColorBrewer)
library(lattice)
library(rasterVis)

r = brick("../Data files/modis.tif")

valori_3bande_5celle = r[[1:3]][1:5]

#library(plotKML)
#inondazione_cuba = raster("C:/data/tools/sparc/vulnerability/f_cub.img")
#plotKML.env(silent = TRUE)
#plotKML(inondazione_cuba)

dates = read.csv("../Data files/modis_dates.csv")
dates$date = as.Date(paste(dates$year,dates$month,dates$day,sep = "-"))

v = r[42, 38][1, ]
numero_bande = nlayers(r)

plot(v ~ dates$date, type = "l", xlab = "Time", ylab = "NDVI")


u = r[[1:3]][1:2,1:2, drop=FALSE]
#levelplot(u,layout=c(3,1),par.settings=RdBuTheme)

#Singola banda come matrice
single_band = as.matrix(u[[1]])

#bande multiple come matrice
multiple_bands = as.matrix(u[[1:2]])
min_ndvi = min(r,na.rm = TRUE)

range_ndvi = range(r, na.rm = TRUE)
levelplot(range_ndvi, par.settings = RdBuTheme, contour = TRUE)
