library(tidyverse)
qplot( x = cty, y = hwy, 
       color = cyl, data = mpg, 		geom = "point" )
last_plot()
ggsave("img/plot.png", 
       width = 5, height = 5)
lty <- c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash")
lty <- c("11", "18", "1f", "81", "88", "8f", "f1", "f8", "ff")
a <- ggplot(mpg, aes(hwy))
a + geom_area(stat = "bin", alpha= 0.6, color="#C65858", fill="red", linetype=lty[6], size=1)
a + geom_density(kernel= "gaussian", alpha= 0.6, color="blue", 
                fill="skyblue", linetype=3, size=1)
a + geom_dotplot()
a + geom_freqpoly()
a + geom_histogram(binwidth=5)

b <- ggplot(mpg, aes(fl))
b + geom_bar()

#shape="diamond open"
f <- ggplot(mpg, aes(cty, hwy))
f + geom_blank()
f + geom_jitter()
f + geom_point(shape=2)
f + geom_quantile()
f + geom_rug(sides= "bl")
f + geom_smooth(method=lm)
f + geom_text(aes(label=cty))

g <- ggplot(mpg, aes(class, hwy))
g + geom_bar(stat= "identity")
g + geom_boxplot()
g + geom_dotplot(binaxis= "y",
                 stackdir= "center")
g + geom_violin(scale = "area")

h <- ggplot(diamonds, 
       aes(cut, color))
h + geom_jitter()

library(ggplot2movies)
i <- ggplot(movies, aes(year,	rating))
i + geom_bin2d(binwidth = 
                 c(5, 0.5))
i + geom_density2d()
i + geom_hex()

j <- ggplot(economics, 
            aes(date, unemploy))
j + geom_area()
j + geom_line()
j + geom_step(direction = "hv")

seals$z <- with(seals, sqrt(delta_long^2 + delta_lat^2))
m <- ggplot(seals, aes(long, lat))
m + geom_contour(aes(z = z))
m + geom_raster(aes(fill = z), 		hjust=0.5, vjust=0.5, 		interpolate=FALSE)
m + geom_tile(aes(fill = z))

df <- data.frame(grp = c("A", "B"),
                 fit = 4:5, se = 1:2)
k <- ggplot(df, aes(grp, fit, 
                    ymin = fit-se, 
                    ymax = fit+se))
k + geom_crossbar(fatten = 2)
k + geom_errorbar()
k + geom_linerange()
k + geom_pointrange()

data <- data.frame(murder = 	USArrests$Murder,
                   state = tolower(
                     rownames(USArrests)))
map <- map_data("state")
l <- ggplot(data, aes(fill = murder))
l + geom_map( aes(map_id = state), 	map = map ) +
  expand_limits( x = 			map$long, 
                 y = map$lat )

map<-map_data("state")
c<-ggplot(map, aes(long, lat))
c+geom_polygon(aes(group=group))

d<-ggplot(economics, aes(date, unemploy))
d+geom_path(lineend = "butt", linejoin = "round", linemitre = 1)
d+geom_ribbon(aes(ymin=unemploy-900, ymax=unemploy+900))

e<-ggplot(seals, aes(x=long, y=lat))
e+geom_segment(aes(xend=long+delta_long, yend=lat+delta_lat))
e+geom_rect(aes(xmin=long, ymin=lat,
                xmax=long+delta_long, ymax=lat+delta_lat))
# Positions
s <- ggplot(mpg, aes(fl, fill = drv))
s + geom_bar(position = "dodge")
s + geom_bar(position = "fill")
s + geom_bar(position = "stack")
f + geom_point(position = "jitter")



# Coordinate system
b <- ggplot(mpg, aes(fl))
r<-b + geom_bar()
r + coord_cartesian(xlim = c(0, 5))
r + coord_fixed(ratio = 1/2)
r + coord_flip()
r + coord_polar(theta = "x", direction=1 )
r + coord_trans(y = "sqrt")
z + coord_map(projection = "ortho",
              orientation=c(41, -74, 0))
r + theme_bw()
r + theme_grey()
r + theme_classic()
r + theme_minimal()

#Faceting
t <- ggplot(mpg, aes(cty, hwy)) + geom_point()
t + facet_grid(. ~ fl)
t + facet_grid(year ~ .)
t + facet_grid(year ~ fl)
t + facet_wrap(~ fl)
t + facet_grid(y ~ x, scales = "free")
t + facet_grid(. ~ fl, labeller = label_both)
t + facet_grid(. ~ fl, labeller = label_bquote(alpha ^ .(x)))
t + facet_grid(. ~ fl, labeller = label_parsed)
t + ggtitle("New Plot Title")
t + xlab("New X label")
t + ylab("New Y label")
t + labs(title =" New title", x = "New x", y = "New y")

t + theme(legend.position = "bottom")
t + guides(color = "none")
t + scale_fill_discrete(name = "Title",
                        labels = c("A", "B", "C"))         

#Color and fill scales
b <- ggplot(mpg, aes(fl))
n <- b + geom_bar(aes(fill = fl))
n + scale_fill_brewer(palette = "Blues")
n + scale_fill_grey(
  start = 0.2, end = 0.8,
  na.value = "red")

a <- ggplot(mpg, aes(hwy))
o <- a + geom_dotplot(
  aes(fill = ..x..))
o
o + scale_fill_gradient(
  low = "red",
  high = "yellow")
o + scale_fill_gradient2(
  low = "red", high = "blue",
  mid = "white", midpoint = 25)
o + scale_fill_gradientn(
  colours = terrain.colors(6) )
o + scale_fill_gradientn(
  colours = rainbow(6))
o + scale_fill_gradientn(
  colours = heat.colors(6))
o + scale_fill_gradientn(
  colours = topo.colors(6))
o + scale_fill_gradientn(
  colours = cm.colors(6))
library(RColorBrewer)
display.brewer.all()
display.brewer.pal(6,"BrBG")
brewer.pal.info
o + scale_fill_gradientn(
  colours = brewer.pal(6, "RdYlBu"))

#Scales
n <- b + geom_bar(aes(fill = fl))
n
n + scale_fill_manual(
  values = c("skyblue", "royalblue", "blue", "navy"),
  limits = c("d", "e", "p", "r"), breaks =c("d", "e", "p", "r"),
  name = "fuel", labels = c("D", "E", "P", "R"))
# scale_*_continuous()
# scale_*_discrete()
# scale_*_identity()
# scale_*_manual(values = c())
# scale_x_date(labels = date_format("%m/%d"),
#              breaks = date_breaks("2 weeks"))
# scale_x_datetime()
# scale_x_log10()
# scale_x_reverse()
# scale_x_sqrt()


#Stats
a <- ggplot(mpg, aes(hwy))
a + stat_bin(binwidth = 1, origin = 10)
a + stat_bindot(binwidth = 1, binaxis = "x")
a + stat_density(adjust = 1, kernel = "gaussian")

f <- ggplot(mpg, aes(cty, hwy))
f + stat_bin2d(bins = 30, drop = TRUE)
f + stat_binhex(bins = 30)
f + stat_density2d(contour = TRUE, n = 100)
f + stat_ecdf(n = 40)
f + stat_quantile(quantiles = c(0.25, 0.5, 0.75), formula = y ~ log(x),
                  method = "rq")
f + stat_smooth(method = "auto", formula = y ~ x, se = TRUE, n = 80,
                fullrange = FALSE, level = 0.95)
f + stat_identity()
f + stat_sum()
f + stat_summary(fun.data = "mean_cl_boot")
f + stat_unique()
ggplot() + stat_function(aes(x = -3:3),
                         fun = dnorm, n = 101, args = list(sd=0.5))
ggplot() + stat_qq(aes(sample=1:100), distribution = qt,
                   dparams = list(df=5))

g <- ggplot(mpg, aes(class, hwy))
seals$z <- with(seals, sqrt(delta_long^2 + delta_lat^2))
g + stat_boxplot(coef = 1.5)
g + stat_ydensity(adjust = 1, kernel = "gaussian", scale = "area")

i <- ggplot(movies, aes(year, rating))
i + stat_density2d(aes(fill = ..level..),
                   geom = "polygon", n = 100)
m <- ggplot(seals, aes(long, lat))
m + stat_contour(aes(z = z))
m + stat_spoke(aes(radius= z, angle = z))
m + stat_summary_hex(aes(z = z), bins = 30, fun = mean)
m + stat_summary2d(aes(z = z), bins = 30, fun = mean)
