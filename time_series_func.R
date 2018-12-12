library(tidyverse)
library(xts)
#' Update time series
#'
#' Function drops all the data in old time series object which matches the new
#' time series than binds old and new time series by rows. Time series must have
#' equal number of columns with coinciding names. Otherwise function returns
#' NULL and prints error message
#'
#' @param x1 xts class object
#' @param x2 xts class object
#'
#' @return xts or NULL
#' @export
#'
#' @examples
#' x1 <- xts(x=rnorm(5), order.by=Sys.Date()-2 +1:5)
#' data <- rnorm(3)
#' seq(as.Date(Sys.Date()+2),
#'     length=3, 
#'     by="days") -> dates
#' x2 <- xts(x=rnorm(3), order.by=Sys.Date()+2 +1:3)
#' names(x1)<-"x1"
#' names(x2)<-"x1"
#' x3<-merge(x1, x2)
#' x3
#' update.xts(x1, x2)
#' update.xts(x1, x3)
#' names(x2)<-"x2"
#' update.xts(x1, x2)
update.xts<-function(x1, x2){
  if(ncol(x1)!=ncol(x2)){
    print("Unequal number of columns. Can`t update")
    return(NULL)
  }
  nms<-c(names(x1), names(x2))
  if(!is.null(nms)){
    if(nms[1]!=nms[2]){
      print(str_glue("Column names {nms[1]} and {nms[2]} are different. Can`t update"))
      return(NULL)
    }
  }
  rbind(x1[!(index(x1) %in% index(x2))], x2)
}



