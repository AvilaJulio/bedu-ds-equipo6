# POSTWORK - SESIÓN 05
### EQUIPO 6
#### INTEGRANTES
- Angélica Luna García
- Jesús Iván Martín Reyes
- Julio Cesar Avila Padilla
- Kimberly Atara Lopez Vazquez
- Manuel Enrique Herrera Flores
- Marco Antonio Hernandez Peñafort

## DESARROLLO

- **Sección 01:** A partir del conjunto de datos de soccer de la liga española de las temporadas 2017/2018, 2018/2019 y 2019/2020, crea el data frame SmallData, que contenga las columnas `date`, `home.team`, `home.score`, `away.team` y `away.score`; esto lo puede hacer con ayuda de la función `select` del paquete `dplyr`. Luego establece un directorio de trabajo y con ayuda de la función `write.csv` guarda el data frame como un archivo csv con nombre *soccer.csv*. Puedes colocar como argumento `row.names = FALSE` en `write.csv`.

- **Sección 02:** Con la función `create.fbRanks.dataframes` del paquete `fbRanks` importe el archivo *soccer.csv* a `R` y al mismo tiempo asignelo a una variable llamada `listasoccer`. Se creará una lista con los elementos `scores` y `teams` que son data frames listos para la función `rank.teams`. Asigna estos data frames a variables llamadas `anotaciones` y `equipos`.

- **Sección 03:** Con ayuda de la función `unique` crea un vector de fechas (`fecha`) que no se repitan y que correspondan a las fechas en las que se jugaron partidos. Crea una variable llamada `n` que contenga el número de fechas diferentes. Posteriormente, con la función `rank.teams` y usando como argumentos los data frames `anotaciones` y `equipos`, crea un ranking de equipos usando únicamente datos desde la fecha inicial y hasta la penúltima fecha en la que se jugaron partidos, estas fechas las deberá especificar en `max.date` y `min.date`. Guarda los resultados con el nombre `ranking`.

- **Sección 04:** Finalmente estima las probabilidades de los eventos, el equipo de casa gana, el equipo visitante gana o el resultado es un empate para los partidos que se jugaron en la última fecha del vector de fechas `fecha`. Esto lo puedes hacer con ayuda de la función `predict` y usando como argumentos `ranking` y `fecha[n]` que deberá especificar en `date`.

Notas para los datos de soccer: https://www.football-data.co.uk/notes.txt

## PROCEDIMIENTO

```r
# POSTWORK S5

# Cargando las librerías

library(dplyr)

# 1. Importanto los datos de las temporadas 2017/2018, 2018/2019 y 2019/2020

a <- read.csv("https://www.football-data.co.uk/mmz4281/1718/SP1.csv")
b <- read.csv("https://www.football-data.co.uk/mmz4281/1819/SP1.csv")
c <- read.csv("https://www.football-data.co.uk/mmz4281/1920/SP1.csv")


# 2. Seleccionando Date, HomeTeam, AwayTeam, FTHG, FTAG y FTR de cada df

a5 <- select(a, date=Date, home.team=HomeTeam, away.team=AwayTeam, home.score=FTHG, away.score=FTAG)
b5 <- select(b, date=Date, home.team=HomeTeam, away.team=AwayTeam, home.score=FTHG, away.score=FTAG)
c5 <- select(c, date=Date, home.team=HomeTeam, away.team=AwayTeam, home.score=FTHG, away.score=FTAG)

# Cambiando el formato de fecha
str(a5); str(b5); str(c5)

a5 <- mutate(a5, date = as.Date(date,"%d/%m/%y"))
b5 <- mutate(b5, date = as.Date(date,"%d/%m/%Y"))
c5 <- mutate(c5, date = as.Date(date,"%d/%m/%Y"))


# 3. Creando el archivo soccer.csv

lista5 <- list(a5, b5, c5)
SmallData <- do.call(rbind, lista5)

setwd("F:/Documents/10mo semestre/BECAS/bedu 1/CURSO/MÓDULO 2/SESIÓN 5")
write.csv(SmallData, file = "soccer.csv", row.names = FALSE)

# Instalando el paquete "fbRanks" e importando el archivo soccer.csv

# install.packages("fbRanks")
library(fbRanks)

listasoccer <-create.fbRanks.dataframes("soccer.csv")

anotaciones <-listasoccer$scores
equipos <- listasoccer$teams
head(anotaciones)
head(equipos)

fecha <- unique(anotaciones$date)
n <- length(fecha)


# Creando el ranking de los equipos
ranking <- rank.teams(scores=anotaciones, teams=equipos,
                      max.date=fecha[n-1], min.date=fecha[1])



# EStimando las probabilidades de los eventos

predict(ranking, date = fecha[n])


#########################################################################################

```
## RESULTADOS
El resultado del ranking de equipos (variable *ranking*) es el que se muestra a continuación.

![ ](https://github.com/AvilaJulio/bedu-ds-equipo6/blob/main/Postwork%205/ranking%20de%20equipos.png)

La predicción de las probabilidades de los resultados de los partidos jugados en la última fecha son:

![ ](https://github.com/AvilaJulio/bedu-ds-equipo6/blob/main/Postwork%205/predicciones.png)

Donde 
- HW: Home win (el equipo de casa gana)
- AW: Away win (el equipo visitante gana)
- T: Tie (empate)

## INTERPRETACIÓN DE LOS RESULTADOS/HALLAZGOS
### Interpretación
El ranking de equipos tiene por objetivo calcular la fuerza de ataque y la fuerza de la defensa de cada equipo para después, mediante la función *predict* , para predecir el resultado de los partidos jugados en la última fecha registrada en los datos. 

El ranking muestra que el equipo con mayor fuerza combinada de ataque y defensa es el *Barcelona*, con un total de 1.51, por lo que es muy probable que gane si se tiene un juego entre *Barcelona* y cualquier otro equipo. Por el contrario, el equipo *Las Palmas* es el equipo con menor fuerza combinada de ataque y defensa, por lo que si este equipo juega con cualquier otro, es muy probable que pierda. 

En cuanto a la predicición hecha a partir del rankig de equipos, se ve que de los 10 juegos jugados el 19/07/2020 sólo 3 resultados resultaron acertados:
- Alaves vs Barcelona, HW 9%, AW 75%, T 15%, pred score 0.7-2.5  actual: AW (0-5)
- Villarreal vs Eibar, HW 45%, AW 30%, T 25%, pred score 1.5-1.2  actual: HW (4-0)
- Granada vs Ath Bilbao, HW 40%, AW 31%, T 30%, pred score 1.2-1  actual: HW (4-0)
### Hallazgos
Las predicciones hechas se basaron en el valor del *total*  que obtuvo cada equipo. Por ejemplo, para la predicción del juego entre Alaves (que tuvo un *total=-0.23*) y Barcelona (que tuvo un *total=1.51*), la predicción favoreció al equipo con mayor valor de *total*, es decir, el Barcelona. Sin embargo, la confiabilidad de las prediciones hechas se pone en duda ya que únicamente el 30% de ellas fueron acertadas. 



