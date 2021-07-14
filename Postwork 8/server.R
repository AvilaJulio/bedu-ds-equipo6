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
