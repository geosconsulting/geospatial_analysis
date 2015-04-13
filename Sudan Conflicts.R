library(sp)
library(rgdal)
library(rgeos)

sudan = readOGR("C:\\data\\tools\\conflicts\\vector_data","Sudan",
                stringsAsFactors = FALSE)

#south_sudan = readOGR("C:\\data\\tools\\conflicts\\vector_data","South Sudan",
#                      stringsAsFactors = FALSE)


sudan_ctr = gCentroid(sudan,byid=TRUE)


ssudan_ctr = gCentroid(south_sudan,byid=TRUE)
centroidi=c(ssudan_ctr,sudan_ctr)

plot(sudan,col="grey")
text(sudan_ctr, sudan$adm2_name, cex=0.3, col="red")

plot(south_sudan,col="yellow")
text(ssudan_ctr,south_sudan$adm2_name,cex=0.3,col="red")




