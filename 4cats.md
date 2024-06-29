---
title: "forcats"
output: html_document
date: "2022-10-23"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
# https://r4ds.had.co.nz/factors.html
# https://forcats.tidyverse.org/reference/index.html
```


```{r}
# SETUP
# install.packages('tidyverse')
library(tidyverse)
```




## Characters and Factors

Factors are used to work with categorical variables with a fixed and known set of possible values. Many base R functions automatically convert characters to factors.
Which could not be what is intended.  

The number of factors (should) be less than the number of character values.  

```{r}
# Copy data
sw = starwars
```

```{r}
sw
```


Set as factor instead of character.
```{r}
# base R = converts to a factor
sw$eye_color = as.factor(sw$eye_color)
```

```{r}
unique(starwars$eye_color)
```
```{r}
data()
```



See the levels of the factor.

```{r}
levels(sw$eye_color)
```

---



## General Social Survey

http://gss.norc.org/


```{r}
gss = gss_cat # copy data.frame = dataset = database
gss           # look at data
glimpse(gss)  # look at data, but different viewpoint
```


```{r}
gss %>% pull(race) %>% unique()
unique(gss$race)
gss %>% select(race) %>% table()
```

```{r}
gss %>% count(race)                  # make table
ggplot(gss, aes(race)) + geom_bar()  # barchart

```

### Exercises

1. Explore the distribution of `rincome` (reported income). What makes the default bar chart hard to understand? How could you improve the plot?

```{r}
# levels(gss$rincome)
ggplot(gss, aes(rincome)) + geom_bar()
```

2. What is the most common `relig` in this survey? What’s the most common `partyid`?

3. Which `relig` does `denom` (denomination) apply to? How can you find out with a table? How can you find out with a visualization?


















## Drop unused level

Note: Not Applicable is listed with 0 observations
```{r}
gss %>% select(race) %>% table()
```
> All forcats functions have `fct_` prefix.  

Drop it!

```{r}
# base::droplevels()
gss %>% mutate(race = fct_drop(race)) %>% pull(race) %>% levels() # pull = $ (pulls vector, not DF)
```














## Modify Factor Order

* `fct_reorder`: 
* `fct_inorder`: by order in which they first appear
* `fct_infreq`: order by most frequently observed
* `fct_rev`: reverse order (usually followed by `fct_infreq`)
* `fct_relevel`: move level to another position

Order matters!  
It is sometimes useful to reorder the factor levels for visualization. 
For example, if we want the average number of hours spent watching TV per day across religions, 
we can write:

```{r}
reltv  = gss %>% group_by(relig) %>%
  summarize(
    age = mean(age,na.rm=T), 
    tvhours = mean(tvhours, na.rm=T),
    n = n()
  )
reltv

ggplot(reltv, aes(tvhours,relig)) + geom_point()

```

> NOTE:  `add_count(var, name = "Name_of_new_column")


Note: Above graph difficult to discern.  Try reordering the levels of `relig`
factor using `fct_reorder()`, which takes 3 parameters:

1. `f`, the factor whose levels are being reordered
2. `x`, numeric vector used to reorder the levels
3. `fun`, a function used if there are multiple values of `s`.  Default is `median`, 
but this argument is optional. 


Note the ease in discerning information after **reordering**.  
```{r}
ggplot(reltv, aes(tvhours, fct_reorder(relig, tvhours))) +
  geom_point()
```


Note that if we try the same strategy (reorder) and plot for age vs. reported income (after reordering factor `rincome`), 
the reordering scrambled the information.  This is because **income** is already has some order 1000, 2000, 3000, etc. 
That is, 1000 < 2000, but there is no order among religions.  

```{r}
rincome_summary = gss %>%
  group_by(rincome) %>%
  summarise(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )

ggplot(rincome_summary, aes(age, fct_reorder(rincome, age))) + geom_point()
```



```{r}
gss %>% drop_na(age) %>% filter(rincome != "Not applicable") %>% 
  group_by(rincome) %>% summarise(mean_age = mean(age)) %>%
  mutate(rincome = fct_rev(rincome)) %>% 
  ggplot(aes(mean_age, rincome)) + geom_point()
```




```{r}
tv = gss %>% filter(!is.na(tvhours))
boxplot(tvhours ~ marital, data = tv)   
```

```{r}
tv = gss %>% filter(!is.na(tvhours))
boxplot(tvhours ~ fct_reorder(marital,tvhours), data = tv)  # fct_reorder
```






#### Reorder by multiple factors

```{r}
gss %>% filter(!is.na(age)) %>%
  filter(marital %in% c("Never married", "Married", "Widowed")) %>%
  count(age, marital) %>% 
  group_by(age) %>%
  mutate(P = n / sum(n)) %>%
  mutate(marital = fct_reorder2(marital, age, P)) %>%
  mutate(marital = fct_rev(marital)) %>% 
  ggplot(aes(age, P, color = marital)) + geom_line()
```








### Infrequent Factor Levels

Also changes the order of the levels.  

```{r}
gss %>% count(marital)
gss %>% mutate(married = fct_infreq(marital)) %>% count(married)
```

```{r}
# Table
gss_cat %>% mutate(marital = fct_infreq(marital)) %>% count(marital)

# Graph
gss_cat %>% mutate(marital = fct_infreq(marital)) %>% 
  ggplot(aes(marital)) + geom_bar(fill = "steelblue", alpha = 0.5) + theme_bw()
```

```{r}
gss_cat %>% mutate(m = marital %>% fct_infreq()) %>% 
  ggplot(aes(m)) + geom_bar()
```















### Reverse factors

`fct_rev()`, reverses the order of factors.

```{r}
gss %>% mutate(M = marital %>% fct_infreq()  %>%  fct_rev()) %>%
  ggplot() + geom_bar(aes(M))
```

















### Relevel factors

Use `fct_relevel()` to move factors to beginning of the list of factors.

```{r}
rincome_summary
```

```{r}
# with specifies where specifically to move it
# without after = n, moves to front.
fct_relevel(rincome_summary$rincome, "Not applicable", after = 1)   # moves this to front of line
```
















## Modify factor levels

Change the values of the levels (label of factor).  Look at party ID

```{r}
gss %>% count(partyid)
```
These levels are inconsistent. For example, party affiliation can be represented better.  
Change them.


```{r}
gss %>%
  mutate(Party = fct_recode(partyid,
    "Republican, strong"    = "Strong republican",
    "Republican, weak"      = "Not str republican",
    "Independent, leans rep" = "Ind,near rep",
    "Independent, leans dem" = "Ind,near dem",
    "Democrat, weak"        = "Not str democrat",
    "Democrat, strong"      = "Strong democrat"
  )) %>%
  count(Party)
```

---













## Combine, collapse

Warning: be careful combining levels (of a factor) as results my be misleading.  

The `fct_collapse()` function can be used to "recode" the levels.  

```{r}
gss %>%
  mutate(partyid = fct_collapse(partyid,
    Other = c("No answer", "Don't know", "Other party"),
    Republican = c("Strong republican", "Not str republican"),
    Independent = c("Ind,near rep", "Independent", "Ind,near dem"),
    Democrat = c("Not str democrat", "Strong democrat")
  )) %>%
  count(partyid, sort = T) 
```







## Lump (helper functions)

Lumping together levels that meet some criteria.

* `fct_lump_min(n)`: lumps levels that appear fewer than n times.

* `fct_lump_prop()`: lumps levels that appear in fewer prop * n times.

* `fct_lump_n()`: lumps all levels except for the n most frequent (or least frequent if n < 0)

* `fct_lump_lowfreq()`: lumps together the least frequent levels, ensuring that "other" is still the smallest level.

```{r}
gss %>% mutate(M = fct_lump_min(marital, 2000)) %>% count(M)
```


```{r}
gss %>% mutate(M = fct_lump_n(marital, 3) ) %>% count(M, sort = T)  
```



```{r}
gss %>%
  mutate(relig = fct_lump(relig, n = 10)) %>%
  count(relig, sort = TRUE) 
```



```{r}
gss %>%
  mutate(partyid = fct_lump(partyid, n = 10)) %>%
  count(partyid, sort = TRUE) 
```






#### Exercises

1. How have the proportions of people identifying as Democrat, Republican, and Independent changed over time?

2. How could you collapse `rincome` into a small set of categories?

