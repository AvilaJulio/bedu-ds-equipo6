# Equipo 6 😎

Post works de evidencia para la Fase 3 del curso de Data Science de **Bedu**

## Integrantes:
 - Angélica Luna García
 - Jesús Iván Martín Reyes
 - Julio Cesar Avila Padilla
 - Kimberly Atara Lopez Vazquez
 - Manuel Enrique Herrera Flores
 - Marco Antonio Hernandez Peñafort

## Postworks
## **1. Identificación del problema**

### MARCO TEÓRICO
La violencia en nuestro país es un problema grave. Las 6 ciudades más violentas del mundo están en México (EL PAÍS, 2021). Durante el 2018 se cometieron 33 millones de delitos en todo el país, asociados a 24.7 millones de víctimas, lo que significa que uno de cada tres hogares (33.9%) fue objeto de algún ilícito dicho año (INEGI). 

En la CDMX, donde hay más de 9 millones de habitantes (INEGI, 2020), domina la violencia, la inseguridad y, sobre todo, la impunidad. En la Ciudad de México, el 97.7 por ciento de los delitos queda impune. (México Evalúa, 2019).

Estos datos son sumamente alarmantes, pues muestran un claro problema que aqueja a la sociedad y, a pesar de esto, las autoridades no parecen estar atacándolo de la manera correcta. 

“En nuestro país existe una tendencia generalizada a no resolver y/o solucionar los delitos que se conocen, a pesar de que sólo una pequeña parte de los delitos ocurridos llegan al conocimiento de las autoridades.”

Mucho se ha especulado sobre este tema, muchos medios han publicado sus propios datos, y es por ello que nosotros hemos decidido trabajar con la base de datos OFICIAL que publica y actualiza el mismo gobierno capitalino, para poder identificar aquellas colonias y alcaldías en donde se cometen más delitos, observar tendencias, y poder sugerir acciones para atacar aquellas zonas más conflictivas.
### JUSTIFICACIÓN
Se eligió trabajar en este dataset por múltiples razones:
-	Trata un tema de relevancia social, puesto que a todas y todos nos concierne nuestra seguridad y bienestar.
-	Transparencia en los datos: todos los ciudadanos de la Ciudad de México, aquellos de la zona metropolitana que frecuentan dicha ciudad, y otros visitantes ya sean habituales o esporádicos, tienen el derecho a poder consultar dicha información, de una manera sencilla y entendible, por lo que decidimos darnos a la tarea de limpiar y filtrar los datos para en un futuro cercano poder visualizarlos a través de gráficos y mapas que faciliten su interpretación y valoración.
-	Al poder interpretar dicha información, nos podemos hacer cuestionamientos relevantes y forjarnos una opinión acerca de la condición actual de seguridad en la CDMX, que nos permitan exigir a nuestros gobernantes (con base en información fidedigna) que atiendan con mayor eficacia aquellos delitos que se encuentran al alza y focalicen esfuerzos en aquellas delegaciones y colonias donde se muestren tendencias más marcadas de delitos graves.
-	Es un proyecto escalable, puesto que, el análisis que se haga de la CDMX, se puede replicar en otras ciudades del país. El proyecto, además, tiene mucho potencial para posteriormente generar gráficos, mapas y demás figuras visuales que nos permitan interpretar aún más a fondo los datos.

## **2. Planteamiento de preguntas**

A través del análisis de la base de datos elegida, pretendemos dar respuesta a los siguientes cuestionamientos:

- ¿Qué tipos de delitos se cometen con mayor frecuencia?
- ¿En qué colonias y alcaldías se cometen el mayor número de delitos graves?
- ¿Qué tipos de delito han mostrado un crecimiento y decrecimiento en los últimos años? ¿En qué medida?
- ¿Qué tipos de delitos son los que más se cometen por alcaldía?
- ¿Qué delitos han son más comúnes cada año?
- ¿Hay horarios en el día en el que se cometen mayor número de algún tipo de delito?

## 3. **Colección de datos**

La colección de datos se obtuvo del Portal de datos abietos del Gobierno de la Ciudad de México. La colección se llama [*Carpetas de Investigación de la FGJ*](https://archivo.datos.cdmx.gob.mx/fiscalia-general-de-justicia/carpetas-de-investigacion-fgj-de-la-ciudad-de-mexico/carpetas_completa_junio_2021.csv "Carpetas de Investigación de la FGJ"), el cual puedes descargar en formato csv dando clic sobre el nombre. Si deseas descargarlo directamente de la página del Portal de datos abiertos, haz click [*aquí*](https://datos.cdmx.gob.mx/dataset/carpetas-de-investigacion-fgj-de-la-ciudad-de-mexico/resource/48fcb848-220c-4af0-839b-4fd8ac812c0f "aquí").

Esta base de datos contiene la información actualizada de las carpetas de investigación de la Fiscalía General de Justicia (FGJ) de la Ciudad de México a partir de enero de 2016. Las variables que contiene esta base son Carpetas de investigación de delitos a nivel de calle de la FGJ por Fiscalía, Agencia, Unidad de Investigación, fecha de apertura de la carpeta de investigación, delito, categoría de delito, calle, colonia, alcaldía, coordenadas, mes y año. Esta información se actualiza mensualmente.

En el siguiente link podrás encontrar el proyecto completo:
- [PROYECTO MÓDULO 3 BEDU](https://github.com/AvilaJulio/bedu-ds-equipo6/blob/main/Modulo%203/PROYECTO_M%C3%93DULO_3_BEDU.ipynb)

Donde se aborda, además de lo ya presentado aquí, los siguientes puntos:
### [4. **Análisis exploratorio de datos**](https://colab.research.google.com/drive/1395mJZA636HbZxJhbg7eRGa2aCNxuo7f#scrollTo=21H2MRMpT_cQ "4. **Análisis exploratorio de datos**")

### [**5. Limpieza de datos**](https://colab.research.google.com/drive/1395mJZA636HbZxJhbg7eRGa2aCNxuo7f#scrollTo=y6QHitbmwfd1 "**5. Limpieza de datos**")

### [**6. Transformación de datos**](https://colab.research.google.com/drive/1395mJZA636HbZxJhbg7eRGa2aCNxuo7f#scrollTo=bsDt25LmI3ON "**6. Transformación de datos**"), en donde se ofrece la solución a las preguntas planteadas.
### [**6. Uso de APIs**]()

