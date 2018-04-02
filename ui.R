
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("L-arginine Metabolite Model"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("Arginine",
                  "Relative L-arginine concentration:",
                  min = 0,
                  max = 1.4,
                  value = 0.9),
      sliderInput("Ornithine",
                  "Relative ornithine concentration:",
                  min = 0,
                  max = 3.0,
                  value = 1.15),
      sliderInput("Citrulline",
                  "Relative citrulline concentration:",
                  min = 0,
                  max = 1.6,
                  value = 0.80),
      sliderInput("Proline",
                  "Relative proline concentration:",
                  min = 0,
                  max = 1.4,
                  value = 0.9),
      selectInput("algorithm", "Choose an algorithm",
                  choices = c("Decision Tree", "K-Nearest Neighbors", "Logistic Regression", 
                              "Fast & Frugal", "Random Forest", "Support Vector Machine", "Ensemble"))
      
    ),

    # Show a plot of the generated distribution
    mainPanel(
      p("This app will display the percentage chance of a patient developing AD based on the metabolite concentrations"),
      h2("Results"),
      verbatimTextOutput("results")
    )
  )
))
