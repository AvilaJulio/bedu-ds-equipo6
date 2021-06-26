#           EQUIPO 6
#     POSTWORK - SESIÓN 03

#========= INTEGRANTES ===========
# Angélica Luna García
# Jesús Iván Martín Reyes
# Julio Cesar Avila Padilla
# Kimberly Atara Lopez Vazquez
# Manuel Enrique Herrera Flores
# Marco Antonio Hernandez Peñafort
#=================================


#========= DESARROLLO ============
# SECCIÓN 01 ==> Con el último data frame obtenido en el postwork de la sesión 2,  
#                elabora tablas de frecuencias relativas para estimar las 
#                siguientes probabilidades:
#                1.1 - La probabilidad (marginal) de que el equipo que juega en 
#                      casa anote x goles (x=0,1,2,)
#                1.2 - La probabilidad (marginal) de que el equipo que juega 
#                      como visitante anote y goles (y=0,1,2,) 
#                1.3 - La probabilidad (conjunta) de que el equipo que juega  
#                      en casa anote x goles y el equipo que juega como visitante
#                      anote y goles (x=0,1,2,, y=0,1,2,)
# SECCIÓN 02 ==> Realiza lo siguiente:
#                2.1 - Un gráfico de barras para las probabilidades marginales 
#                      estimadas del número de goles que anota el equipo de casa. 
#                2.2 - Un gráfico de barras para las probabilidades marginales 
#                      estimadas del número de goles que anota el equipo visitante. 
#                2.3 - Un HeatMap para las probabilidades conjuntas estimadas   
#                      de los números de goles que anotan el equipo de casa y 
#                      el equipo visitante en un partido.
#=================================


#========= PROCEDIMIENTO =========

# ============== SECCIÓN 1 ===============

# Paso 0 - Cargar las librerías que ocuparemos
library(dplyr)
library(ggplot2)

# Paso 1 - Inicializar el directorio donde se encuentra nuestro archivo anterior
setwd("C:\\Users\\black\\Desktop\\Postwork Equipo 6\\Repositorio")
data <- read.csv("LaLiga2017-2020.csv")

# Paso 1.1 - Determinar el tamaño de las filas de la primer columna
num.partidos<- length(data[,1])
num.partidos

# Paso 2 - Creando la probabilidad conjunta de goles locales
goles.locales <- table(data$FTHG) #Frecuencia de goles locales
p.goles.local <- goles.locales[1:length(goles.locales)]/num.partidos #Probabilidad conjunta de goles locales
locales <- data.frame(frecuencia = goles.locales, probabilidad = p.goles.local) #Creando Data Frame
locales <- locales[, -c(3)]
locales <- rename(locales, goles = frecuencia.Var1, frecuencia = frecuencia.Freq, probabilidad = probabilidad.Freq)

# Paso 3 - Creando la probabilidad conjunta de goles de los visitantes
goles.visita <- table(data$FTAG) #Frecuencia de goles visitantes
p.goles.visit <- goles.visita/num.partidos #Probabilidad conjunta de goles visitantes
visita <- data.frame(frecuencia = goles.visita, probabilidad = p.goles.visit) #Creando Data Frame
visita <- visita[, -c(3)]
visita <- rename(visita, goles = frecuencia.Var1, frecuencia = frecuencia.Freq, probabilidad = probabilidad.Freq)


# Paso 4 - Creando Tabla Conjunta
l <- locales$goles
v <- visita$goles
cart <- expand.grid(l, v)
cart[, 3] = rep(0, length(cart[, 1]))
cart <- rename(cart, goles.local = Var1, goles.visita = Var2, frecuencia_conjunta = V3)

# DataFrame con goles_local/goles_visita/frecuencia

for(i in 1:length(data[, 1])){
  for(j in 1:length(cart[, 1])){
    if((data[i,4] == cart[j, 1]) & (data[i,5] == cart[j, 2])){
      cart[j, 3] = cart[j, 3] + 1 
    }
  }
}

cart[,4] = cart$frecuencia_conjunta / num.partidos
cart = rename(cart, probabilidad = V4)
cart # Probabilidad conjunta

# ============== SECCIÓN 2 ===============

# Paso 5 - Creando un gráfico de barras para las probabilidades marginales 
# estimadas del número de goles que anota el equipo de casa.
ggplot(locales, aes(x = goles, y = probabilidad)) + 
  geom_col(colour = "black", fill= "mediumseagreen") +
  geom_text(aes(y = round(probabilidad, 4), label = round(probabilidad, 4)), 
            position = "identity", size=3, vjust = -1, hjust=0.5 ,col="black") +
  ggtitle("Probabilidades marginales de goles de equipos locales") + 
  xlab("Goles") +
  ylab("Probabilidades") +
  theme_minimal()

# Paso 6 - Un gráfico de barras para las probabilidades marginales estimadas  
# del número de goles que anota el equipo visitante.
ggplot(visita, aes(x = goles, y = probabilidad)) + 
  geom_col(colour = "black", fill= "mediumslateblue") +
  geom_text(aes(y = round(probabilidad, 4), label = round(probabilidad, 4)), 
            position = "identity", size=3, vjust = -1, hjust=0.5 ,col="black") +
  ggtitle("Probabilidades marginales de goles de equipos visitantes") + 
  xlab("Goles") +
  ylab("Probabilidades") +
  theme_minimal()

# Paso 7 - Un HeatMap para las probabilidades conjuntas estimadas de los 
# números de goles que anotan el equipo de casa y el equipo visitante en un partido.
ggplot(cart, aes(x = goles.local, y = goles.visita, fill = probabilidad)) + 
  geom_tile() +
  scale_fill_continuous(low = "white", high = "mediumvioletred") +
  ggtitle("Mapa de calor de la probabilidad conjunta", subtitle = 'Goles de equipos locales vs goles de equipos visitantes') +
  xlab("Goles de los locales") + 
  ylab("Goles de los visitantes")

