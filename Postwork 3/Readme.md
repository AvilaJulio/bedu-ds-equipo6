# POSTWORK - SESIÓN 03
### EQUIPO 6
#### INTEGRANTES
- Angélica Luna García
- Jesús Iván Martín Reyes
- Julio Cesar Avila Padilla
- Kimberly Atara Lopez Vazquez
- Manuel Enrique Herrera Flores
- Marco Antonio Hernandez Peñafort
## DESARROLLO

 - **SECCIÓN 01:** Con el último data frame obtenido en el postwork de la sesión 2, elabora tablas de frecuencias relativas para estimar las siguientes probabilidades:
      1. La probabilidad (marginal) de que el equipo que juega en casa anote x goles (x=0,1,2,)
      2. La probabilidad (marginal) de que el equipo que juega como visitante anote y goles (y=0,1,2,)
      3. La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que juega como visitante anote y goles (x=0,1,2,, y=0,1,2,)
 - **SECCIÓN 02:** Realiza lo siguiente:
   1. Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo de casa.
   2. Un gráfico de barras para las probabilidades marginales estimadas del número de goles que anota el equipo visitante.
   3. Un HeatMap para las probabilidades conjuntas estimadas de los números de goles que anotan el equipo de casa y el equipo visitante en un partido.


## PROCEDIMIENTO

```R
## cargando las librerias
library(ggplot2)

setwd("C:\\Users\\black\\Desktop\\Postwork Equipo 6\\Repositorio")
datos <- read.csv("//LaLiga2017-2020.csv")

##  Extrayendo las columnas FTHG (casa)  y FTAG (visitantes) para hacer las tablas

a <- select(datos, FTHG)   #a=datos de equ. que juegan en casa
b <- select(datos, FTAG)   #b=datos de equ. de juegan como visit

## Agregando una columna de frecuencias absolutas a cada tabla

fa_casa <- as.data.frame(table(FTHG = a$FTHG)) #fa_casa= frec. abs. de equipos que juegan en casa
fa_casa
fa_visit <- as.data.frame(table(FTAG = b$FTAG))
fa_visit

## Agregando las frecuencias relativas a los df's. Estas frec. rel. son las probabilidades marginales.

far_casa <- transform(fa_casa,   #far_casa= frec. abs. y rel. de equipos que juegan en casa   
                      fr_casa=round(prop.table(Freq),3))
far_visit <- transform(fa_visit,     
                      fr_visit=round(prop.table(Freq),3))

## La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que
## juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...) es la columna "p_conj"
## en la siguiente tabla:

c <- datos[,c("FTHG", "FTAG" )]
str(c) # Define la estructura de C


d <- #tabla de frecuencias conjuntas
  c %>%
  group_by(FTHG, FTAG) %>%
  summarise(frecuencia = n())

e <- colSums(d[,"frecuencia"]) # e = No. de observaciones = 1140


f <- #tabla de frecuencias conjuntas y probabilidades conjuntas
  transform(d,     
            p_conj=round(prop.table(frecuencia),3))

##  Grafico de barras para las prob. marg. del numero de goles 
##  que anota el equipo de casa.

far_casa %>%
  ggplot() +
  aes(x=FTHG, y=fr_casa)+ 
  geom_bar(stat="identity", col="blue", fill = "orange")+
  ggtitle("Probabilidades marginales del nÃºmero de goles que anota el equipo de casa") +
  ylab("Freuencia relativa") +
  xlab("Goles anotados") +
  theme_light()+
  geom_text(aes(label = round(fr_casa, 3)), vjust=1.5, color="blue")


##  Grafico de barras para las prob. marg. del numero de goles que anota el equipo de visitante.

far_visit %>%
  ggplot() +
  aes(x=FTAG, y=fr_visit)+ 
  geom_bar(stat="identity", col="orange", fill = "green")+
  ggtitle("Probabilidades marginales del numero de goles que anota el equipo visitante") +
  ylab("Frecuencia relativa") +
  xlab("Goles anotados") +
  theme_gray()+
  geom_text(aes(label = round(fr_visit, 3)), vjust=1.5, color="red")

## HeatMap para las probabilidades conjuntas


f %>%
  ggplot() +
  aes(x=FTAG, y=FTHG, fill=p_conj) +
  geom_tile() +
  ggtitle("Probabilidades marginales conjustas") +
  ylab("Equipos que juegan como visitantes") +
  xlab("Equipos que juegan en casa") +
  theme_bw() +
  scale_fill_gradient(name="Frecuencia \n conjunta",
                      low="grey", high="blue")

```

## RESULTADOS

## INTERPRETACIÓN DE LOS RESULTADOS
