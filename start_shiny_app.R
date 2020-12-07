library(shiny)

args <- commandArgs(trailingOnly=TRUE)

options(shiny.port = as.numeric(args[2]))
options(shiny.host = '0.0.0.0')
shiny::runApp(args[1])
