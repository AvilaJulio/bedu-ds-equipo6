#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    library(ggplot2)
    
    match_data <- read.csv("match.data.csv")
    
    #Gráfico de Histograma
    output$plot1 <- renderPlot({
        
        x <- mtcars[,input$x]
        bin <- seq(min(x), max(x), length.out = input$bins + 1)
        
        ggplot(mtcars, aes(x, fill = mtcars[,input$zz])) + 
            geom_histogram( breaks = bin) +
            labs( xlim = c(0, max(x))) + 
            theme_light() + 
            xlab(input$x) + ylab("Frecuencia") + 
            facet_grid(input$zz)
        
        
    })
    
    
    #Data Table
    output$data_table <- renderDataTable( {match_data}, 
                                          options = list(aLengthMenu = c(10,15,25,50),
                                                         iDisplayLength = 15)
    )
    

})
