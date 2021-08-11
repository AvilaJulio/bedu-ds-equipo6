#Postwork 6

#========= PROCEDIMIENTO =========
# Paso 0 - cargar las librerías a utilizar e importar los datos
library(dplyr)

datos <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2021/main/Sesion-06/Postwork/match.data.csv")

# Paso 1 - agregar la columna sumagoles con la suma de goles por partido
datos1 <- mutate(datos, sumagoles = datos$home.score + datos$away.score) #se agrega la columna "sumagoles", que es la suma de "home.score" y "away.score"
str(datos1) #nos damos cuenta que la columa date no tiene formato de fecha
datos1 <- mutate(datos1, date=as.Date(date,"%Y-%m-%d")) #le damos el formato adecuado a la columna "date".
str(datos1) #verificamos que todos los datos ya cuentan con la estructura adecuada.

# Paso 2 - obtener promedio por mes de la suma de goles
#install.packages("lubridate")
library(lubridate)                                  #instalar y cargar libería lubridate

datos2 <- datos1                                    # Duplicar los datos
datos2$anio_mes <- floor_date(datos2$date, "month") # Crear columna anio-mes

datos2_aggr <- datos2 %>%                           # Agrupamos por anio_mes y promediamos columna "sumagoles"
  group_by(anio_mes) %>% 
  dplyr::summarize(promgoles = mean(sumagoles)) %>% 
  as.data.frame()

datos2_aggr <- datos2_aggr[-31,] #quitamos la fila 31, porque no es un dato que represente a toda la muestra

datosbien <- mutate(datos2_aggr, anio_mes = format(datos2_aggr$anio_mes, "%Y-%m")) #quitamos el día a las fechas de la columna "date"
head(datosbien)

# Paso 3 - Crear la serie de tiempo  del promedio por mes de la suma de goles hasta mayo de 2019 (fin de la temporada 2018-2019)
datosbien.ts <- ts(datosbien[,2], frequency=10, start=c(2010,8), end=c(2019,5))
datosbien.ts

# Paso 4 - Graficar la serie de tiempo
ts_graph <- plot(datosbien.ts, 
     col ="blue",
     lwd = "2",
     main = "Promedio de goles anotados por mes",
     col.main = "red",
     ylab = "Goles promedio",
     xlab = "Meses",
     sub = "Agosto de 2010 - Mayo de 2019",
     fg = "sienna2")

# PASO ADICIONAL
# Hacer la descomposición de la serie de tiempo para observar sus componentes
desc <- decompose(datosbien.ts)

plot(desc, xlab = "Tiempo", 
     sub = "Descomposición de los datos")
