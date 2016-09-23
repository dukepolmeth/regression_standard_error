
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
      actionButton("sample", "Pick a new sample"),
      textOutput("equation")
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
