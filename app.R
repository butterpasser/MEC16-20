#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source('results.R')
# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Grade Analysis"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         textInput(inputId = 'registrationNumber',label = 'Registration Number',value = 'MDL16CS001')
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         tabsetPanel(
           tabPanel('Grades',dataTableOutput('Grades')),
           tabPanel('Graphs',plotOutput('Frequency')),
           tabPanel('Course Codes and Names',dataTableOutput('Course'))
         )
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$Grades <- renderDataTable({arrange(subset(subset(result,Reg_no == input$registrationNumber),select = -Reg_no
   ),Subject)})
   output$Frequency <- renderPlot({barplot(table(subset(result,Reg_no == input$registrationNumber)$Grade),xlab="Grades",ylab="Frequency")})
   output$Course <- renderDataTable({courseNames})
   }

# Run the application 
shinyApp(ui = ui, server = server)

