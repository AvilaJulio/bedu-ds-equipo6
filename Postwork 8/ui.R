library(shiny)
library(shinydashboard)
library(shinythemes)


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
