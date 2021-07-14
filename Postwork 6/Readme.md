#     POSTWORK - SESIÓN 06
### EQUIPO 6

## DESARROLLO
- **Sección 01:** Importa los datos de soccer de la temporada 2019/2020 de la primera división de la liga española a R, los datos los puedes encontrar en el siguiente enlace: https://www.football-data.co.uk/spainm.php
- **Sección 02:** Del data frame que resulta de importar los datos a R, extrae las columnas que contienen los números de goles anotados por los equipos que jugaron en casa (FTHG) y los goles anotados por los equipos que jugaron como visitante (FTAG).
- **Sección 03:** Consulta cómo funciona la función table en R al ejecutar en la consola ```?table```



## PROCEDIMIENTO

```R
# Paso 0 - Cargar las librerías que ocuparemos
suppressMessages(suppressWarnings(library(dplyr))) #Eliminando Warnings


```
## RESULTADOS
Serie de tiempo graficada:

![](1.jpg)

Descomposición de la Serie de tiempo:

![](2.jpg)
## CONSIDERACIONES IMPORTANTES

Para la serie de tiempo, se utilizó una frecuencia igual a 10, puesto que se observó que las temporadas van de agosto a mayo. Por lo anterior, la serie de tiempo se hizo hasta mayo de 2019 y no diciembre de ese mismo año.

## INTERPRETACIÓN DE LOS RESULTADOS/HALLAZGOS

Según los resultados obtenidos, para el periodo analizado de datos, podemos inferir lo siguiente:
- Hay una clara estacionalidad en los datos. Analizando cada ciclo (o temporada), podemos observar que se anotan menos goles a inicio de temporada (agosto) y más goles en los meses octubre-noviembre y a finales de temporada.
- Se observa que las temporadas donde hubo más goles fue la 2012-2013 y la 2016-2017, y donde hubo menos fue la 2015-2016 (esto se ve en la componente “trend” o tendencia).
