
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("What does it mean for the regression coefficient to have a 'standard error'?"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      p("First, let's simulate the population data"),
      actionButton("do", "Simulate population data"),
      br(), br(),
      p("Then, let's choose a random sample from this population,
        then fit a regression line for y against x."),
      actionButton("sample", "Pick a random sample"),
      br(), br(),
      p("Notice how the model coefficients are slightly different each time due to the random sampling.
        Together, these slightly different values make up the sampling distribution of the coefficients.
        The standard error is the standard deviation of this sampling distribution."), br(),
      p("True Equation: y = 1 + 2x + u"),
      textOutput("equation"), br(),
      textOutput("beta"), br(),
      textOutput("nsims")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("scatter"),
      plotOutput("histogram"),
      # tableOutput("values"),
      # tableOutput("sample_idx"),
      tableOutput("model")
    )
  )
))
