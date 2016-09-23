
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Old Faithful Geyser Data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      actionButton("do", "Generate new data"),
      sliderInput("rseed", "Random Seed:",
                  min=1, max=100, value=1),
      actionButton("sample", "Pick a new sample")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("scatter"),
      tableOutput("values"),
      tableOutput("sample_idx")
    )
  )
))
