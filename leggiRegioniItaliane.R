library(rgdal)

poligoni.regioni <- readOGR("G:/_Appoggio/geo robba/GIS_Data/dati esercizi/ISTAT/reg2011",
                          "reg2011",stringsAsFactors = FALSE)

plot(poligoni.regioni)
dati.regioni <- nazioni_europee@data

regioni.grandi <- poligoni.regioni$SHAPE_Leng>1375419
