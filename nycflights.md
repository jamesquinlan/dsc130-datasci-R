---
title: "NYC"
output: html_document
date: "2022-09-29"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r}
# install.packages('nycflights13')
library(nycflights13)
```

```{r}
# install.packages('tidyverse')
library(tidyverse)
```

```{r}
nycflights13::airlines
```

```{r}
carrier_dest = nycflights13::flights %>% select(carrier, dest)
carrier_dest
```

```{r}
X = carrier_dest %>% group_by(carrier) %>% summarize(N = n_distinct(dest)) %>% arrange(desc(N))
```

```{r}
Y = nycflights13::airlines
```

```{r}
# Joining two tables together
inner_join(X,Y, by = "carrier") %>% select(name, N) %>% rename(Airline = name, Destinations = N)
```

## Joins

```{r}
X = data.frame(A = c(1,2,3,4,5), B = c("a", "b", "c", "d", "e"))
Y = data.frame(A = c(1,2,5,7), C = c("c", "f", "d", "g"), D = c("asdf","werw","rty","ljlj"))
X
Y
```

```{r}
# inner_join(X,Y,by="A")
# left_join(X,Y,by="A")
right_join(X,Y,by="A")
```

```{r}
cities = nycflights13::airports %>% rename(origin = faa) 
flights_cities = left_join(nycflights13::flights, cities, by = "origin")
flights_cities

```


## ggplot

```{r}
mpg
# ggplot(data.frame, aes(x,y))
ggplot(mpg, aes(x = displ,y = hwy)) + geom_point() + geom_smooth()
```