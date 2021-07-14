
#Alojar el fichero match.data.csv en una base de datos llamada match_games, nombrando al collection como match
#Instalación de librerias
install.packages("mongolite")

#Uso de libreria
library("mongolite")

#Conexión con Mongolite a la base de datos
conexion <- mongo("match", url = "mongodb+srv://introabd:equipo6ds@cluster0.3kbig.mongodb.net/match_games?retryWrites=true&w=majority")

#Una vez hecho esto, realizar un count para conocer el número de registros que se tiene en la base
print(paste("Número de registros en la base de datos:", conexion$count()))

#Realiza una consulta utilizando la sintaxis de Mongodb en la base de datos, para conocer el número de goles 
#que metió el Real Madrid el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?

consulta <- conexion$find(
  query = '{"date":"2015-12-20","home.team":"Real Madrid"}'
)

#Número de goles que metió el Real Madrid
consulta$home

#Contra que equipo jugó
consulta$away$team

#¿Perdió ó fue goleador?
print(consulta)

#Por último, no olvides cerrar la conexión con la BDD
rm(conexion)

