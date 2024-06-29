---
title: "Tidy"
output: html_document
date: "2022-09-26"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```



```{r cars}
# First time
# install.packages('tidyverse')

# Everytime
library(tidyverse)
```

## `dplyr`

* %>% - pipe
* select - the columns (factor, feature variable)
* filter - by row `filter(logical expression)` >, <,  ==
* rename - a column
* mutate - change data.frame by adding a column, typically contains some computation
* arrange - sort
* summarize() - a column
* group_by() - e.g., demographic data

f(g(h(x))) = x %>% h %>% g %>% f

```{r}
aq = airquality
```

```{r}
aq = aq %>% rename(Radiation = Solar.R)
```

```{r}
tempsgt70 = aq %>% filter(Temp > 70)
```

```{r}
tempsgt70 %>% count(Temp) %>% 
  group_by(Temp)
  # yields the count
```

## Multiple Tables

```{r}
# install.packages('nycflights13')
library(nycflights13)
```

```{r}
nycflights13::flights

```


```{r}
dfc = data.frame(Carr = c("UA", "UA", "AA", "DL", "UA", "AA", "AA", "DL", "AA"), Dest = c("ORD","SFO", "ATL","ATL","CMH","SFO","ORD","ORD", "DFW"))
dfc %>% group_by(Carr) %>%
  summarize(count_distinct = n_distinct(Dest)) %>%
  arrange(count_distinct)
```

```{r}
nycflights13::flights %>% filter(month == 12, day == 25, dest == "ORD")
```

```{r}
# make data frame of carriers and corresponding destinations
dfc = data.frame(Carr = c("UA", "UA", "AA", "DL", "UA", "AA", "AA", "DL", "AA"), 
                 Dest = c("ORD","SFO", "ATL","ATL","CMH","SFO","ORD","ORD", "DFW"))

# take a look
# dfc

dfc %>% group_by(Carr) %>%
  summarize(count_distinct = n_distinct(Dest)) %>% arrange(desc(count_distinct))
```

```{r}
nycflights13::planes %>% filter(tailnum == 'N14228')
```



```{r}
nycflights13::airports %>% filter(faa == 'PWM')
```




### Aggregate

#### Useful functions

* Center: `mean()`, `median()`

* Spread: `sd()`, `IQR()`, `mad()`

* Range: `min()`, `max()`, `quantile()`, `slice_max`

* Position: `first()`, `last()`, `nth()`,

* Count: `n()`, `n_distinct()`, `count`


* Logical: `any()`, `all()`



```{r}
carrier_dest = nycflights13::flights %>% select(carrier, dest)
```
Determine which airlines has the most destinations.

```{r}
carrier_dest %>% group_by(carrier) %>%
  summarize(count_distinct = n_distinct(dest)) %>% arrange(desc(count_distinct))
```







## Joins

See: [here](https://statisticsglobe.com/r-dplyr-join-inner-left-right-full-semi-anti)

```{r}
X = data.frame(A = c('a','b','c'), B = c(1,2,3))
Y = data.frame(A = c('a','d'), C = c(5,6))
# inner_join(X,Y,by ="A" )
left_join(X,Y,by ="A" )
right_join(X,Y,by ="A" )
```



### Questions

```{r}
library(nycflights13)
```


```{r}
nycflights13::flights
```

```{r}
nycflights13::planes %>% filter(tailnum == 'N14228')
```




```{r}
carrier_dest = nycflights13::flights %>% select(carrier, dest)
```



Determine which airlines has the most destinations.

```{r}
X = carrier_dest %>% group_by(carrier) %>%
  summarize(count_distinct = n_distinct(dest)) %>% arrange(desc(count_distinct))
X
```

```{r}
Y = nycflights13::airlines
inner_join(X,Y,by = "carrier") %>% select(name, count_distinct) %>% rename(Destinations = count_distinct)
```



```{r}
nycflights13::flights %>% group_by(carrier, origin, dest) %>% count(dest) %>% arrange(carrier, desc(n)) %>% filter(origin == 'JFK') 
```

```{r}
nycflights13::flights %>%   filter(origin == 'JFK')  %>% group_by(carrier, dest) %>% count(dest) %>% arrange(carrier, desc(n)) 
```




```{r}
cities = nycflights13::airports %>% rename(origin = faa) 
flights_city = left_join(nycflights13::flights, cities, by="origin")
```

```{r}
# nycflights13::airports %>% rename(dest = faa) 

# List all records of 
left_join(nycflights13::flights %>% filter(carrier=='AA'), nycflights13::airports %>% rename(dest = faa)  , by="dest") %>% distinct(name) 
```


```{r}
flights_city %>%  filter(origin == 'JFK') %>% group_by(carrier, name, dest) %>% count(name) %>% arrange(desc(n), carrier)

```




Count airports with most flights.

```{r}
# count() - counts  unique values of specified column(s) (shortcut of group_by() and tally())
nycflights13::flights %>% count(origin) #  count 

```


```{r}
nycflights13::flights %>% group_by(origin) %>% tally()
```

1. Which airlines had most delays?

```{r }
nycflights13::flights %>% filter(dep_delay > 0) %>% count(carrier) %>% arrange(desc(n))
```

```{r delays}
nycflights13::flights %>% filter(dep_delay > 0) %>% count(carrier, origin) %>% arrange(carrier,origin, desc(n))
```

Look up the airline and display instead of carrier code.

```{r}
left_join(nycflights13::airlines,nycflights13::flights, by = "carrier")
```

```{r}
A = nycflights13::flights %>% filter(month == 1, day ==1, dep_delay>20)
left_join(nycflights13::airlines,A, by = "carrier")
```
```{r}
A = data.frame(carrier = c("AA","UA","JB","SW"), name = c("American","United", "JetBlue", "Southwest"))
B = data.frame(flt = c(1,2,3,4,5,6,7,8,9,10,11), carrier=c("AA","JB","SW","AA","AA","UA","AA","JB","AA","SW","AB"))
A
B
right_join(A,B, by = "carrier") %>% arrange(flt)
```



```{r}
left_join(nycflights13::airlines,nycflights13::flights, by = "carrier")
```












## ggplot

[Get Started](https://ggplot2-book.org/getting-started.html)

Every ggplot2 plot has three key components:

1. data,

2. A set of aesthetic mappings between variables in the data and visual properties, and

3. At least one layer which describes how to render each observation. Layers are usually created with a geom function.

Here's a simple example:

```{r}
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point()
```

This produces a scatterplot defined by:

1. Data: mpg.

2. Aesthetic mapping: engine size mapped to x position, fuel economy to y position.

3. Layer: points.

Pay attention to the structure of this function call: data and aesthetic mappings are supplied in `ggplot()`, then layers are added on with +. This is an important pattern, and as you learn more about ggplot2 you’ll construct increasingly sophisticated plots by adding on more types of components.

Almost every plot maps a variable to x and y, so naming these aesthetics is tedious, so the first two unnamed arguments to `aes()` will be mapped to x and y. This means that the following code is identical to the example above:

```{r}
ggplot(mpg, aes(displ, hwy)) +
  geom_point()
```

### Exercises

1. How would you describe the relationship between cty and hwy? Do you have any concerns about drawing conclusions from that plot?

1. What does ggplot(mpg, aes(model, manufacturer)) + geom_point() show? Is it useful? How could you modify the data to make it more informative?

1. Describe the data, aesthetic mappings and layers used for each of the following plots. You’ll need to guess a little because you haven’t seen all the datasets and functions yet, but use your common sense! See if you can predict what the plot will look like before running the code.

* `ggplot(mpg, aes(cty, hwy)) + geom_point()`
* `ggplot(diamonds, aes(carat, price)) + geom_point()`
* `ggplot(economics, aes(date, unemploy)) + geom_line()`
* `ggplot(mpg, aes(cty)) + geom_histogram()`


#### Adding color

```{r}
ggplot(mpg, aes(displ, hwy, color = class)) + 
  geom_point()
```

#### Add Trend Line

```{r}
#ggplot(mpg, aes(displ, hwy)) +   geom_point() +   geom_smooth()
```


