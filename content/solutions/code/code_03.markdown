---
title: R code Chapter 3
linktitle: Code Chapter 3
toc: true
type: docs
date: "2020-07-07T00:00:00Z"
draft: false
menu:
  code:
    parent: R Code
    weight: 3

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 3

---

<img src="/img/space_pirate.png" alt = "Mae Jemstone character from Discovering Statistics using R and RStudio" width="200">


***
This document may contain abridged sections from *Discovering Statistics Using R and RStudio* by [Andy Field](https://www.discoveringstatistics.com/) so there are some copyright considerations, but the material is offered under a [Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License](http://creativecommons.org/licenses/by-nc-nd/4.0/). Basically you can use this material for teaching and non-profit activities but please do not meddle with it or claim it as your own work.

***




## Confidence intervals using `Hmisc` and `ggplot2`


```r
fb_tib <- tibble::tibble(
    friends = c(57, 40, 103, 234, 93, 53, 116, 98, 108, 121, 22)
  )

ggplot2::mean_cl_normal(fb_tib$friends)
```

```
##    y     ymin     ymax
## 1 95 56.85094 133.1491
```

Something other than a 95% interval:


```r
ggplot2::mean_cl_normal(fb_tib$friends, conf.int = 0.90)
```

```
##    y     ymin    ymax
## 1 95 63.96796 126.032
```

Access individual values by using `$` to access the variable name (`y` for the estimate of the mean, `ymin` for the lower boundary of the CI and `ymax` for the upper boundary). Executing this gives us the lower boundary of the 95% confidence interval:


```r
ggplot2::mean_cl_normal(fb_tib$friends)$ymin
```

```
## [1] 56.85094
```

Use extracted value to create tables of summary statistics:


```r
# Tidyverse sumptuousness:

fb_tib %>%
  dplyr::summarize(
    Mean =  ggplot2::mean_cl_normal(friends)$y,
    `95% CI Lower` = ggplot2::mean_cl_normal(friends)$ymin,
    `95% CI Upper` = ggplot2::mean_cl_normal(friends)$ymax,
    ) %>% 
  round(., 2)
```

```
## # A tibble: 1 x 3
##    Mean `95% CI Lower` `95% CI Upper`
##   <dbl>          <dbl>          <dbl>
## 1    95           56.8           133.
```

You can also combine these with other functions to get summary statistics:


```r
fb_tib %>%
  dplyr::summarize(
    Mean =  ggplot2::mean_cl_normal(friends)$y,
    `95% CI Lower` = ggplot2::mean_cl_normal(friends)$ymin,
    `95% CI Upper` = ggplot2::mean_cl_normal(friends)$ymax,
    IQR = IQR(friends),
    `Std. dev.` = sd(friends)
    ) %>% 
  round(., 2)
```

```
## # A tibble: 1 x 5
##    Mean `95% CI Lower` `95% CI Upper`   IQR `Std. dev.`
##   <dbl>          <dbl>          <dbl> <dbl>       <dbl>
## 1    95           56.8           133.    57        56.8
```


## Confidence intervals using `gmodels`


```r
gmodels::ci(fb_tib$friends)
```

```
##   Estimate   CI lower   CI upper Std. Error 
##   95.00000   56.85094  133.14906   17.12149
```

Something other than a 95% interval:


```r
gmodels::ci(fb_tib$friends, confidence = 0.90)
```

```
##   Estimate   CI lower   CI upper Std. Error 
##   95.00000   63.96796  126.03204   17.12149
```

Access individual values by appending their label in square brackets to the function. Executing this gives us the lower boundary of the 95% confidence interval:


```r
gmodels::ci(fb_tib$friends)["CI lower"]
```

```
## CI lower 
## 56.85094
```

Use extracted value to create tables of summary statistics:


```r
# Tidyverse sumptuousness:

fb_tib %>%
  dplyr::summarize(
    Mean =  gmodels::ci(friends)["Estimate"],
    `95% CI Lower` = gmodels::ci(friends)["CI lower"],
    `95% CI Upper` = gmodels::ci(friends)["CI upper"],
    ) %>% 
  round(., 2)
```

```
## # A tibble: 1 x 3
##    Mean `95% CI Lower` `95% CI Upper`
##   <dbl>          <dbl>          <dbl>
## 1    95           56.8           133.
```
You can also combine these with other functions to get summary statistics:


```r
fb_tib %>%
  dplyr::summarize(
    Mean =  gmodels::ci(friends)["Estimate"],
    `95% CI Lower` = gmodels::ci(friends)["CI lower"],
    `95% CI Upper` = gmodels::ci(friends)["CI upper"],
    IQR = IQR(friends),
    `Std. dev.` = sd(friends)
    ) %>% 
  round(., 2)
```

```
## # A tibble: 1 x 5
##    Mean `95% CI Lower` `95% CI Upper`   IQR `Std. dev.`
##   <dbl>          <dbl>          <dbl> <dbl>       <dbl>
## 1    95           56.8           133.    57        56.8
```


