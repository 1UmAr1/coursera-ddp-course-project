# load the necessary libraries
library(shiny)
library(ggplot2)
library(maps)
library(mapdata)

# Define server logic required to draw the map and selected state
shinyServer(function(input, output) {
  
  # load state mapping data
  states <- map_data("world")
  sel_dept <- reactive({
    subset(states, region %in% input$sel_dept)
  })
  
  output$mapPlot <- renderPlot({
    
    # draw the US map with the selected state highlighted in blue
    ggplot(data = states) + 
      geom_polygon(aes(x = long, y = lat, group = group), fill = "gray", color = "black") + 
      coord_fixed(1.3) +
      guides(fill=FALSE) + geom_polygon(data=sel_dept(), aes(x = long, y = lat, group = group), fill = "blue")
    
  })
  
})