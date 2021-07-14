#     POSTWORK - SESIÓN 07
### EQUIPO 6

## INTEGRANTES
- Angélica Luna García
- Jesús Iván Martín Reyes
- Julio Cesar Avila Padilla
- Kimberly Atara Lopez Vazquez
- Manuel Enrique Herrera Flores
- Marco Antonio Hernandez Peñafort


## DESARROLLO
Utilizando el manejador de BDD Mongodb Compass (previamente instalado), deberás de realizar las siguientes acciones:

- **Sección 01:** Alojar el fichero match.data.csv en una base de datos llamada match_games, nombrando al collection como match
- **Sección 02:** Una vez hecho esto, realizar un count para conocer el número de registros que se tiene en la base
- **Sección 03:** Realiza una consulta utilizando la sintaxis de Mongodb en la base de datos, para conocer el número de goles que metió el Real Madrid el 20 de diciembre de 2015 y contra que equipo jugó, ¿perdió ó fue goleada?
- **Sección 04:** Por último, no olvides cerrar la conexión con la BDD.

Notas para los datos de soccer: https://www.football-data.co.uk/notes.txt


## PROCEDIMIENTO

```R
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
```

## RESULTADOS
![](2.jpg)

## INTERPRETACIÓN DE LOS RESULTADOS/HALLAZGOS
De acuerdo con los resultados podemos determinar que el Real Madrid ganó con 10 goles al Vallecano el 20 de diciembre de 2015. Realizamos la consulta utilizando la sintaxis de Mongodb, en la base de datos para conocer el numero de goles que metio el Real Madrid el 20 de diciembre de 2015.
Considero que esta sesión 7 fue muy interesante porque logramos aprender como conectarnos a distintos tipos de bases de datos. 
