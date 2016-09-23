
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)

f_gen_data <- function(n) {
  x <- rnorm(n)
  y <- 1 + 2 * x + rnorm(n)
  return(data.frame(x, y))
}

shinyServer(function(input, output, session) {
  n <- 100

  gen_data <- eventReactive(input$do, {
    f_gen_data(n)
  })

  gen_sample <- eventReactive(input$sample, {
    sample(n, floor(n/4), replace=TRUE)
  })

  output$values <- renderTable(gen_data())

  output$sample_idx <- renderTable(gen_sample())

  output$scatter <- renderPlot({
    data <- gen_data()
    sample_idx <- gen_sample()
    my_sample <- data[sample_idx, ]
    base_plot <- ggplot(data = data, aes(x, y)) + geom_point() +
      geom_point(data = my_sample, color = "red") +
      geom_smooth(data = my_sample, method = "lm")
    print(base_plot)
  })
})
