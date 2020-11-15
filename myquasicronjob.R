Sys.setenv(TZ='Europe/Berlin')
mydata <-
  read.csv('https://www.arcgis.com/sharing/rest/content/items/f10774f1c63e40168479a1feb6c7ca74/data',encoding = 'UTF-8',nrows = 1)
lastModified <- mydata$Datenstand
print(paste0('Content Last Modified: ',lastModified))
while(TRUE==TRUE){
  mydata <-
    read.csv('https://www.arcgis.com/sharing/rest/content/items/f10774f1c63e40168479a1feb6c7ca74/data',encoding = 'UTF-8',nrows = 1)
  lastModified1 <- mydata$Datenstand
  print(paste0('Content Last Modified: ',lastModified1))
  print(paste0('checking at: ',Sys.time()))
  if(lastModified1!=lastModified){
    system(command = 'Rscript createImage.R')
    lastModified <- lastModified1
  }
  
  #wait for one hour, then check again.
  n <- 3600
  print(paste('Next check will be at ',Sys.time()+n))
  Sys.sleep(n)
}