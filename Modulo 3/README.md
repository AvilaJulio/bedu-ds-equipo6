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
---
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
---
A través del análisis de la base de datos elegida, pretendemos dar respuesta a los siguientes cuestionamientos:

- ¿Qué tipos de delitos se cometen con mayor frecuencia?
- ¿En qué colonias y alcaldías se cometen el mayor número de delitos graves?
- ¿Qué tipos de delito han mostrado un crecimiento y decrecimiento en los últimos años? ¿En qué medida?
- ¿Qué tipos de delitos son los que más se cometen por alcaldía?
- ¿Qué delitos han son más comúnes cada año?
- ¿Hay horarios en el día en el que se cometen mayor número de algún tipo de delito?

## 3. **Colección de datos**
---
La colección de datos se obtuvo del Portal de datos abietos del Gobierno de la Ciudad de México. La colección se llama [*Carpetas de Investigación de la FGJ*](https://archivo.datos.cdmx.gob.mx/fiscalia-general-de-justicia/carpetas-de-investigacion-fgj-de-la-ciudad-de-mexico/carpetas_completa_junio_2021.csv "Carpetas de Investigación de la FGJ"), el cual puedes descargar en formato csv dando clic sobre el nombre. Si deseas descargarlo directamente de la página del Portal de datos abiertos, haz click [*aquí*](https://datos.cdmx.gob.mx/dataset/carpetas-de-investigacion-fgj-de-la-ciudad-de-mexico/resource/48fcb848-220c-4af0-839b-4fd8ac812c0f "aquí").

Esta base de datos contiene la información actualizada de las carpetas de investigación de la Fiscalía General de Justicia (FGJ) de la Ciudad de México a partir de enero de 2016. Las variables que contiene esta base son Carpetas de investigación de delitos a nivel de calle de la FGJ por Fiscalía, Agencia, Unidad de Investigación, fecha de apertura de la carpeta de investigación, delito, categoría de delito, calle, colonia, alcaldía, coordenadas, mes y año. Esta información se actualiza mensualmente.

## **4. Análisis exploratorio de datos**

### 4.1 Convertir el archivo CVS a un DataFrame de pandas
```python
# Realizamos la importación de la librería pandas:
import pandas as pd

# Leemos el archivo csv y consultamos el tipo de archivo generado:
df = pd.read_csv('https://archivo.datos.cdmx.gob.mx/fiscalia-general-de-justicia/carpetas-de-investigacion-fgj-de-la-ciudad-de-mexico/carpetas_completa_junio_2021.csv', sep=',')
type(df)

```
### 4.2 Análisis exploratorio
```python
# Consultamos las dimensiones de nuestro 'df':
df.shape

# Consultamos las primeras 3 entradas del 'df':
df.head(3)

# Consultamos las últimas 3 entradas del 'df':
df.tail(3)

# Revisamos el tipo de datos de cada columna y si contienen NaN's:
df.info()
```
img_1
## **5. Limpieza de datos**

Antes de verificar la existencia de NaN eliminamos las columnas que no aportan información reelevante a nuestros objtivos y filtramos los datos a partir del año en que existe mayor número de registros de delitos y contenplando únicamente las alcadías de la CDMX.

### 5.1 Eliminando columnas
```python
# Eliminando 6 columnas que no serán parte del analisis:
df_dropped = df.drop(columns=["unidad_investigacion", "agencia", "tempo", "competencia", "calle_hechos", "calle_hechos2"])
df_dropped.info()
```
### 5.2 Filtrando los datos
```python
# Analizamos a  partir de qué año es pertinente filtrar los datos de acuerdo a la incidencia de delitos:
df_dropped.groupby('ao_hechos')['categoria_delito'].count().tail(20)

# Con base en lo anterior decidimos filtrar los datos a partir del 'ao_hechos'>=2016:
df_filtrado_1=df_dropped.loc[df_dropped['ao_hechos']>=2016]
print(df_filtrado_1.head(3))
print(df_filtrado_1.info())

# Contamos cuántas alcaldías están presentes en el df 'df_filtrado_1':
df_filtrado_1['alcaldia_hechos'].unique()

# Al notar que la columna 'alcaldia_hechos' contiene alcaldías de todo el país, filtramos únicamente aquellas que corresponden a la CDMX
# (16 alcaldías):
alcadias_cdmx = ['BENITO JUAREZ',
  'IZTAPALAPA',
  'CUAUHTEMOC',
  'TLAHUAC',
  'IZTACALCO',
  'GUSTAVO A MADERO',
  'MIGUEL HIDALGO',
  'TLALPAN',
  'ALVARO OBREGON',
  'VENUSTIANO CARRANZA',
  'AZCAPOTZALCO',
  'CUAJIMALPA DE MORELOS',
  'COYOACAN',
  'XOCHIMILCO',
  'LA MAGDALENA CONTRERAS',
  'MILPA ALTA'
 ]

df_filtrado_2 = df_filtrado_1.loc[df_filtrado_1['alcaldia_hechos'].isin(alcadias_cdmx)]
print(df_filtrado_2["alcaldia_hechos"].unique())
print("\n")
print(df_filtrado_2.info())
```
### 5.3 Eliminando los NaN 

```python
# Contamos cuántos NaN existen en cada columna:
df_filtrado_2.isna().sum()

# Ahora eliminamos las filas que contienen puros NaN (si las hay):
df_sin_nan_1=df_filtrado_2.dropna(axis=0, how='all')
df_sin_nan_1

# Al ejecutar la  instrucción anterior no se eliminó ninguna fila, por lo que se asume que ninguna fila contenía puros NaN.

# Ahora eliminamos los registros con NaN en las columnas de fecha_inicio y fiscalia, debido a su poca signficancia estadística:
df_sin_nan_2 = df_sin_nan_1.loc[df_sin_nan_1['fiscalia'].notna()]
df_sin_nan_3 = df_sin_nan_2.loc[df_sin_nan_2['fecha_inicio'].notna()]
df_sin_nan_4 = df_sin_nan_3.loc[df_sin_nan_3["latitud"].notna()]
df_sin_nan_5 = df_sin_nan_4.loc[df_sin_nan_4["longitud"].notna()]

df_sin_nan_5.isna().sum()

# Ahora remplazamos los NaN de la columna 'colonia_hechos' por la palabra Unknown para eliminar completamente los NaN:
df_sin_nan_5["colonia_hechos"] = df_sin_nan_5["colonia_hechos"].fillna('Unknown')
df_sin_nan_5.isna().sum()

# En los casos en los que la latitud y longitud no existe se evaluará posteriormente la posibilidad de colocar la latitud y longitud de la alcadia de
# acuerdo a datos del gobierno de la CDMX: https://datos.cdmx.gob.mx/dataset/bae265a8-d1f6-4614-b399-4184bc93e027/resource/e4a9b05f-c480-45fb-a62c-6d4e39c5180e/download/alcaldias.csv

# lat_long_alcaldias = pd.read_csv("https://datos.cdmx.gob.mx/dataset/bae265a8-d1f6-4614-b399-4184bc93e027/resource/e4a9b05f-c480-45fb-a62c-6d4e39c5180e/download/alcaldias.csv")


```
### 5.4 Reseteando los índices
```python
# Reseteamos los indices, pues hemos eliminado algunas filas:
df_indice_reseteado = df_sin_nan_5.reset_index(drop=True)
print(df_indice_reseteado.shape)
print('\n')
print(df_indice_reseteado.head(3))
print('\n')
print(df_indice_reseteado.tail(3))
```
