#########################################################################################
#                                                                                       #
#       Visualizador de NDVI y Puntos de la encuesta con MAPVIEW                        #
#               Elaborado por Erick Coronado Juárez                                     #
#                       CentroGeo 2019                                                  #
#########################################################################################

setwd("ruta/")

#rasterVis:
#install.packages("rasterVis")
#ggplot2: 
library(ggplot2)
library(rasterVis)
library(raster)
library(rgdal)

t.files <- list.files(path = "ruta", pattern = '.tif$')

r.files <- lapply(t.files, raster)

all.r <- stack(r.files)

#Puntos de la Encuesta
encuesta <- shapefile("ruta")


plot(encuesta)

### Obtener valores sobre el raster por pixel
plot(all.r[[1]])  # One exemplary layer for orientation.

values <- click(all.r, n=5)

#Guardar los puntos seleccionados
val <- as.data.frame(values)
plot(t(val[,]))

#Extraer info


#library(raster)
#library(rgdal)

ndvi.pts <- extract(all.r, encuesta)
months <- gsub("X",x= colnames(ndvi.pts), replacement = "")

#Modo interactivo 
mapa <- mapview(all.r) + encuesta+ all.r[[1]] +all.r[[4]] + all.r[[3]] + all.r[[2]]

img1 <- "logo.png"

addLogo(mapa,  img1, src = "local", 
        width = 70,
        height = 35)

###############################################################################################
