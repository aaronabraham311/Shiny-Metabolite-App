
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

  library(caret)
  library(FFTrees)
  
  rpartModel <- readRDS("loocv_cart.rds")
  knnModel <- readRDS("loocv_knn.rds")
  logModel <- readRDS("loocv_log.rds")
  fftModel <- readRDS("fft_model.rds")
  rfModel <- readRDS("loocv_rf.rds")
  svmModel <- readRDS("loocv_svm.RDS")
  ensembleModel <- readRDS("ensemble.rds")
  
  algorithmInput <- reactive(input$algorithm)
  output$results <- renderPrint ({
    df = data.frame(
        Arginine = input$Arginine,
        Citrulline = input$Citrulline,
        Ornithine = input$Ornithine,
        Proline = input$Proline )
    
    if (algorithmInput() == "Decision Tree")
    {
      pred <- predict(rpartModel, df, type = "prob")
      print(pred)
    }
    else if (algorithmInput() == "K-Nearest Neighbors")
    {
      pred <- predict(knnModel, df)
      print(pred)
    }
    else if (algorithmInput() == "Logistic Regression")
    {
      pred <- predict(logModel, df, type = "prob")
      print(pred)
    }
    else if (algorithmInput() == "Fast & Frugal")
    {
      pred <- predict(fftModel, df)
      print(pred)
    }
    else if (algorithmInput() == "Random Forest")
    {
      pred <- predict(rfModel, df, type = "prob")
      print(pred)
    }
    else if (algorithmInput() == "Support Vector Machine")
    {
      pred <- predict(svmModel, df)
      print(pred)
    }
    else if (algorithmInput() == "Ensemble")
    {
      df$cartPredictions <- predict(rpartModel, df)
      df$knnPredictions <- predict(knnModel, df)
      df$logPredictions <- predict(logModel, df)
      df$rfPredictions <- predict(rfModel, df)
      df$svmPredictions <- predict(svmModel, df)
      
      pred <- predict(ensembleModel, df, type = "prob")
      print(pred)
    }
    else 
    {
      print("Error: No algorithm selected")
    }
  }) 
})
