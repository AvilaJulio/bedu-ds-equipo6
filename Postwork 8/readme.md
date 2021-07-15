#     POSTWORK - SESIÓN 08
### EQUIPO 6

## INTEGRANTES
- Angélica Luna García
- Jesús Iván Martín Reyes
- Julio Cesar Avila Padilla
- Kimberly Atara Lopez Vazquez
- Manuel Enrique Herrera Flores
- Marco Antonio Hernandez Peñafort


## DESARROLLO

Para este postwork genera un dashboard en un solo archivo `app.R`, para esto realiza lo siguiente: 

- Ejecuta el código `momios.R`

- Almacena los gráficos resultantes en formato `png` 

- Crea un dashboard donde se muestren los resultados con 4 pestañas:
   
- Una pestaña con gráficas de barras, donde en el eje de las _X_ se muestren los goles de local y visitante, con un menu de selección (en _choices_ deben aparecer éstas variables), utiliza la geometría de tipo _barras_, además de hacer un facet_wrap con la variable de el _equipo visitante_
   
- Realiza una pestaña donde agregues las imágenes de las gráficas del postwork 3
    
- En otra pestaña coloca el data table del fichero `match.data.csv` 
    
- Por último en otra pestaña agrega las imágenes de las gráficas de los factores de ganancia promedio y máximo


## PROCEDIMIENTO

#### `server.R`

```R
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    library(ggplot2)
    
    match_data <- read.csv("match.data.csv")
    #ggplot(scores, aes(x=home.score)) + geom_bar() + facet_wrap(~ away.team)
    
    #Gráfico de Histograma
    output$plot1 <- renderPlot({
        
        x <- match_data[,input$x]
        
        ggplot(match_data, aes(x)) + 
            geom_bar() +
            theme_light() + 
            xlab(input$x) + ylab("Goles") + 
            facet_wrap(~away.team)
    })
    
    
    #Data Table
    output$data_table <- renderDataTable( {match_data}, 
                                          options = list(aLengthMenu = c(10,15,25,50),
                                                         iDisplayLength = 15)
    )
    

})
```

`ui.R`
````R
library(shiny)
library(shinydashboard)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        
        dashboardPage(
            
            dashboardHeader(title = "PW 8 - Equipo 6"),
            
            dashboardSidebar(
                
                sidebarMenu(
                    menuItem("Gráficos de barra", tabName = "bars", icon = icon("bar-chart")),
                    menuItem("Goles casa-visitante", tabName = "graph", icon = icon("area-chart")),
                    menuItem("Data Table", tabName = "data_table", icon = icon("table")),
                    menuItem("Factores de ganancia", tabName = "img", icon = icon("file-picture-o"))
                )
                
            ),
            
            dashboardBody(
                
                tabItems(
                    
                    # Histograma
                    tabItem(tabName = "bars",
                            fluidRow(
                                titlePanel("Goles a favor y en contra por equipo"), 
                                selectInput(
                                    "x",
                                    "Seleccione el valor de X",
                                    choices = c("home.score", "away.score")
                                ),
                                box(
                                    plotOutput("plot1", height = 600, width = 700)
                                ),
                            )
                    ),
                    
                    # PW 3
                    tabItem(tabName = "graph",
                            tabsetPanel(
                                tabPanel(
                                    "Gráfico 1",
                                    fluidRow(
                                        titlePanel(h3("Probabilidades marginales del número de goles que anota el equipo de casa")),
                                        img(src ="1.png", width = 450, height = 450)
                                    )
                                ),
                                tabPanel(
                                    "Gráfico 2",
                                    fluidRow(
                                        titlePanel(h3("Prob. marg. del número de goles que anota el equipo de visitante")),
                                        img(src ="2.png", width = 450, height = 450)
                                    )
                                ),
                                tabPanel(
                                    "Gráfico 3",
                                    fluidRow(
                                        titlePanel(h3("HeatMap para las probabilidades conjuntas")),
                                        img(src ="3.png", width = 450, height = 450)
                                    )
                                )
                            )
                    ),
                    
                    
                    # data table
                    tabItem(tabName = "data_table",
                            fluidRow(        
                                titlePanel(h3("Data Table")),
                                dataTableOutput ("data_table")
                            )
                    ), 
                    
                    tabItem(tabName = "img",
                            tabsetPanel(
                                tabPanel(
                                    "Máx.",
                                    fluidRow(
                                        titlePanel(h3("Factores de ganancia máximo")),
                                        img(src ="momio_max.png", height = 450)
                                        
                                    )
                            ),
                                tabPanel(
                                    "Avg.",
                                    fluidRow(
                                        titlePanel(h3("Factores de ganancia promedio")),
                                        img(src ="momio_avg.png", height = 450)
                                )
                            )
                        )
                    )
                    
                )
            )
        )
    )
    
)
````

##Resultados

![Pestaña 1](https://github.com/AvilaJulio/bedu-ds-equipo6/blob/main/Postwork%208/screenshots/1.png)
