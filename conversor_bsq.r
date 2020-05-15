############################################################################## 
#                   CREAR ARCHIVOS BSQ con proyección asignada               #
#                   Elaborado por Erick Coronado Juárez                      #
#                           CentroGeo 2019                                   #
#                                                                            #
############################################################################## 


setwd("ruta")
#cargar librerias
library(raster)
library(rgdal)
library(grid)
require(rgdal)

############################################################################################################### 
# S4 method for RasterLayer,character

setwd("ruta")

#1ra prueba
#writeRaster(x, filename = "test1.bsq", bandorder = 'BSQ', overwrite = T,  datum=WGS84, proj=longlat)
  
#plot(raster("../ndvi/1.bsq"))

tiffiles <- list.files(path = "ruta", pattern = '.tif$', all.files=TRUE, full.names=F)
tiffiles[1]

file.names <- gsub(".tif","", tiffiles)

tiffiles.ras <- lapply(tiffiles, raster)  #Rasters .tif


tiffiles.ras[1]

n <- length(tiffiles.ras)
 

#Escribiendo los BSQ     
for (i in 1:n) {
  name <- paste(file.names[i],".bsq", sep="")
  writeRaster(tiffiles.ras[[i]], filename = name, 
              bandorder = 'BSQ', overwrite = TRUE,
              CRS = proyect)
  
}

#list <- seq(1:n)
files <- paste(file.names,".prj", sep = "")

#Archivo con la proyección deseada
project <- read.table("../proyeccion.prj")


#Creando archivos de la proyección 
for (i in 1:n) {
  write.table(project$V1, file = files[i], row.names = F, col.names = F, quote = F)
}



#################################################################################################
