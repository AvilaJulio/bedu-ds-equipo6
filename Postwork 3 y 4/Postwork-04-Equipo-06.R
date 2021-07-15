#           EQUIPO 6

#========= DESARROLLO POSTWORK 04 ============

## Cargando las librerías
library(dplyr)

## Añadiedo la fila del cociente

lf <- length(f$p_conj) #long. de las columnas en f
lfar_casa <- length(far_casa$FTHG)
lfar_visit <- length(far_visit$FTAG)

cocientes <- c(0)
for (i in 1:lf) {
  num = f$p_conj[i] # num=numerador
  for(j in 1:lfar_casa){
    if (f$FTHG[i]==far_casa$FTHG[j]) {
      p=j # p=posición
      den1=far_casa$fr_casa[p] #de1=denominador 1
    }
  }
  for(k in 1:lfar_visit){
    if (f$FTAG[i]==far_visit$FTAG[k]) {
      p=k
      den2=far_visit$fr_visit[p]
    }
  }
  cocientes[i]=num/(den1*den2)
}

cocientes <- round(cocientes,3)

f2 <- cbind(f, cocientes)

class(f2) # borrar


# Haciendo el boostrap

set.seed(1)
boostrap <- replicate(n=5000, sample(f2$cocientes, size=39, replace=TRUE))
dim(boostrap)

medias <- apply(boostrap, 2, mean) #medias de cada una de las 5000 submuestras
(xbarra <- mean(f2$cocientes)) #media de la muestra=1.440077
(ee <- sqrt(sum(medias-xbarra)^2)/ncol(boostrap)) #error estándar de la media muestral=0.002470215

## Estos datos muestran que xbarra se encuentra entre 1.440077-0.00247 y 1.440077+0.00247
## por lo que el valor de 1 no encaja y debe realizarse una prueba de hipotesis

ggplot() +
  geom_histogram(aes(x=medias), binwidth=0.05, col="black", fill = "white") + 
  geom_vline(xintercept = xbarra, size=1, color="darkred" )+
  ggtitle("Distribución de las medias muestrales del boostrap") +
  ylab("Freuencia") +
  xlab("Medias") +
  theme_gray()

## Para confirmar el resultado del boostrap, se hará un aprueba de hipótesis t de studen
## ya que no se conoce la varianza poblacional, con nivel de confianza de 0.95 (alpha=0.05/2=0.025)

### H0: mu0=1
### h1: mu0<>1

### etadístico de prueba t
 
(t=(xbarra-1)/ee)

### criterio de decisión (alpha=0.025)
(cd <- qt(p = 0.025, df = 38))

### dado que t=178.153 > cd=1.960 se rechaza la Ho, es decir, la media es distinta de 1. 
