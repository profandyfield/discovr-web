---
title: R code Chapter 2
linktitle: Code Chapter 2
toc: true
type: docs
date: "2020-07-07T00:00:00Z"
draft: false
menu:
  code:
    parent: R Code
    weight: 2

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 2

---

<img src="/img/space_pirate.png" alt = "Mae Jemstone character from Discovering Statistics using R and RStudio" width="200">

{{% alert note %}}

<p>This document contains abridged sections from <em>Discovering Statistics Using R and RStudio</em> by <a href="/index.html#about">Andy Field</a> so there are some copyright considerations. You can use this material for teaching and non-profit activities but please do not meddle with it or claim it as your own work. See the full license terms at the bottom of the page.</p>

{{% /alert %}}

``` r
# Make sure to load this package
library(tidyverse)
```

## The median

``` r
fb_tib <- tibble::tibble(
    friends = c(57, 40, 103, 234, 93, 53, 116, 98, 108, 121, 22)
  )

# Base R:

median(fb_tib$friends)
```

    ## [1] 98

``` r
# One pipe:

fb_tib |>
  dplyr::summarize(
    median =  median(friends)
  )
```

    ## # A tibble: 1 × 1
    ##   median
    ##    <dbl>
    ## 1     98

## The mean

``` r
# Base R:

mean(fb_tib$friends)
```

    ## [1] 95

``` r
mean(fb_tib$friends, trim = 0.1)
```

    ## [1] 87.66667

``` r
# A pipe to get the mean, trimmed mean and median:

fb_tib |>
  dplyr::summarize(
    median =  median(friends),
    mean =  mean(friends),
    `trimmed mean 10%` =  mean(friends, trim = 0.1)
  )
```

    ## # A tibble: 1 × 3
    ##   median  mean `trimmed mean 10%`
    ##    <dbl> <dbl>              <dbl>
    ## 1     98    95               87.7

### The dispersion in a distribution

``` r
# The range
max(fb_tib$friends) - min(fb_tib$friends)
```

    ## [1] 212

``` r
# Quartiles
quantile(fb_tib$friends, probs = c(0.25, 0.5, 0.75))
```

    ## 25% 50% 75% 
    ##  55  98 112

``` r
# Lower quartile
quantile(fb_tib$friends, probs = 0.25)
```

    ## 25% 
    ##  55

``` r
# Upper quartile
quantile(fb_tib$friends, probs = 0.75)
```

    ## 75% 
    ## 112

``` r
# Inter-quartile range
IQR(fb_tib$friends)
```

    ## [1] 57

``` r
# Variance
var(fb_tib$friends)
```

    ## [1] 3224.6

``` r
# standard deviation
sd(fb_tib$friends)
```

    ## [1] 56.78556

``` r
# Tidyverse sumptuousness:

fb_tib |>
  dplyr::summarize(
    median =  median(friends),
    mean =  mean(friends),
    `trimmed mean 10%` =  mean(friends, trim = 0.1),
    range = max(friends) - min(friends),
    `lower quartile` = quantile(friends, probs = 0.25),
    `upper quartile` = quantile(friends, probs = 0.75),
    IQR = IQR(friends),
    var = var(friends),
    sd = sd(friends)
) |> 
  round(2)
```

    ## # A tibble: 1 × 9
    ##   median  mean `trimmed mean 10%` range lower quarti…¹ upper…²   IQR   var    sd
    ##    <dbl> <dbl>              <dbl> <dbl>          <dbl>   <dbl> <dbl> <dbl> <dbl>
    ## 1     98    95               87.7   212             55     112    57 3225.  56.8
    ## # … with abbreviated variable names ¹​`lower quartile`, ²​`upper quartile`

------------------------------------------------------------------------

## Pieces of great

### Pieces of great 2.1

``` r
round(3.211420)
```

    ## [1] 3

``` r
round(3.211420, 2)
```

    ## [1] 3.21

``` r
round(3.211420, 4)
```

    ## [1] 3.2114

``` r
round(mean(fb_tib$friends, trim = 0.1), 2)
```

    ## [1] 87.67

``` r
mean(fb_tib$friends, trim = 0.1) |> round(2)
```

    ## [1] 87.67

``` r
fb_tib |>
  dplyr::summarize(
    median =  median(friends),
    mean =  mean(friends),
    `trimmed mean 10%` =  mean(friends, trim = 0.1)
  ) |> 
  round(2)
```

    ## # A tibble: 1 × 3
    ##   median  mean `trimmed mean 10%`
    ##    <dbl> <dbl>              <dbl>
    ## 1     98    95               87.7

### Pieces of great 2.2

``` r
get_summary <- function(tibble, variable){
  variable <- enquo(variable)
  
  summary <- tibble |> 
    dplyr::summarise(
      median =  median(!!variable),
      mean =  mean(!!variable),
      `trimmed mean 10%` =  mean(!!variable, trim = 0.1)
      ) |> 
    round(2)


return(summary)
} 

fb_tib |> 
  get_summary(friends)
```

    ## # A tibble: 1 × 3
    ##   median  mean `trimmed mean 10%`
    ##    <dbl> <dbl>              <dbl>
    ## 1     98    95               87.7

Or, annoy people by using random names for the inputs of the function:

``` r
get_summary <- function(johnson_pitchfork, harry_the_hungy_hippo){
  harry_the_hungy_hippo <- enquo(harry_the_hungy_hippo)
  
  summary <- johnson_pitchfork |> 
    dplyr::summarise(
      median =  median(!!harry_the_hungy_hippo),
      mean =  mean(!!harry_the_hungy_hippo),
      `trimmed mean 10%` =  mean(!!harry_the_hungy_hippo, trim = 0.1)
      ) |> 
    round(2)

return(summary)
}


fb_tib |> 
  get_summary(friends)
```

    ## # A tibble: 1 × 3
    ##   median  mean `trimmed mean 10%`
    ##    <dbl> <dbl>              <dbl>
    ## 1     98    95               87.7

Include options relating to `mean()` and `median()`

``` r
get_summary <- function(tibble, variable, na_remove = FALSE, trim_val = 0){
  variable <- enquo(variable)
  
  summary <- tibble |> 
    dplyr::summarise(
      median =  median(!!variable, na.rm = na_remove),
      mean =  mean(!!variable, na.rm = na_remove, trim = trim_val)
      ) |> 
    round(2)

return(summary)
}

fb_tib |> 
  get_summary(friends, na_remove = TRUE, trim_val  = 0.1)
```

    ## # A tibble: 1 × 2
    ##   median  mean
    ##    <dbl> <dbl>
    ## 1     98  87.7
