---
title: "Advanced graphing"
author: "ggplot"
date: '2022-10-02'
output: html_document
---

<!-- full stack experience in data collection, aggregation, analysis, visualization, productionization, and monitoring. -->



```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

> Data visualization is an accessible, compelling, and expressive mode to investigate and depict patterns in data [1].  

Here is a reminder of variable types and plot types.

|      y      |      x      |        plot        |      Base R      |            ggplot            |
|:-----------:|:-----------:|:------------------:|:----------------:|:----------------------------:|
|             | numeric     | histogram, density | hist, stripchart | geom_histogram, geom_density |
|             | categorical | (stacked) bar      | barchart         | geom_bar                     |
| numeric     | numeric     | scatter            | plot             | geom_point                   |
| numeric     | categorical | box                | boxplot          | geom_boxplot                 |


## ggplot

[Get Started](https://ggplot2-book.org/getting-started.html)

Every ggplot2 plot has three key components:

1. data,

2. A set of aesthetic mappings between variables in the data and visual properties, and

3. At least one layer which describes how to render each observation. Layers are usually created with a geom function.


```{r}
library(ggplot2)
```


## Scatter Plots

Use for bivariate numeric data (i.e., both $x$ and $y$ are numeric variables).  

```{r}
ggplot(mtcars, aes(x = wt, y = mpg))  + 
  geom_point() + 
  xlab("Weight") + 
  ylab("Miles per Gallon")
```

#### Adding a trend line

```{r}
ggplot(mtcars, aes(x = wt, y = mpg))  + 
  geom_point() + 
  geom_smooth() + 
  xlab("Weight") + 
  ylab("Miles per Gallon")
```

Note warning message, stands for LOESS (locally estimated scatterplot smoothing) and LOWESS (locally weighted scatterplot smoothing)

Recall, in Base R, the scatter plot is, 
```{r}
plot(mtcars$wt, mtcars$mpg)
```


```{r}
G = ggplot(mpg, aes(cty, hwy, color = factor(cyl))) +
    geom_point() + 
  geom_abline()
G
```


## Line Graph

```{r}
ggplot(pressure, aes(x = temperature, y = pressure)) +
  geom_line()
```

```{r}
ggplot(pressure, aes(x = temperature, y = pressure)) +
  geom_line() + 
  geom_point(size=2, color = "red")
```

In Base R, to make a line graph pass a vector of $x$ values and a vector of $y$ values to the `plot()` function.  Use `type = "l"`
```{r}
plot(1:10, sin(1:10), type="l")
```

```{r}
plot(pressure$temperature, pressure$pressure, type='l')   # line
points(pressure$temperature, pressure$pressure)           # points
# additional lines with `lines()`
# lines(pressure$temperature, pressure$pressure/2, col = "red")
```



## Bar Graph

```{r}
# Bar graph of counts This uses the mtcars data frame, with the "cyl" column for
# x position. The y position is calculated by counting the number of rows for
# each value of cyl.
ggplot(mtcars, aes(x = cyl)) +
  geom_bar()

# Bar graph of counts
ggplot(mtcars, aes(x = factor(cyl))) +
  geom_bar()
```

Base R:
```{r}
# Generate a table of counts
barplot(table(mtcars$cyl))
```

---



### Histogram

Univariate numeric data used for frequency counts.  

```{r}
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(bins = 10)  # see also binwidth = 4, etc. 
```



Base R
```{r}
hist(mtcars$mpg)

# Specify approximate number of bins with breaks
hist(mtcars$mpg, breaks = 10)
```



---


## Exercises

1. How would you describe the relationship between cty and hwy? Do you have any concerns about drawing conclusions from that plot?

```{r}
ggplot(mpg, aes(x = cty, y = hwy)) + geom_point()
```
```{r}
ggplot(mpg, aes(manufacturer)) + geom_bar()
```
```{r}
ggplot(mpg, aes(cty)) + geom_histogram(binwidth = 5) + xlab("MPG in City")
```
```{r}
ggplot(mpg, aes(displ, hwy, color = cyl)) + geom_point()
```


```{r}
ggplot(mpg, aes(displ, hwy)) + 
  geom_point(color="blue") + 
  facet_wrap(~class)
```


```{r}
ggplot(mpg, aes(drv, hwy)) + geom_jitter(width=0.1)
#ggplot(mpg, aes(drv, hwy)) + geom_boxplot()
#ggplot(mpg, aes(drv, hwy)) + geom_violin()
```


---



## Frequency Plot

A histogram with a line.  Accepts binwidth parameter as argument in `geom_freqpoly()`.

```{r}
ggplot(mpg, aes(hwy)) + geom_freqpoly()
```

---



##### Multiple plots

```{r}
ggplot(mpg, aes(displ, color = drv)) +  geom_freqpoly(binwidth = 0.5)
```


```{r}
ggplot(mpg, aes(displ, fill = drv)) + 
  geom_histogram(binwidth = 0.5) + 
  facet_wrap(~drv, ncol = 1)
```



## Boxplots

```{r}
ggplot(mpg, aes(class, cty)) + geom_boxplot(color="black") + theme_bw()
```


Base R

```{r}
boxplot(mpg$cty)
```


```{r}
hist(mpg$cty, probability = TRUE, ylab = "", main = "",
     col = rgb(1, .7, 0.1, alpha = 0.5), axes = FALSE)
axis(1) # Adds horizontal axis
par(new = TRUE)
boxplot(mpg$cty, horizontal = TRUE, axes = FALSE,
        lwd = 2, col = rgb(0, 0, 0, alpha = 0.2))
```


---


### References

[1] Baumer, B. S., Kaplan, D. T., & Horton, N. J. (2017). *Texts in Statistical Science: Modern Data Science with R*. Chapman and Hall/CRC.

```
@book{baumer2017texts,
  title={Texts in Statistical Science: Modern Data Science with R},
  author={Baumer, Benjamin S and Kaplan, Daniel T and Horton, Nicholas J},
  year={2017},
  publisher={Chapman and Hall/CRC}
}
```
