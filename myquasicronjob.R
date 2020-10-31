library(httr)
mywebcrawl <-
  GET(
    'https://opendata.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0.geojson'
  )
lastModified <- mywebcrawl$headers$`last-modified`
rm(mywebcrawl)
print(paste0('Content Last Modified: ',lastModified))
while(TRUE==TRUE){
  mywebcrawl <-
    GET(
      'https://opendata.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0.geojson'
    )
  lastModified1 <- mywebcrawl$headers$`last-modified`
  rm(mywebcrawl)
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