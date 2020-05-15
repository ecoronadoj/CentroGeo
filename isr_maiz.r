
############################################################################## 
#                   Código para la elaboración del iSR para maíz             #
#                   Elaborado por Erick Coronado Juárez                      #
#                           CentroGeo 2019 - 2020                            #
#                                                                            #
############################################################################## 


setwd("c:/Users/roid8/Documents/CentroGeo/2020/Indice_resiliencia_sotenibilidad/CSV/")


areas <- read.csv("ruta.csv", sep = ",", header = T)
areas <- areas[,-c(1:9)]
summary(areas)
colnames(areas)

pri.comp2 <- prcomp(areas[,39:42], 
                    center = T, scale = T)
plot(pri.comp2)
print(pri.comp2)
biplot(pri.comp2, scale = 0)

pri.comp2$rotation
pri.comp2$sdev

#indice normalizado y centrado, con absoluto de los pesos

i.ap.1 <- (areas$Anom_num)*abs(pri.comp2$rotation[1])
i.ap.2 <- (areas$erosion_nu)*abs(pri.comp2$rotation[2])
i.ap.3 <- (areas$DiverNum)*abs(pri.comp2$rotation[3])
i.ap.4 <- (areas$N_AdapLoc_V)*abs(pri.comp2$rotation[4])

i.ap <- as.data.frame(cbind(i.ap.1, i.ap.2, i.ap.3, i.ap.4))
summary(i.ap)

iSR <- cbind(areas$FID,i.ap)


colnames(iSR) <- c("ID", "Anomalías", "Erosión","Agrobiodiversidad", "Adaptación Local")

iSR$iSR <- (iSR$Anomalías + iSR$Erosión + iSR$Agrobiodiversidad + iSR$`Adaptación Local`)
summary(iSR)

# imprimiendo INDICE con los Componentes principales normalizados, centrados
#write.csv(iSR, file = "new_isr.csv", sep = ",", col.names = T)


library(scales)
iSR.res <- rescale(iSR$iSR, to = c(0,1))
summary(iSR.res)

hist(iSR.res)

iSR$iSR.res <- iSR.res
summary(iSR)

iSR_final <- iSR[,-c(2:6)]

# imprimiendo INDICE con los Componentes principales normalizados, centrados y reescalado
write.csv(iSR_final, file = "isr_res_val.csv", sep = ",", col.names = T)
