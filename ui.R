
library(shiny)

f<-file("data/list.csv",encoding="big5")
roadlist<-read.csv(f)

shinyUI(fluidPage(

 titlePanel("道路養護巡查路段抽選"),

  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "抽選路段數:",
                  min = 1,
                  max = nrow(roadlist),
                  value = 24)
    ),

    mainPanel(
      plotOutput("maplist1"),
      plotOutput("maplist2"),
      dataTableOutput("table"),
      downloadButton('downloadData', '下載抽選結果CSV檔')
    )
  )
))
