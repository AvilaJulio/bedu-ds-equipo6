library(shiny)

shinyServer(function(input, output) {

    library(ggplot2)
    
    match_data <- read.csv("match.data.csv")
    
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
