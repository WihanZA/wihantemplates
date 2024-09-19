
rm(list = ls())
invisible(gc())

library(rmarkdown)
library(ragg)
library(knitr)
library(kableExtra)
library(tidyverse)
library(tinytex)
library(readxl)
library(writexl)
library(lubridate)

source("code/functions/get_projects.R")

latest <- get_projects() %>%
  filter(Date == max(Date, na.rm = T))

rmarkdown::render(
  input = "invoicer.Rmd",
  output_dir = file.path("invoices", latest$Path),
  output_file = paste(latest$Reference, "Invoice"),
  clean = T,
  run_pandoc = T,
  params = list(
    directory = paste(destination, latest$Reference, sep = "/"),
    client = latest$Client,
    street = latest$Street,
    city = latest$City,
    zip = latest$Zip,
    email = latest$Email,
    reference = latest$Reference,
    date = format(latest$Date, "%d %B %Y"),
    project = latest$Project,
    description = latest$Description
  )
)
