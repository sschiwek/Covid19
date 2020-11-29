# Covid19

## Overview of Corona Cases in Germany by Bundesland and Landkreis

![alt text](https://github.com/sschiwek/Covid19/blob/main/Capture.JPG)

Source for Infections: RKI (https://www.arcgis.com/sharing/rest/content/items/f10774f1c63e40168479a1feb6c7ca74/data)
Source for Population: Destatis (https://www.destatis.de/DE/Themen/Laender-Regionen/Regionales/Gemeindeverzeichnis/Administrativ/04-kreise.xlsx;jsessionid=5D16A0CE74B2CE61F0DC52ED94E6C8A5.internet8711?__blob=publicationFile)

### Instructions (after cloning repository):
#### Windows User: Run start_services.bat
This will install the required packages, create the image file needed for the app and start the app. After successfully executed, open 127.0.0.1:8099 to see the app.
#### Linux User: Run start_services.sh
This will install the required packages, create the image file, start a scripts that automatically refreshs the image file, when new underlying data is available and start the app.