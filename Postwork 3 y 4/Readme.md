#     POSTWORK - SESIÓN 03
### Equipo 6

## *En este caso se junto el código del Postwork 3 y 4 para que el código corriera de una manera más eficiente.*


## DESARROLLO: Post Work 3
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

########################################################################################################
```


## POSTWORK 04

#### DESARROLLO

Ahora investigarás la dependencia o independencia del número de goles anotados por el equipo de casa y el número de goles anotados por el equipo visitante mediante un procedimiento denominado bootstrap, revisa bibliografía en internet para que tengas nociones de este desarrollo. 

1. Ya hemos estimado las probabilidades conjuntas de que el equipo de casa anote X=x goles (x=0,1,... ,8), y el equipo visitante anote Y=y goles (y=0,1,... ,6), en un partido. Obtén una tabla de cocientes al dividir estas probabilidades conjuntas por el producto de las probabilidades marginales correspondientes.

2. Mediante un procedimiento de boostrap, obtén más cocientes similares a los obtenidos en la tabla del punto anterior. Esto para tener una idea de las distribuciones de la cual vienen los cocientes en la tabla anterior. Menciona en cuáles casos le parece razonable suponer que los cocientes de la tabla en el punto 1, son iguales a 1 (en tal caso tendríamos independencia de las variables aleatorias X y Y).

__Notas para los datos de soccer:__ https://www.football-data.co.uk/notes.txt

#### PROCEDIMIENTO
```R
# POSTWORK S4

## Cargando las librerías
library(dplyr)

################################# PARTE 1 ######################################################
## Añadiedo la fila del cociente

lf <- length(f$p_conj) # long. de las columnas en f
lfar_casa <- length(far_casa$FTHG) #long de las columnas en far_casa
lfar_visit <- length(far_visit$FTAG)

cocientes <- c(0)
for (i in 1:lf) {
  num = f$p_conj[i] # num=numerador
  for(j in 1:lfar_casa){
    if (f$FTHG[i]==far_casa$FTHG[j]) {
      p=j # p=posición
      den1=far_casa$fr_casa[p] # de1=denominador 1
    }
  }
  for(k in 1:lfar_visit){
    if (f$FTAG[i]==far_visit$FTAG[k]) {
      p=k
      den2=far_visit$fr_visit[p]
    }
  }
  cocientes[i]=num/(den1*den2) # crea el vector de cocientes
}

(cocientes <- round(cocientes,3)) # redondea el vector a 3 decimales

f2 <- cbind(f, cocientes) # añade el vector "cocientes" a la tabla f

class(f2) # borrar


################################## PARTE  2 ###################################################################

## Haciendo el boostrap

set.seed(1)
boostrap <- replicate(n=5000, sample(f2$cocientes, size=39, replace=TRUE)) # creando el boostrap
dim(boostrap)

### Media poblacional
medias_i <- apply(boostrap, 2, mean) #vector de medias de cada una de las 5000 submuestras
media_poblacional=mean(medias_i)
media_poblacional #1.442547

### Desviación estándar poblacional
de <- sqrt(sum((medias_i - media_poblacional)^2)/ncol(boostrap)) #de=desviación estándar
de #0.1524015

### Distribución de boostrap de las medias_i

Grafica_del_boostrap <- ggplot() +
  geom_histogram(aes(x=medias_i), binwidth=0.05, col="black", fill = "white") + 
  geom_vline(xintercept = media_poblacional, size=1, color="darkred" )+
  ggtitle("Distribución boostrap de las medias de cada una de las 5000 submuestras") +
  ylab("Freuencia") +
  xlab("Media") +
  theme_gray()
Grafica_del_boostrap + geom_text(data = NULL,  x = 1.8, y = 600 ,
                                   label = paste("Media=", media_poblacional) )


     
## Para confirmar el resultado del boostrap, se hará un aprueba de hipótesis t de studen
## ya que no se conoce la varianza poblacional, con nivel de confianza de 0.95 (alpha=0.05/2=0.025)

### H0: mu0=1
### h1: mu0<>1

### etadístico de prueba t
media_muestral=mean(f2$cocientes)
media_muestral
lc <- length(f2$cocientes)


### prueba de hipóteis
#Estadístico de prueba
s <- sd(f2$cocientes) #desviación estándar muestral
t <- (media_muestral-1)/(s/sqrt(lc))

#Criterio de decisión
(t.025 <- qt(p = 0.025, df=38, lower.tail = FALSE))

#prueba
if(t>t.025) print("H0=1 se rechaza")

#p value
(pvalue <- 2*pt(t, df=38, lower.tail = FALSE))

# corroborando el resultado de la prueba mediante la función t.test
install.packages("BSDA")
library(BSDA)
t.test(f2$cocientes, mu=1, alternative="two.sided", conf.level = 0.95)
install.packages()
################################################################################################

```
## RESULTADOS

Los cocientes calculados se añadieron como una columna a la tabla f del Postwork 3 la cual contenía las probailidades conjuntas. Esta nueva tabla se nombró f2.

![ ](https://github.com/AvilaJulio/bedu-ds-equipo6/blob/main/Postwork%203%20y%204/tabla%20f2.jpg)

La columna de cocientes de la tabla f2 fue nuestra muestra a partir de la cual se creó el boostrap, tomando 5000 submuestras con reposición. La Siguentes gráfica muestra la distribución de las medias de cada submuestra. La media poblacional calculada mediante este método es de *1.442547*, con una desviación estándar de *0.1524015*. 

![ ](https://github.com/AvilaJulio/bedu-ds-equipo6/blob/main/Postwork%203%20y%204/distribucion%20boostrap.jpg)

## INTERPRETACIÓN DE LOS RESULTADOS/HALLAZGOS
### Interpretación
El objetivo de hacer el boostrap es estimar parámetros poblacionales a partir de un remuestreo con reemplazo tomado a partir de una sola muestra. 

En este caso, como resultado del boostrap determinamos la media poblacional  (*0.1524015*) y la desviación estándar (*0.1524015*). Estos resultados nos sugiere que la media de los cocientes no es 1, lo cual sugiere dependencia de las variables X (goles del equipo de casa) y Y (goles del equipo visitante).

Al graficar la distribución boostrap de las medias de cada una de las 5000 muestras que se tomaron nos podemos dar cuenta de que se trata de una distribucón normal. 

### Hallazgos
El hecho de que la distribución boostrap muestre un comportamiento normal  nos permite hacer una pruéba de hipótesis t de student para corroborar que la media de los cocientes sea distinta de 1:

 - H0: mu0=1
 - h1: mu0<>1
 
 El p-value de esta prueba de hipótesis (con nivel de confianza del 95%) fue de *0.007102695*. Al ser el p-value inferior al 5% (0.05), se rechaza la hipótesis nula y se corrobora una vez más que la media de los coientes no es igual a 1, asegurando la dependencia de las variables X y Y.


