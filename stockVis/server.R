# server.R

library(quantmod)
source("helpers.R")

shinyServer(function(input, output) {

  dataInput <- reactive({
    getSymbols(input$symb,
               src = "yahoo",
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
  })

  adjInput <- reactive({
    data <- dataInput()
    if (input$adjust)
      adjust(data)
    else
      data
  })

  output$plot <- renderPlot({
    chartSeries(adjInput(), theme = chartTheme("white"),
                type = "line", log.scale = input$log, TA = NULL)
  })

})
