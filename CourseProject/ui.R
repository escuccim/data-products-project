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
       selectInput("agegp",
                   "Please select your age group:",
                   list('25-34','35-44','45-54','55-64','65-74','75+')),
       selectInput("alcgp",
                   "Please select your alcohol consumption:",
                   list('0-39g/day','40-79','80-119','120+')),
       selectInput("tobgp",
                   "Please select your tobacco consumption:",
                   list('0-9g/day','10-19','20-29','30+')),
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
                     p("Make your selections from the drop-downs to the left and press the Calculate button to get an estimation of your chances of having esophogeal cancer.")
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
