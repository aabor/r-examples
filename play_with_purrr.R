library(tidyverse)
library(purrr)
library(broom)
l <- list(mean, var, sd); 
invoke_map(l, x = 1:9)

walk(data.frame(1:10, 10:19), mean)

reduce(1:10, sum)
accumulate(1:10, sum)

compose()
add1 <- function(x) x + 1
compose(sum, exp)(c(8, 2))

cross_df(data.frame(1:2,2:3,3:4))

n_iris <- iris %>% 
  group_by(Species) %>% 
  nest()
n_iris %>% 
  mutate(n = map(data, dim))

mod_fun <- function(df)
  lm(Sepal.Length ~ ., data = df)
m_iris <- n_iris %>%
  mutate(model = map(data, mod_fun))

m_iris %>% 
  mutate(n = map2(data, model, list))
m_iris %>%
  mutate(n = pmap(list(data, model, data), 
                  list), 
         tidied= map(model, tidy)) %>% 
  unnest(tidied)

#Apply .f element-wise to .x, return a logical vector
n_iris %>% transmute(n = map_lgl(data, is.matrix))
n_iris %>% transmute(n = map_int(data, nrow))
n_iris %>% transmute(n = map_dbl(data, nrow))
n_iris %>% transmute(n = map_chr(data, nrow))

tibble(max = c(3, 4, 5), seq = list(1:3, 1:4, 1:5))
enframe(list('3'=1:3, '4'=1:4, '5'=1:5), 'max', 'seq')
