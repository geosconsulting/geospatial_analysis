library(RPostgreSQL)
con <- dbConnect(PostgreSQL(), user= "geonode", password="geonode", dbname="geonode-imports")
tab_totale <- dbReadTable(con, c("public","sparc_adm2_density"))
tab_paese <- tab_totale[tab_totale$adm0_name == "Cameroon", ]
boxplot(tab_paese$pop)

