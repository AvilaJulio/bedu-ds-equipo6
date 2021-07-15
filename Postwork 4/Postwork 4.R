
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

  
