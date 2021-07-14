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

- **Sección 01:** A partir del conjunto de datos de soccer de la liga española de las temporadas 2017/2018, 2018/2019 y 2019/2020, crea el data frame SmallData, que contenga las columnas date, home.team, home.score, away.team y away.score; esto lo puede hacer con ayuda de la función select del paquete dplyr. Luego establece un directorio de trabajo y con ayuda de la función write.csv guarda el data frame como un archivo csv con nombre soccer.csv. Puedes colocar como argumento row.names = FALSE en write.csv.

- **Sección 02:** Con la función create.fbRanks.dataframes del paquete fbRanks importe el archivo soccer.csv a R y al mismo tiempo asignelo a una variable llamada listasoccer. Se creará una lista con los elementos scores y teams que son data frames listos para la función rank.teams. Asigna estos data frames a variables llamadas anotaciones y equipos.

- **Sección 03:** Con ayuda de la función unique crea un vector de fechas (fecha) que no se repitan y que correspondan a las fechas en las que se jugaron partidos. Crea una variable llamada n que contenga el número de fechas diferentes. Posteriormente, con la función rank.teams y usando como argumentos los data frames anotaciones y equipos, crea un ranking de equipos usando únicamente datos desde la fecha inicial y hasta la penúltima fecha en la que se jugaron partidos, estas fechas las deberá especificar en max.date y min.date. Guarda los resultados con el nombre ranking.

- **Sección 04:** Finalmente estima las probabilidades de los eventos, el equipo de casa gana, el equipo visitante gana o el resultado es un empate para los partidos que se jugaron en la última fecha del vector de fechas fecha. Esto lo puedes hacer con ayuda de la función predict y usando como argumentos ranking y fecha[n] que deberá especificar en date.

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

setwd("F:/Documents/10mo semestre/BECAS/bedu 1/CURSO/MÃDULO 2/SESIÃN 5")
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
