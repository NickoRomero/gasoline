# Exploratory analysis of gasoline data. 
# First approach to dataset with gasoline prices from individual retailers


# reads raw data
df <- read.csv("~/Gasoline/gas data/gasoline.csv")
df$date <- as.Date(df$date) 
df$address <- as.character(df$address)
str(df)

# removing annoying spaces
levels(df$flag)[levels(df$flag)=="BRIO "] <- "BRIO"
levels(df$flag)[levels(df$flag)=="PETROMIL "] <- "PETROMIL"
levels(df$flag)[levels(df$flag)== "ZEUSS "] <- "ZEUSS"
levels(df$flag)[levels(df$flag)== "ZAPATA Y VELASQUEZ "] <- "ZAPATA Y VELASQUEZ"


# observations
unidades <- c("observaciones",
              "marcas",
              "estaciones",
              "departamentos",
              "ciudades",
              "combustible",
              "fechas"
              )
numeros <- c(length(df[[1]]),
             length(levels(df$flag)),
             length(levels(df$station)),
             length(levels(df$department)),
             length(levels(df$city)),
             length(levels(df$product)),
             length(unique(df$date))
             )
print(paste("hay", numeros, unidades))


# some tables
sort(
  table(df$flag)
  )
sort(
  table(df$department)
  )
sort(
  table(df$product)
  )

# some plots
library(ggplot2)

ggplot(df, aes(x=price, fill=product)) +
  geom_density(alpha = .3 ) 


# evolución precio promedio nacional en el tiempo (mensual)

# evolución precio promedio por ciudad: las capitales de departamento (mensual)

# evolución precio promedio por flag (mensual)



