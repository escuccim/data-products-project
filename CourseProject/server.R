#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
# Load the data
data(esoph)
# Add the rate for the group
esoph$rate <- esoph$ncases / (esoph$ncases + esoph$ncontrols)
# Fit a model
fit <- lm(rate ~ agegp + alcgp + tobgp, data= esoph)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    predictRate <- reactive({
        prediction <- predict(fit, newdata = data.frame(agegp= input$agegp, alcgp=input$alcgp, tobgp=input$tobgp), interval="prediction")
        # Update the results to eliminate negatives
        if(prediction[1] < 0 ){
            prediction[1] <- 0
        }
        if(prediction[2] < 0){
            prediction[2] <- 0
        }
        if(prediction[3] < 0){
            prediction[3] <- 0
        }
        prediction <- round(prediction * 100, 2)
    })

    output$prediction <- renderText({
        paste(round(predictRate()[1], 2), "%")
    })
    output$confInt <- renderText({
        paste(predictRate()[2], '% to ', predictRate()[3], ' %')
    })

})
