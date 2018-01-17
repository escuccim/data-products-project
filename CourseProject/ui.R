#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Estimation of Risk for Esophogeal Cancer"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       textInput("age",
                   "Please enter your age:", value=35),
       textInput("alc",
                   "Please enter the average number of drinks per day:",
                   value=1),
       textInput("tob",
                   "Please enter the number of cigarettes you smoke per day:",
                   value=0),
       submitButton("Calculate my risk")
    ),

    # Show a plot of the generated distribution
    mainPanel(
        tabsetPanel(
            tabPanel("My Risk",
                     br(),
                     h3("Your chances of having esophogeal cancer:"),
                     textOutput("prediction"),
                     h4("With a confidence interval of:"),
                     textOutput("confInt")
             ),
            tabPanel("Instructions",
                     br(),
                     p("Enter your information in the inputs to the left and press the Calculate button to get an estimation of your chances of having esophogeal cancer.")
            ),
            tabPanel("Information",
                     br(),
                     p("This estimate is based on a case-control study of esophageal cancer in Ille-et-Vilaine, France in 1980."),
                     p("This data is merely a prediction based on the results of the study, it should not be used for any medical purposes. If you are worried about esophogeal cancer you should see a doctor.")
             )
        )

    )
  )
))
