# POSTWORK 3 
## Este postwork require la variable "datos" creado en el Postwork 2
## cargando las librerías

library(ggplot2)

##  Extrayendo las columnas FTHG (casa)  y FTAG (visitantes) para hacer las tablas

a <- select(datos, FTHG)   #a=datos de equ. que juegan en casa
b <- select(datos, FTAG)   #b=datos de equ. de juegan como visit


## Agregando una columna de frecuencias absolutas a cada tabla

fa_casa <- as.data.frame(table(FTHG = a$FTHG)) #fa_casa= frec. abs. de equipos que juegan en casa
fa_casa
fa_visit <- as.data.frame(table(FTAG = b$FTAG))

sum(fa_casa$Freq); sum(fa_visit$Freq) #borr

## Agregando las frecuencias relativas a los df's. Estas frec. rel. son las probabilidades marginales.

far_casa <- transform(fa_casa,   #far_casa= frec. abs. y rel. de equipos que juegan en casa   
                      fr_casa=round(prop.table(Freq),3))
far_visit <- transform(fa_visit,     
                       fr_visit=round(prop.table(Freq),3))

## La probabilidad (conjunta) de que el equipo que juega en casa anote x goles y el equipo que
## juega como visitante anote y goles (x = 0, 1, 2, ..., y = 0, 1, 2, ...) es la columna "p_conj"
## en la siguiente tabla:

c <- datos[,c("FTHG", "FTAG" )]
str(c) # borr


d <- #tabla de frecuencias conjuntas
  c %>%
  group_by(FTHG, FTAG) %>%
  summarise(frecuencia = n())

e <- colSums(d[,"frecuencia"]) # e = No. de observaciones = 1140


f <- #tabla de frecuencias conjuntas y probabilidades conjuntas
  transform(d,     
            p_conj=round(prop.table(frecuencia),3))

##  Gráfico de barras para las prob. marg. del nÃºmero de goles que anota el equipo de casa.

far_casa %>%
  ggplot() +
  aes(x=FTHG, y=fr_casa)+ 
  geom_bar(stat="identity", col="blue", fill = "orange")+
  ggtitle("Probabilidades marginales del nÃºmero de goles que anota el equipo de casa") +
  ylab("Freuencia relativa") +
  xlab("Goles anotados") +
  theme_light()+
  geom_text(aes(label = round(fr_casa, 3)), vjust=1.5, color="blue")


##  GrÃ¡fico de barras para las prob. marg. del nÃºmero de goles que anota el equipo de visitante.

far_visit %>%
  ggplot() +
  aes(x=FTAG, y=fr_visit)+ 
  geom_bar(stat="identity", col="orange", fill = "green")+
  ggtitle("Probabilidades marginales del nÃºmero de goles que anota el equipo visitamte") +
  ylab("Freuencia relativa") +
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
