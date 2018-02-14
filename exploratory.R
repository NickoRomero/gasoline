# Exploratory analysis of gasoline data. 
# First approach to dataset with gasoline prices from individual retailers

#reads raw data Nicolas
setwd("D:/Borrador Gasolina/gasoline")
df <- read.csv("gasoline.csv", header=T)

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

#Preparing plots

  #Date
  df$month <- df$date
  df$month <- substr(df$month, 6, 7)
  
  df$year <- df$date
  df$year <- substr(df$year, 0, 4)

  library(data.table)
  
  #City Average Price by Product (Monthly)
  df <- data.table(df)
  df[, ca_price := mean(price), by = .(city, month, year, product)]
  
  #Department Average Price by Product (Monthly)
  df[, da_price := mean(price), by = .(department, month, year, product)]
  
  #Average Price by product (Monthly)
  df[, na_price := mean(price), by = .(month, year, product)]
  
  #Average Price by Flag and Product (Monthly)
  df[, fa_price := mean(price), by = .(flag, month, year, product)]
  
  df <- as.data.frame(df)
  
  df$my <- format(as.Date(df$date), "%y-%m")
  
  #National Average Price by Product (Monthly) [PLOT]
  na_p_plot <- ggplot(df, aes(my, na_price, group= product, color = product)) +
  geom_line(size=1) + theme(axis.text.x = element_text(angle=90), legend.title.align = 0.5 ) +
      labs(title= "NATIONAL AVERAGE PRICE BY PRODUCT", y = "Average Price", x= "Date") + scale_x_discrete(breaks=c("11-01", "11-07", "12-01", 
                                "12-07", "13-01", "13-07", "14-01", "14-07", "15-01", "15-07", "16-01", "16-07", "17-01", "17-07", "18-01"))
    
  #save plots as .pdf
    print(na_p_plot)
    ggsave(na_p_plot, filename = "NATIONAL.pdf", dpi=300, scale=2)
    
        
# evolucion precio promedio por ciudad: las capitales de departamento (mensual)

  #City Average Price by Product (Monthly) [PLOT]
   # create graphing function
    city.graph <- function(df, na.rm = TRUE, ...){
      
    # create list of capital cities in data to loop over 
    city_list <- c("BOGOTA D.C.", "SANTIAGO DE CALI", "MEDELLIN", "BARRANQUILLA", "CARTAGENA DE INDIAS", "SANTA MARTA", "MONTERIA", "SINCELEJO", "SAN JOSE DE CUCUTA",
                   "BUCARAMANGA", "TUNJA", "VILLAVICENCIO", "MANIZALES", "PEREIRA", "ARMENIA", "IBAGUE", "NEIVA", "SAN JUAN DE PASTO", "YOPAL")
    
    # create for loop to produce ggplot2 graphs 
    for (i in seq_along(city_list)) { 
      
      # create plot for each capital city in df 
      ca_p_plot <- ggplot(subset(df, df$city==city_list[i]),
                   aes(my, ca_price, group = interaction(product, city), color = product)) + 
                    geom_line() + theme(axis.text.x = element_text(angle=90), legend.title.align = 0.5 ) +
                    labs(title= paste(city_list[i] ,"AVERAGE PRICE BY PRODUCT", sep = " "), y = "Average Price", x= "Date") + scale_x_discrete(breaks=c("11-01", "11-07", "12-01", 
                                  "12-07", "13-01", "13-07", "14-01", "14-07", "15-01", "15-07", "16-01", "16-07", "17-01", "17-07", "18-01"))
      
      #save plots as .pdf
      ggsave(ca_p_plot, file=paste("D:/Borrador Gasolina/gasoline/C_Plots/", city_list[i], ".pdf"), scale=2)
      
      print(ca_p_plot)
        }
      }
      
      # run graphing function on long df
      city.graph(df)
  
  #Department Average Price by Product (Monthly) [PLOT]  
      
      department.graph <- function(df, na.rm = TRUE, ...){
        
        # create list of departments in data to loop over 
        department_list <- unique(df$department) 
          
        # create for loop to produce ggplot2 graphs 
        for (j in seq_along(department_list)) { 
          
          # create plot for each department in df 
          da_p_plot <- ggplot(subset(df, df$department==department_list[j]),
                              aes(my, da_price, group =interaction(product, department), color = product)) + 
            geom_line() + theme(axis.text.x = element_text(angle=90), legend.title.align = 0.5 ) +
            labs(title= paste(department_list[j] ,"AVERAGE PRICE BY PRODUCT", sep = " "), y = "Average Price", x= "Date") + scale_x_discrete(breaks=c("11-01", "11-07", "12-01", 
                                                                                                                                                "12-07", "13-01", "13-07", "14-01", "14-07", "15-01", "15-07", "16-01", "16-07", "17-01", "17-07", "18-01"))
          
          #save plots as .pdf
          ggsave(da_p_plot, file=paste("D:/Borrador Gasolina/gasoline/D_Plots/", department_list[j], ".pdf"), scale=2)
          
          print(da_p_plot)
        }
      }
      
      # run graphing function on long df
      department.graph(df)
      
      
# evolucion precio promedio por flag (mensual)

      flag.graph <- function(df, na.rm = TRUE, ...){
        
        # create list of flags in data to loop over 
        flag_list <- unique(df$flag) 
        
        # create for loop to produce ggplot2 graphs 
        for (j in seq_along(flag_list)) { 
          
          # create plot for each flag in df 
          fa_p_plot <- ggplot(subset(df, df$flag==flag_list[j]),
                              aes(my, fa_price, group =interaction(product, flag), color = product)) + 
            geom_line() + theme(axis.text.x = element_text(angle=90), legend.title.align = 0.5 ) +
            labs(title= paste(flag_list[j] ,"AVERAGE PRICE BY PRODUCT", sep = " "), y = "Average Price", x= "Date") + scale_x_discrete(breaks=c("11-01", "11-07", "12-01", 
                                                                                                                                                      "12-07", "13-01", "13-07", "14-01", "14-07", "15-01", "15-07", "16-01", "16-07", "17-01", "17-07", "18-01"))
          
          #save plots as .pdf
          ggsave(fa_p_plot, file=paste("D:/Borrador Gasolina/gasoline/F_Plots/", flag_list[j], ".pdf"), scale=2)
          
          print(fa_p_plot)
        }
      }
      
      # run graphing function on long df
      flag.graph(df)

