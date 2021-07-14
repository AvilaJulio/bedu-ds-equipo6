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


#########################################################################################

# POSTWORK S6

# Cargando la librería dplyr
library(dplyr)

# Agregando la columna sumagoles al archivo "soccer.csv"

a6 <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2021/main/Sesion-06/Postwork/match.data.csv")
soccer6 <- transform(a6,      
                     sumagoles=a6$home.score+a6$away.score)
head(soccer6)
str(soccer6)
soccer6$date = as.Date(soccer6$date)
str(soccer6)
head(soccer6)

# Obtiendo el promedio por mes de la suma de goles en la tabla c6.

# install.packages("lubridate") #para extraer mes o fracciones de una fecha
library(lubridate)

c6 <- soccer6 %>%
  group_by(year(date), month(date)) %>%
  summarise(goles_promedio=mean(sumagoles))

c6 <- transform(c6, #agregando columna con año y mes
                año_mes=paste(c6$`year(date)`, c6$`month(date)`, "01",  sep = "/"))
str(c6)
c6$año_mes=as.Date(c6$año_mes)
str(c6)

# creando un df con los meses completos

meses_completos <- data.frame(año_mes=seq(floor_date(min(soccer6$date), unit="month"),
                                          floor_date(max(soccer6$date), unit="month"),
                                          by= "month"))
# left join de meses_completos con c6

d6 <- meses_completos %>%
  group_by(meses_redondeados=floor_date(año_mes, unit="month")) %>%
  left_join(c6) %>%
  mutate(goles_promedio=ifelse(is.na(goles_promedio), 0, goles_promedio))


# creando la serie de tiempo

serie_tiempo <- ts(d6$goles_promedio, start = c(2010, 8, 01), 
                   end = c(2019, 12,01), frequency = 12)

serie_tiempo


# graficando la serie de tiempo

ts.plot(serie_tiempo, 
        xlab = "Mes", main = "Promedio mensual de goles", 
        ylab = "Goles promedio", lty = 1:2, 
        col = c("blue"), lwd = 2,
        sub = "Años 2010-2019 ")


