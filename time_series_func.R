library(tidyverse)
library(xts)
#' Update time series
#'
#' Function drops all the data in old time series object which matches the new
#' time series than binds old and new time series by rows. Time series must have
#' equal number of columns with coinciding names. Otherwise function returns
#' NULL and prints error message
#'
#' @param xOld xts
#' @param xNew xts
#'
#' @return xts or NULL
#' @export
#'
#' @examples
#' xOld <- xts(x=rnorm(5), order.by=Sys.Date()-2 +1:5)
#' data <- rnorm(3)
#' seq(as.Date(Sys.Date()+2),
#'     length=3, 
#'     by="days") -> dates
#' xNew <- xts(x=rnorm(3), order.by=Sys.Date()+2 +1:3)
#' names(xOld)<-"xOld"
#' names(xNew)<-"xOld"
#' (x3<-merge(xOld, xNew))
#' update.xts(xOld, xNew)
#' update.xts(xOld, x3)
#' names(xNew)<-"xNew"
#' update.xts(xOld, xNew)
update.xts<-function(xOld, xNew){
  if(ncol(xOld)!=ncol(xNew)){
    print("Unequal number of columns. Can`t update")
    return(NULL)
  }
  nms<-c(names(xOld), names(xNew))
  if(!is.null(nms)){
    if(nms[1]!=nms[2]){
      print(str_glue("Column names {nms[1]} and {nms[2]} are different. Can`t update"))
      return(NULL)
    }
  }
  rbind(xOld[!(index(xOld) %in% index(xNew))], xNew)
}



