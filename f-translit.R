library(tidyverse)
library(stringi)
#find available text transform identifiers
str_subset(stri_trans_list(), "Ru")

wd<-getwd()
#setwd("~/Documents/textbooks")
setwd("~/Documents/archive")

from<-dir(recursive = T, pattern = "*.xls|*.doc|*.docx|*.xlsx|*.pptx|*.pdf") 
from %>%
  stri_trans_general("Russian-Latin/BGN")->to

file.rename(from=from, to=to)
setwd(wd)
