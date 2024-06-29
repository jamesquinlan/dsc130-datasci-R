---
title: "Tidyverse"
output: html_document
date: "2022-09-22"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r}
# install.packages('tidyverse')
library(tidyverse)
```


## Read data

```{r}
# base
debt = read.csv('https://raw.githubusercontent.com/jamesquinlan/dsc130-datasci-R/main/data/student_debt.csv')
```

```{r}
debt
```
```{r}
debt = read_csv('https://raw.githubusercontent.com/jamesquinlan/dsc130-datasci-R/main/data/student_debt.csv')
```

```{r}
debt
```

```{r}
glimpse(debt)  # = str()
```

```{r}
# View(debt)
```

```{r}
max(debt$loan_debt)
```
```{r}
airquality
```
```{r}
# The R PIPE   %>%

airquality %>% select(Ozone, Temp)
# `select` is for columns


```

```{r}
select(airquality, Temp, Ozone)
```

```{r}
airquality[,c(1,4)]  # Base R

```

```{r}
# `filter` is for rows
airquality %>% filter(Temp == 72 & Month == 5)
```

```{r}
airquality %>% 
  select(Wind:Day) %>% 
  filter(Temp > 40 & Temp < 72)
```

```{r}
airquality %>% 
  group_by(Month) %>%
  summarize(N = n(), Mean_Temp_by_Month = mean(Temp))
```

```{r}
airquality %>% select(!c(Ozone, Wind))
```

```{r}
airq = airquality %>% 
  select(Ozone, Wind, Temp) %>% 
  mutate(X = 2*Ozone + Wind)
airq
```



```{r}
airq = airq %>% rename(Pressure = X)
```

```{r}
airq
```



