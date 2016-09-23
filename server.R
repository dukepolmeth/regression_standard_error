
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)

f_gen_data <- function(n) {
  x <- rnorm(n)
  y <- 1 + 2 * x + rnorm(n, sd = 1.5)
  return(data.frame(x, y))
}

beta <- vector("numeric")

shinyServer(function(input, output, session) {
  n <- 100

  gen_data <- eventReactive(input$do, {
    f_gen_data(n)
  })

  gen_sample <- eventReactive(input$sample, {
    sample(n, floor(n/4), replace=TRUE)
  })

  output$values <- renderTable(gen_data())
  output$sample_idx <- renderTable(data.frame(sample_ID = gen_sample()))

  output$model <- renderTable({
    data <- gen_data()
    my_sample <- data[gen_sample(), ]

    m <- lm(y ~ x, my_sample)
    beta[length(beta)+1] <<- coef(m)["x"]
    data.frame(beta)
  })

  output$scatter <- renderPlot({
    data <- gen_data()
    my_sample <- data[gen_sample(), ]

    base_plot <- ggplot(data = data, aes(x, y)) + geom_point() +
      geom_point(data = my_sample, color = "red") +
      geom_smooth(data = my_sample, method = "lm") +
      coord_cartesian(xlim = c(-3, 3), ylim = c(-7, 7))
    print(base_plot)
  })

  output$histogram <- renderPlot({
    gen_sample()
    hist <- ggplot(data = data.frame(beta)) +
      geom_histogram(aes(x = beta), binwidth = 0.2) +
      coord_cartesian(xlim = c(0, 4))
    print(hist)
  })

  output$equation <- renderText({
    data <- gen_data()
    my_sample <- data[gen_sample(), ]

    m <- lm(y ~ x, my_sample)
    l <- list(a = format(coef(m)[1], digits = 2),
              b = format(abs(coef(m)[2]), digits = 2),
              r2 = format(summary(m)$r.squared, digits = 3))
    paste0("y = ", l$a, " + ", l$b, "* x")
  })
})
