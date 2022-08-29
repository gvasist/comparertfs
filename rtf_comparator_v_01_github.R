#####################################################################
# Program Name: rtf_comparator_v0_01.R
# Author: Gokul V 
# Version Date: 15-Jun-2022
# Description: This version of rtf comparator compares 2 rtf files. 
#              User has the option to select the files.
#              Output will be in the UI window
#####################################################################

options(shiny.autoreload = TRUE)

library(shiny)
library(diffr)
library(striprtf)
library(readr)

ui <- fluidPage(
  # Main title of the page
  titlePanel(HTML("<center>Comparison of two rtf files</center>")),
  
  # Browse buttons to select files
  sidebarLayout(position="left",
                sidebarPanel(
                    fileInput("selectfolder1","Select file from folder 1"),
                    fileInput("selectfolder2","Select file from folder 2"),
                    # Submit button to perform the compare               
                    actionButton("goButton", "Compare", class = "btn-success")                   
                ),
  
  # Display the output in the HTML window 
  mainPanel(
    diffrOutput("FileDiff", width="600px", height="auto")
  )))


shinyServer(
  
  server <- function(input, output, session){
    
    re1<-reactive({
    if(is.null(input$selectfolder1)){return()}
     else{
        file1<-read_rtf(input$selectfolder1$datapath)
        fileConn1<-tempfile()
        writeLines(file1, fileConn1)
        fileConn1
      }
    })

    
    re2<-reactive({
      if(is.null(input$selectfolder2)){return()}
      else{
        file3<-read_rtf(input$selectfolder2$datapath)
        fileConn2<-tempfile()
        writeLines(file3, fileConn2)
        fileConn2        
       }
    })
    

    output$FileDiff<-renderDiffr({
      if(is.null(input$selectfolder2)){return()}
      else{
        if (input$goButton>1)
          {x<-diffr(re1(),re2(), before="Folder 1",after="Folder 2")}
      }
    })
    
}
)

shinyApp(ui, server)
