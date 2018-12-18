#! /usr/bin/env Rscript
#install.packages("tidyverse")
#install.packages("devtools","roxygen2")
library(tidyverse, quietly = T)
library(purrr, quietly = T)
#library(glue)
args <- commandArgs(TRUE)
#print(args)
user<-args[1]
path<-args[2]
if(is.na(user)||is.na(path)){
  print("Type ./cue2aud.sh username path/to/music/files
       Default path is /home/$USER/Downloads
       User name is obligatory")
}
if(is.na(user))
    stop("User name is not provided")
if(is.na(path))
    path=""
cat(str_c(path, "\r\n"))
oldPath<-getwd()
if(!dir.exists(path)){
  print(str_c("Error changing directory"))
  path =str_glue("/home/{user}/Downloads")
  print(str_glue("Using default path: {path}\r\n"))
}
if(!dir.exists(path)){
    stop(str_glue("Can't find directory {path}"))
}
print(path)
setwd(path)
files<-dir(pattern = "\\.cue$", full.names = TRUE, recursive = TRUE)
df<-tibble(filename=basename(files))
cue2aud<-function(fn){
  file_name<-basename(fn)
  f<-read_file(fn)
  s<-str_split(f, pattern="\r\n") %>% 
    unlist %>% 
    str_trim()
  s<-s[str_which(s, pattern="TRACK 01"):length(s)]
  
  df<-bind_cols(tibble(time1=str_subset(s, pattern="INDEX 01")), 
                tibble(titles=str_subset(s, pattern="TITLE")))
  df1<-df %>% 
    mutate(time1=str_replace_all(time1, pattern="INDEX 01", replacement = ""),
           time1=str_trim(time1)) %>% 
    mutate(titles=str_replace_all(titles, "TITLE", replacement = ""),
           titles=str_trim(titles),
           titles=str_replace_all(titles, pattern = "\"", replacement = ""))
  df2<-df1 %>% 
    separate(time1, into=c("mm","ss", "ms")) %>% 
    mutate(mm=as.numeric(mm),
           ss=as.numeric(ss),
           ms=as.numeric(ms)) %>% 
    mutate(tm=mm*60+ss+ms/100.0) %>% 
    mutate(time1=tm %>% as.character(),
           time2=tm %>% as.character()) %>% 
    select(time1, time2,titles)
  v<-unite(df2, "ret", c("time1", "time2", "titles"), sep = "\t") %>% 
    pull(ret)
  str_c(v, collapse="\r\n") %>% 
    write_file(str_c(fn, ".txt"))
  tibble(filename=file_name, nrecords=length(v))
}
ret<-map(files, cue2aud) %>% 
  bind_rows()
str_glue("Processed {nrow(ret)} files\r\n")
ret
setwd(oldPath)
