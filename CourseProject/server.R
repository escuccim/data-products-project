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
# Turn the factors into numeric
esoph$ageI <- as.numeric(substr(esoph$agegp, 1, 2)) + 5
# Relevel the alcohol and turn it into a number
levels(esoph$alcgp) <- c(20,60,100,140)
esoph$alcI <- as.numeric(substr(esoph$alcgp,1,4))
# Update tobacco
levels(esoph$tobgp)[1] <- "00-09"
esoph$tobI <- as.numeric(substr(esoph$tobgp,1,2)) + 5
# Fit a model
fit <- lm(rate ~ ageI + alcI + tobI, data= esoph)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    predictRate <- reactive({
        age <- as.numeric(input$age)
        alc <- as.numeric(input$alc) * 10
        tob <- as.numeric(input$tob)
        prediction <- predict(fit, newdata = data.frame(ageI= age, alcI=alc, tobI=tob), interval="prediction")
        # Update the results to eliminate negatives
        if(prediction[1] < 0 ){
            prediction[1] <- 0.001
        }
        if(prediction[2] < 0){
            prediction[2] <- 0.001
        }
        if(prediction[3] < 0){
            prediction[3] <- 0.01
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
