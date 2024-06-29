---
title: "NFL-games"
output: html_document
author: "DSC-130"
date: "2022-09-07"
---


<style>
p{font-size:15px;}
h1{font-weight: bold;}
h2{color: #336699;}
h3{color: #666666;}
ul{font-size:14px;}
ol{font-size:15px;}
</style>

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```



# Objectives

* Read data
* Explore data (size, variables, data types, etc.)
* Change a data type
* Obtain frequency counts (of categorical data)
* Summarize numerical data (min, max, mean)
* Sort by column
* Filter (subset)



## Read Data

Data containing all NFL games played from 2000 - 2019 (including playoffs).  

```{r}
games = read.csv('https://raw.githubusercontent.com/jamesquinlan/dsc130-datasci-R/main/data/games.csv')
```



## Get Familiar with Data
```{r}
#head(games)
str(games)
#dim(games)
#which(is.na(games$tie))
#dim(games)[1] - sum(is.na(games$tie))  # Number of tie games
```
```{r}
games$yds_win
```

#### Filter by Column
```{r}
# By Column Number
games[ ,c(1,2,4,5,6,10)]
```

```{r}
# By Column Name
# games$pts_win
# games[1:50,c("pts_win", "pts_loss")]
games[c(1,3491,5000) ,c("pts_win", "pts_loss")]
```

##### Mutate Column Name
```{r}
colnames(games)[1] = "years"
```

##### Make new column (variable)
Suppose we want to know the point differential.

```{r}
games$pts_diff = games$pts_win - games$pts_loss
```

```{r}
games$pts_diff
```

##### Add a loser column

```{r}
# if home team is winner, then away team is loser, else the home team is the loser
games$loser = ifelse(games$home_team == games$winner, games$away_team, games$home_team) 
```

```{r}
games$loser
```

##### Number of games per year
```{r}
table(games[,1])
```





### Sort by

```{r}
# games[order(games$pts_win),]
games[order(games$pts_diff, decreasing = FALSE),]
```


### Subset and Slice

```{r}
games[1:4,c(1:3,5,7, 9)]
```

```{r}
# All games Pitt won by more than 9 pts.
rows = c(games$winner == "Pittsburgh Steelers" & games$pts_diff >= 10)
columns = c(1,2,3, 20,21)
subset(games, rows, columns)
```

##### How many games were won by 1 point?
```{r}
table(games$pts_diff)
barplot(table(games$pts_diff))
```

```{r}
games[which(games$pts_diff==46),]
```

```{r}
games[(which(games$pts_diff==0)),]
```


## Additional Questions

##### What percent of games did team with more turnovers win?

```{r}
# Percent of teams that won but had more turnovers
length(games[which(games$turnovers_win > games$turnovers_loss),c("winner")])/dim(games)[1]
# games[, c("winner", "turnovers_win", "turnovers_loss")]
```

```{r}
length(games[which(games$yds_loss > games$yds_win),c("winner")])/dim(games)[1]
```


# Source

https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-02-04/readme.md

