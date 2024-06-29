---
title: "Hello (R) World"
author: "Quinlan"
date: "2022-09-01"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```



<!----------------------------------------------------------------------------->
# Header 1: Bullet Items
We can also make bullet items easily, such as:

* eat
* sleep
* study


---


<!----------------------------------------------------------------------------->
## Header 2: Enumerated Lists

You should do the following (in this order):

1. study
1. study
1. sleep

---




<!----------------------------------------------------------------------------->
### Header 3: Defintion, italics and bold face

> _You better call somebody_

To put italic in a sentence, enclose phrase with one asterisk (Latin for *little star*), or underscores,  _like this_.  To make bold face to emphasize something, enclose with two, like **this** or __that__.

> **Definition**: MAT150 is Statistics for Life Sciences. 




```{r}
water = rnorm(2000,13.5,4)
```

```{r}
hist(water, col="#336699", xlab = "Average Contaimination", main = "Water Quality", breaks = 120)
```

<!----------------------------------------------------------------------------->
#### Header 4: Embed executable R code chunks


Create data and find its average.  
```{r}
data = c(1,2,3,4,400)
mean(data)
```

Generate 50 uniformly distributed numbers between 1 and 10.  

```{r}
x = runif(50,1,10)
```




<!----------------------------------------------------------------------------->
#### Plot Data

**Scatter plot**
```{r}
plot(x)
```
**Histogram**
```{r}
hist(x)
```
**Stem-and-Leaf**
```{r}
stem(x)
```
**Dot Plot**
```{r}
stripchart(x,pch = 19, method = "stack", col=2)
```

```{r}
stripchart(x, method = "stack", offset = .5, at = 0, pch = 19,
           col = "steelblue", main = "Stacked Dot Plot", xlab = "Data Values")
```

<!----------------------------------------------------------------------------->
#### References

Peck, R., & Devore, J. L. (2011). *Statistics: The exploration & analysis of data*. Cengage Learning.

