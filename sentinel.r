#Descarga de imagenes Sentinel2

install.packages("sen2r")
install.packages("curl")
install.packages("geojsonlint")
install.packages("rgdal")

reticulate::use_python(sen2r:::load_binpaths()$python, required = TRUE)
reticulate::import_builtins()
reticulate::import("os")

library(rgdal)
sen2r:::init_python()
sen2r:::check_gdal(force=TRUE)
sen2r:::load_binpaths()

library(geojsonlint)
library(curl)
library(sen2r)
library(remotes)

install.packages("xml2")
library(xml2)

library(sen2r)
sen2r()

sen2r("ruta del json")


check_scihub_login("user", "password")
sen2r::check_scihub_login("user", "password")
sen2r::write_scihub_login("user", "password")

sessionInfo()
