---
title: "String Manipulation with `stringr`"
author: "Quinlan"
date: "2022-10-31"
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
# https://towardsdatascience.com/a-gentle-introduction-to-regular-expressions-with-r-df5e897ca432
```

The `stringr` package provides a set of internally consistent tools for working 
with character strings, i.e. sequences of characters surrounded by quotation marks.

Function prefix: `str_`

```{r}
install.packages('stringr')
```

```{r}
library(stringr)
```

### Set up
```{r}
# Vector (represents a column of data in data frame)
fruit = c("apple", "banana", "peach pear", "pear", "pinapple", "tomato")

animals = c("dog", 
            "cat", 
            "fox", 
            "deer", 
            "pig", 
            "monkey", 
            "horse", 
            "cow", 
            "rabbit", 
            "racoon", 
            "otter", 
            "panda", 
            "goat", 
            "sheep", 
            "hognose snake", 
            "hog", 
            "hedgehog", 
            "lion")

aim = "Our aim is to promote interest in nature and animals among children, as well as raise their awareness in conservation and environmental protection."
```


## Detect Matches

There are four functions:

* `str_detect`
* `str_which`
* `str_count`
* `str_locate`


```{r}
str_detect(fruit, "ea")
```


#### Find the indexes of strings that contain a pattern match.
```{r}
str_which(fruit, "appl")
```


#### Count the number of matches in a string.

```{r}
str_count(fruit, "ea")
```

```{r}
str_count(animals, 'oo')
```


#### Locate the position of patern matches in a string.  

```{r}
str_locate(animals, 'hog')
```


```{r}
# Combine some functions (could use dpylr?)
str_locate(animals[str_detect(animals,'hog')],'hog')
```

```{r}
# install.packages('dplyr')
# library(dplyr)
```


## String Subsets


#### Extract substrings

`str_sub(string, start, end)`


```{r}
str_sub(animals,2,5)
```


Note: -n is how many from the end.  

```{r}
str_sub(fruit, -2)
```


#### Subset match

```{r}
str_subset(animals, 'hog')
```


#### Return first (part) with matching pattern

```{r}
str_extract(animals,'hog')
```


```{r}
str_extract(fruit, "[aeiou]")
```



## Sorting


#### Return sorted indices
```{r}
str_order(animals)
```


#### Return sorted vector
```{r}
str_sort(animals)
```



## Mutate Strings

```{r}
apples_bannas = c("apples", "bananas")

```
#### Replace substrings (identify and assign)

```{r}
str_sub(apples_bannas, 1,3) = "the"
```


#### Replace all matched patterns
```{r}
apples_bananas = c("apples", "bananas")
str_replace_all(apples_bananas,"a","u")
```

#### Convert to Lower Case
```{r}
Fruits = c("APPLES", "Bananas")
str_to_lower(Fruits)
```

#### Convert to Lower Case
```{r}
Fruits = c("apples", "bananas")
str_to_upper(Fruits)
```



---




## Join/Split Strings


#### Join multiple strings

```{r}
str_c(fruit, sep="", collapse = "")
```


#### Duplicate

```{r}
str_dup(fruit, 4)

```


#### Split 

```{r}

str_split_fixed(animals, " ", 2)
```

## Exercise

1. Create a list of names (make some have upper case, some lower case, some mixed case, some with space at beginning)

```{r}
names = c("John", " james", "  mAtthew", " seth   ", "MACY")
```

2. Normalize all names so there are no spaces before or after, and all look like "Smith", starts with upper case letter, 
but rest is lower case. (i.e., "Title Case")

```{r}
# str_sub(names,1,1)
str_to_lower(str_trim(names, side = c("both"))) -> newnames   # for convenience

# str_to_upper(str_sub(str_to_lower(str_trim(names, side = c("both"))),1,1))
# str_re
```

```{r}
firstletters = str_to_upper(str_sub(newnames,1,1))
```



```{r}
str_sub(newnames, 1, 1) = firstletters
newnames 
```


3. Create list of first and last names, but do the same as above but ALSO split list into two lists, i.e., first name and last name.


```{r}
names = c("Joe Plumber", " john smith")

```

---









## RegEx

https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/regex

See also: `grep`



```{r}
sentence = "There are 10 lions, 4 bears, and 23 monkeys in the zoo.  The Lions like to eat meat.  Their favorite thing too do is sleep.  "
```


```{r}
str_replace_all(sentence, "lions", "tigers")
```




### Character sets

Contained within brackets.

```{r}
str_extract_all(sentence, "[aeiou]")
```

```{r}
str_extract_all(sentence, "[f-w]")
```


```{r}
# Get capital letters
str_extract_all(sentence, "[A-Z]")
```

```{r}
# Digits
str_extract_all(sentence, "[0-9]")
```


### Meta Characters

Meta characters (character types) begin with a backslash `\`. However, the backslash `\` is a special character in R, so needs to be escaped each time it is used with another backslash. 

`\\s`: spaces

`\\t`: tab

`\\n`: newline

`\\d`: numeric digits

`\\w`:alphanumeric characters (equivalent to `[A-Za-z0-9]`)


```{r}
str_extract_all(sentence, "\\w*\\s")
```


---


### Quantifiers

Quantify the number of characters.

`+`: One or more characters

```{r}
str_extract_all(sentence, "Th+")
```


`{}`: specify number or range of matches, e.g., `{2}`

```{r}
str_extract_all(sentence, "o{2}")
```


```{r}
str_extract_all(sentence, "\\d{1,2}")
```



`*`: quantifies zero or more matches

```{r}
str_extract_all(sentence, "[A-Za-z]*")
```


#### Combining expression

```{r}
str_extract_all(sentence, "\\d{1,2}\\s\\w+")
```
