# POSTWORK S5

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
