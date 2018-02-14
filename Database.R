#Directorio de Trabajo
setwd("D:/Borrador Gasolina/Estación - Mes/CSV")

#Library
library(plyr)
library(stringr)

#Cargando base de datos

path = "D:/Borrador Gasolina/Estación - Mes/CSV"
Gasoline<-""
file.names <- dir(path, pattern =".csv")
  for(i in 1:length(file.names)){
   Step <- read.csv(file.names[i],header=TRUE, sep=",")
   Gasoline <- rbind(Gasoline, Step)
  }

rm(Step)

#Renombrando las variables
names(Gasoline)[names(Gasoline)=="Bandera"] <- "flag" #Bandera de la estación
names(Gasoline)[names(Gasoline)=="Departamento"] <- "department" #Departamento donde está ubicada la estación
names(Gasoline)[names(Gasoline)=="Municipio"] <- "city" #Municipio donde está ubicada la estación
names(Gasoline)[names(Gasoline)=="Nombre.Comercial"] <- "station" #Estación de combustible
names(Gasoline)[names(Gasoline)=="Dirección"] <- "address" #Dirección del Lugar
names(Gasoline)[names(Gasoline)=="Precio.....Mes.Actual"] <- "price" #Precio Actual
names(Gasoline)[names(Gasoline)=="Precio.....Mes.Anterior"] <- "p.price" #Precio del mes pasado
names(Gasoline)[names(Gasoline)=="Fecha.Registro"] <- "date" #Fecha de Registro
names(Gasoline)[names(Gasoline)=="Nombre.del.Producto"] <- "product" #Producto

#Borrando el Primer NA
Gasoline <- Gasoline[-1,]

#Convirtiendo las variables en la clase correcta
Gasoline$date <- as.Date(Gasoline$date, "%d/%m/%Y") 
Gasoline$price <- as.integer(Gasoline$price)
Gasoline$p.price <- as.integer(Gasoline$p.price)

#Reemplazando carácteres especiales
Gasoline$address <- gsub("N°", "No ", Gasoline$address) #Realizar todas las combinaciones posibles.
Gasoline$station <- gsub("Ñ", "N", Gasoline$station)
Gasoline$department <- gsub("Ñ", "N", Gasoline$department)
Gasoline$city <- gsub("Ñ", "N", Gasoline$city)
Gasoline$address <- gsub("No TE ", "NORTE ", Gasoline$address)
Gasoline$station <- str_replace_all(Gasoline$station, "[ÁÉÍÓÚ]", "[AEIOU]")
Gasoline$station <- str_replace_all(Gasoline$station, "PACíFICO", "PACIFICO")
Gasoline$address <- str_replace_all(Gasoline$address, "[ÁÉÍÓÚ]", "[AEIOU]")
Gasoline$city <- str_replace_all(Gasoline$city, "[ÁÉÍÓÚ]", "[AEIOU]")


#Paso de Seguridad
gasoline <- Gasoline

write.csv(Gasoline, file = "gasoline.csv", row.names=F)


