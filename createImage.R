# creating image for later import
library(dplyr)
library(openxlsx)

mydata <-
  read.csv('https://www.arcgis.com/sharing/rest/content/items/f10774f1c63e40168479a1feb6c7ca74/data',encoding = 'UTF-8')
# add leading zeros
mydata$IdLandkreis <- table(sprintf("%05d", mydata$IdLandkreis))
mydata$referencedate <- as.Date(substring(mydata$Meldedatum, 1, 10))

# Since population only knows whole of Berlin, I update this in the numbers from RKI (11001-11012 --> 11000)
if(!identical(character(0),
              mydata[grepl(pattern = '110(0[1-9]|1[0-2])',
                           x = mydata$IdLandkreis),]$IdLandkreis
)
){
  mydata[grepl(pattern = '110(0[1-9]|1[0-2])',
               x = mydata$IdLandkreis),]$IdLandkreis <- '11000'
}else{print('Daten unvollständig')} 
print(nrow(mydata))
maxDate <- max(mydata$referencedate)
minDate <- min(mydata$referencedate)

casesperstate <- mydata %>%
  filter(referencedate>=maxDate-6) %>%
  group_by(Bundesland) %>%
  summarize(
    total = sum(AnzahlFall),
    .groups = 'drop'
  )
casesperlandkreis <-
  mydata %>%
  filter(referencedate>=maxDate-6) %>%
  group_by(IdLandkreis) %>%
  summarize(
    total = sum(AnzahlFall),
    .groups = 'drop'
  )

population <-
  read.xlsx(
    'https://www.destatis.de/DE/Themen/Laender-Regionen/Regionales/Gemeindeverzeichnis/Administrativ/04-kreise.xlsx;jsessionid=5D16A0CE74B2CE61F0DC52ED94E6C8A5.internet8711?__blob=publicationFile',
    sheet = 2,
    startRow = 3
  )
landkreisedim <-
  population %>% select(IdLandkreis = 'Schlüssel-nummer',
                        Population = `Bevölkerung2)`,
                        Landkreis = `Kreisfreie.Stadt`) %>% filter(nchar(IdLandkreis) == 5) %>% mutate(id =
                                                                                                         c(substring(IdLandkreis, 1, 2)))
# Since the official Munich page takes Munich numbers from 2018-12-31, I use this
landkreisedim[landkreisedim$IdLandkreis == '09162',]$Population <-
  1471508

bundeslaender <-
  population %>% select(id = `Schlüssel-nummer`, Bundesland = Regionale.Bezeichnung) %>%
  filter(nchar(id) == 2)

landkreisedim <-
  left_join(landkreisedim, bundeslaender, by = c('id' = 'id'))
landkreisedim$id = NULL

populationByBundesland <- landkreisedim%>%group_by(Bundesland)%>%summarise(Population=sum(as.double(Population)),.groups='drop')
populationByLandkreis <- landkreisedim%>%group_by(IdLandkreis,Landkreis)%>%summarise(Population=sum(as.double(Population)),.groups='drop')

byBundesland<-left_join(populationByBundesland,
                        casesperstate,
                        by = "Bundesland") %>%
  mutate(Inzidenz=round(total/Population*100000,digits = 1)) %>%
  select(-c(total))%>%
  arrange(desc(Inzidenz))%>%
  mutate(Population=format(Population,
                           big.mark = ","))

bylandkreis <- left_join(populationByLandkreis,
                         casesperlandkreis,
                         by = "IdLandkreis")%>%
  mutate(Inzidenz=round(total/Population*100000,digits = 1)) %>%
  select(-c(total)) %>%
  arrange(desc(Inzidenz))%>%
  mutate(Population=format(Population,
                           big.mark = ",")
  )
mywd <- getwd()
save.image(paste0(mywd,'/data.Rdata'))
