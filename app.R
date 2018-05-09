library(shiny)
source('results.R')
ui <- fluidPage(
   
  titlePanel("Grade Analysis"),
   
   sidebarLayout(
      sidebarPanel(
         textInput(inputId = 'registrationNumber',label = 'Registration Number',value = 'MDL16CS001')
      ),
      

      mainPanel(
         tabsetPanel(
           tabPanel('Grades',dataTableOutput('Grades')),
           tabPanel('Graphs',plotOutput('Frequency')),
           tabPanel('Course Codes and Names',dataTableOutput('Course'))
         )
      )
   )
)

server <- function(input, output) {
   
   output$Grades <- renderDataTable({arrange(subset(subset(result,Reg_no == input$registrationNumber),select = -Reg_no
   ),Subject)})
   #a <- data.frame(table(subset(result,Reg_no == input$registrationNumber)$Grade))
   output$Frequency <- renderPlot({ggplot(subset(result,Reg_no == input$registrationNumber),aes(Grade))+geom_bar(aes(fill=Exam))+ylab("Frequency")+theme_minimal()})
   output$Course <- renderDataTable({courseNames})
   }

# Run the application 
shinyApp(ui = ui, server = server)

