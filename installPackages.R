list.of.packages <-
  c(
    "shiny",
    "openxlsx",
    "dplyr",
    "jsonlite",
    "shinydashboard",
    "DT",
    'httr',
    'ggplot2',
    'plotly'
  )
new.packages <-
  list.of.packages[!(list.of.packages %in% installed.packages()[, "Package"])]
if (length(new.packages))
  install.packages(new.packages)
#update.packages(ask = FALSE)