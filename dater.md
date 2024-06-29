---
title: "DaterR"
output:
  html_document: default
  pdf_document: default
date: "2022-10-31"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```


```{r}
#create string value
x = c("2022-10-31")
class(x)

```

```{r}
x = "Jul, 4 1776"
class(x)
```

```{r}
#convert string to date
y = as.Date(x, format="%Y-%m-%d")
y

class(y)
```


## Lubridate

```{r}
# install.packages('lubridate')
```

```{r}
library(lubridate, warn.conflicts = F)
```


### Date-Time

**Definition**: _Date-Time_ is a point on the timeline stored as the number of seconds since 1970-01-01 00:00:00 UTC.

> UTC = Universal Time Coordinated

```{r}
dt = as_datetime(1)
dt
```

```{r}
dt = as_datetime(-1)
dt
```

```{r}
dt = as_datetime(1234567890)
dt
```

### Date

Number of days since 1970-01-01

```{r}
# 234 days past Jan. 1, 1970
d = as_date(234)
d
```


## Convert Strings and Numbers to Date-Time Formats

1. Identify the order of the units

2. Use function whose name replicates that order

```{r}
now()
ymd_hms(now())

mdy("July 4, 1776")

```

### Time 

```{r}

```

####  Time Zones

R recognizes approximately 600 time zones (tz).  

```{r}
# List TZs
OlsonNames()
```





```{r}
now()
date()
today()
Sys.timezone() # Current TZ
Sys.time()     # Current date, time, and TZ
Sys.Date()     # Current date
```

```{r}
# lubridate
local_time(now(),"WET")
now(tzone="WET")
with_tz(now(), "WET")
```



## Get and Set components of date

```{r}
# GET 
now()
date(now())
year(now())
day(now())
month(now())
hour(now())
minute(now())
second(now())
tz(now())
week(now())
quarter(now())
semester(now())
am(now(tzone="EST"))   # is it AM?
leap_year(year(now()))
```

```{r}
now(tzone="WET")
```

```{r}
# Daylight Savings Time
dst(now())
dst(as.Date("2022-10-31"))
tz(now())
```


## Round Date-Times

```{r}
floor_date(now(), unit = "hour")
round_date(now(), unit = "month")
```


## Math with Date-Times

```{r}
x = ymd_hms("2018-03-11 1:30:00", tz = "US/Eastern")
x + minutes(45)
x + minutes(90)
```

```{r}
# Time you experience
x + dminutes(45)
```


## Durations (in seconds)

```{r}
dyears(1)
dweeks(1)
ddays(1)
dhours(1)
dminutes(1)
dseconds(1)
```


```{r}
lakers
```