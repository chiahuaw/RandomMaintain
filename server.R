
library(shiny)
library(ggmap)
library(ggplot2)


shinyServer(function(input, output) {

  f<-file("data/list.csv",encoding="big5")
  roadlist<<-read.csv(f)
  g1<-ggmap(get_map(location = c(lon = 118.375, lat = 24.445), zoom = 12, maptype = "terrain"))
  g2<-ggmap(get_map(location = c(lon = 118.240, lat = 24.430), zoom = 14, maptype = "terrain"))
  
  output$table <- renderDataTable({

  roadPickup<<-roadlist[sample(seq(1,nrow(roadlist),1),input$bins),]  
  roadPickup[order(roadPickup[,5]),c(1:5)]  
  })
  
  output$maplist1<-renderPlot({
    roadPickup[c(1:input$bins),]
    g1 + geom_point(data=roadPickup,aes(x=lon,y=lat,col="red"),size=3)
  })
  
  output$maplist2<-renderPlot({
    roadPickup[c(1:input$bins),]
    g2 + geom_point(data=roadPickup,aes(x=lon,y=lat,col="red"),size=5)
  })
  
  output$downloadData <- downloadHandler(
    filename = function() { paste('RandomRoad_',Sys.Date(),'.csv',sep="")},
    content = function(file) {
      write.csv(roadPickup[order(roadPickup[,5]),], file,row.names=FALSE,fileEncoding = "big5")
    }
  )
  

})
