---
title: Smart Alex solutions Chapter 9
linktitle: Alex Chapter 9
toc: true
type: docs
date: "2020-07-06T00:00:00Z"
draft: false
menu:
  alex:
    parent: Smart Alex
    weight: 9

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 9

---

<img src="/img/dsus_smart_alex_banner.png" alt = "Smart Alex charatcer from Discovering Statistics using R and RStudio" width="600">

{{% alert note %}}

<p>This document contains abridged sections from <em>Discovering Statistics Using R and RStudio</em> by <a href="/index.html#about">Andy Field</a> so there are some copyright considerations. You can use this material for teaching and non-profit activities but please do not meddle with it or claim it as your own work. See the full license terms at the bottom of the page.</p>

{{% /alert %}}

## Task 9.1

> Is arachnophobia (fear of spiders) specific to real spiders or will pictures of spiders evoke similar levels of anxiety? Twelve arachnophobes were asked to play with a big hairy tarantula with big fangs and an evil look in its eight eyes and at a different point in time were shown only photos of the same spider. The participants’ anxiety was measured in each case. Do a *t*-test to see whether anxiety is higher for real spiders than pictures (big_hairy_spider.csv).

### Load the data

``` r
spider_tib <- readr::read_csv("../data/big_hairy_spider.csv") %>% 
  dplyr::mutate(
    spider_type = forcats::as_factor(spider_type)
  )
```

Alternative, load the data directly from the `discovr` package:

``` r
spider_tib <- discovr::big_hairy_spider
```

### Summary statistics

``` r
spider_summary <- spider_tib %>% 
  dplyr::group_by(spider_type) %>% 
  dplyr::summarize(
    mean = mean(anxiety),
    sd = sd(anxiety),
    ci_lower = ggplot2::mean_cl_normal(anxiety)$ymin,
    ci_upper = ggplot2::mean_cl_normal(anxiety)$ymax
  )
spider_summary
```

| spider_type | mean |    sd | ci_lower | ci_upper |
|:------------|-----:|------:|---------:|---------:|
| Picture     |   40 |  9.29 |    34.10 |    45.90 |
| Real        |   47 | 11.03 |    39.99 |    54.01 |

Table 1: Summary statistics

### Fit the model

We need to run a paired samples *t*-test on these data. We need to make sure we sort the file by **id** so that the pairing is done correctly.

``` r
spider_mod <- spider_tib %>% 
  dplyr::arrange(id) %>% 
  t.test(anxiety ~ spider_type, data = ., paired = TRUE)

spider_mod
```

    ## 
    ##  Paired t-test
    ## 
    ## data:  anxiety by spider_type
    ## t = -2.4725, df = 11, p-value = 0.03098
    ## alternative hypothesis: true mean difference is not equal to 0
    ## 95 percent confidence interval:
    ##  -13.2312185  -0.7687815
    ## sample estimates:
    ## mean difference 
    ##              -7

### Effect size

``` r
effectsize::cohens_d(anxiety ~ spider_type, data = spider_tib)
```

    ## Cohen's d |        95% CI
    ## -------------------------
    ## -0.69     | [-1.50, 0.15]
    ## 
    ## - Estimated using pooled SD.

### Reporting the analysis

We could report the result as:

- On average, participants experienced significantly greater anxiety with real spiders (*M* = 47.00, *SE* = 3.18) than with pictures of spiders (*M* = 40.00, *SE* = 2.68), *t*(11) = -2.47, *p* = 0.031, *d* = -0.69, 0.95, -1.5, 0.15.

## Task 9.2

> Task 2: Estimate the Bayes factor for the difference between anxiety levels induced by a real spider compared to a photo

First get the data messy:

``` r
spider_messy_tib <- spider_tib %>% 
  tidyr::spread(value = anxiety, key = spider_type)
```

| id           | Picture | Real |
|:-------------|--------:|-----:|
| Aayaat       |      40 |   55 |
| Abdul Wahaab |      45 |   50 |
| Bepe         |      50 |   65 |
| Blas         |      25 |   35 |
| Cole         |      30 |   30 |
| Colton       |      30 |   40 |
| Dustin       |      45 |   50 |
| Faraj        |      50 |   39 |
| Fred         |      40 |   60 |
| Jordan       |      55 |   50 |
| Naasif       |      35 |   35 |
| Saajida      |      35 |   55 |

Now get the Bayes factor

``` r
spider_bf <- BayesFactor::ttestBF(spider_messy_tib$Picture, spider_messy_tib$Real, paired = TRUE, rscale = "medium")
spider_bf
```

    ## Bayes factor analysis
    ## --------------
    ## [1] Alt., r=0.707 : 2.400782 ±0%
    ## 
    ## Against denominator:
    ##   Null, mu = 0 
    ## ---
    ## Bayes factor type: BFoneSample, JZS

``` r
BayesFactor::posterior(spider_bf, iterations = 1000) %>% 
  summary()
```

    ## 
    ## Iterations = 1:1000
    ## Thinning interval = 1 
    ## Number of chains = 1 
    ## Sample size per chain = 1000 
    ## 
    ## 1. Empirical mean and standard deviation for each variable,
    ##    plus standard error of the mean:
    ## 
    ##           Mean      SD Naive SE Time-series SE
    ## mu     -5.8229  2.9182 0.092280        0.09771
    ## sig2  113.1770 56.2701 1.779417        2.25722
    ## delta  -0.5935  0.3125 0.009882        0.01100
    ## g       4.0887 28.2234 0.892501        0.89250
    ## 
    ## 2. Quantiles for each variable:
    ## 
    ##           2.5%     25%     50%      75%     97.5%
    ## mu    -11.3451 -7.6837 -5.9371  -3.8671 4.457e-02
    ## sig2   47.2957 76.6723 99.6338 133.9362 2.437e+02
    ## delta  -1.2178 -0.8097 -0.5891  -0.3721 5.364e-03
    ## g       0.1071  0.2956  0.6588   1.6780 1.826e+01

The Bayes factor, \$ \_{10} \$ = 2.40, suggested that the data were 2.4 times more probable under the alternative hypothesis than under the null.

## Task 9.3

> ‘Pop psychology’ books sometimes spout nonsense that is unsubstantiated by science. I took 20 people in relationships and randomly assigned them to one of two groups. One group read the famous popular psychology book Women are from Bras and men are from Penis, and the other read Marie Claire. The outcome variable was their relationship happiness after their assigned reading. Were people happier with their relationship after reading the pop psychology book? (**self_help.csv**).

### Load the data

``` r
self_help_tib <- readr::read_csv("../data/self_help.csv") %>% 
  dplyr::mutate(
    book = forcats::as_factor(book)
  )
```

Alternative, load the data directly from the `discovr` package:

``` r
self_help_tib <- discovr::self_help
```

### Summary statistics

``` r
self_summary <- self_help_tib %>% 
  dplyr::group_by(book) %>% 
  dplyr::summarize(
    mean = mean(happy),
    sd = sd(happy),
    ci_lower = ggplot2::mean_cl_normal(happy)$ymin,
    ci_upper = ggplot2::mean_cl_normal(happy)$ymax
  )
self_summary
```

| book                                    | mean |   sd | ci_lower | ci_upper |
|:----------------------------------------|-----:|-----:|---------:|---------:|
| Women are from Bras, Men are from Penis | 20.0 | 4.11 |    17.06 |    22.94 |
| Marie Claire                            | 24.2 | 4.71 |    20.83 |    27.57 |

Table 2: Summary statistics

### Fit the model

``` r
self_help_mod <- t.test(happy ~ book, data = self_help_tib)
self_help_mod 
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  happy by book
    ## t = -2.1249, df = 17.676, p-value = 0.04796
    ## alternative hypothesis: true difference in means between group Women are from Bras, Men are from Penis and group Marie Claire is not equal to 0
    ## 95 percent confidence interval:
    ##  -8.35799532 -0.04200468
    ## sample estimates:
    ## mean in group Women are from Bras, Men are from Penis 
    ##                                                  20.0 
    ##                            mean in group Marie Claire 
    ##                                                  24.2

We can estimate Cohen’s \$ d \$ as follows:

``` r
d_self_help <- effectsize::cohens_d(happy ~ book, data = self_help_tib)
d_self_help
```

    ## Cohen's d |         95% CI
    ## --------------------------
    ## -0.95     | [-1.87, -0.01]
    ## 
    ## - Estimated using pooled SD.

This means that reading the self-help book reduced relationship happiness by about one standard deviation, which is a fairly big effect.

### Report the findings

We could report this result as:

- On average, the reported relationship happiness after reading *Marie Claire* (*M* = 24.20, *SE* = 1.49), was significantly higher than after reading *Women are from bras and men are from penis* (*M* = 20.00, *SE* = 1.30), *
  *t*(17.68) = -2.12, *p\* = 0.048, *d* = -0.95, 0.95, -1.87, -0.01.

## Task 9.4

> Twaddle and Sons, the publishers of *Women are from Bras and men are from Penis*, were upset about my claims that their book was as useful as a paper umbrella. They ran their own experiment (N = 500) in which relationship happiness was measured after participants had read their book and after reading the book you are currently reading. (Participants read the books in counterbalanced order with a six-month delay.) Was relationship happiness greater after reading their wonderful contribution to pop psychology than after reading my tedious tome about statistics? (**self_help_dsur.csv**).

### Load the data

``` r
dsur_tib <- readr::read_csv("../data/self_help_dsur.csv") %>% 
  dplyr::mutate(
    book = forcats::as_factor(book)
  )
```

Alternative, load the data directly from the `discovr` package:

``` r
dsur_tib <- discovr::self_help_dsur
```

### Summary statistics

``` r
dsur_summary <- dsur_tib %>% 
  dplyr::group_by(book) %>% 
  dplyr::summarize(
    mean = mean(happiness),
    sd = sd(happiness),
    ci_lower = ggplot2::mean_cl_normal(happiness)$ymin,
    ci_upper = ggplot2::mean_cl_normal(happiness)$ymax
  )
dsur_summary
```

| book                           |  mean |   sd | ci_lower | ci_upper |
|:-------------------------------|------:|-----:|---------:|---------:|
| Self-help book                 | 20.02 | 9.98 |    19.14 |    20.90 |
| Discovering statistics using R | 18.49 | 8.99 |    17.70 |    19.28 |

Table 3: Summary statistics

### Fit the model

We need to run a paired samples *t*-test on these data. We need to make sure we sort the file by **id** so that the pairing is done correctly.

``` r
dsur_mod <- dsur_tib %>% 
  dplyr::arrange(id) %>% 
  t.test(happiness ~ book, data = ., paired = TRUE)

dsur_mod
```

    ## 
    ##  Paired t-test
    ## 
    ## data:  happiness by book
    ## t = 2.7056, df = 499, p-value = 0.00705
    ## alternative hypothesis: true mean difference is not equal to 0
    ## 95 percent confidence interval:
    ##  0.41843 2.63757
    ## sample estimates:
    ## mean difference 
    ##           1.528

### Effect size

``` r
d_dsur <- effectsize::cohens_d(happiness ~ book, data = dsur_tib)
```

### Reporting the analysis

Therefore, although this effect is highly statistically significant, the size of the effect is small. In this example, it would be tempting for *Twaddle and Sons* to conclude that their book produced significantly greater relationship happiness than our book. In fact, many researchers would write conclusions like this:

- On average, the reported relationship happiness after reading Field and Hole (2003) (*M* = 18.49, *SE* = 0.402), was significantly higher than after reading *Women are from bras and men are from penis* (*M* = 20.02, *SE* = 0.446), *t*(499) = 2.71, *p* = 0.007. In other words, reading *Women are from bras and men are from penis* produces significantly greater relationship happiness than that book by smelly old Field.

However, to reach such a conclusion is to confuse statistical significance with the importance of the effect. By calculating the effect size we’ve discovered that although the difference in happiness after reading the two books is statistically different, the size of effect that this represents is small. A more balanced interpretation might, therefore, be:

- On average, the reported relationship happiness after reading Field and Hole (2003) (*M* = 18.49, *SE* = 0.402), was significantly higher than after reading *Women are from bras and men are from penis* (*M* = 20.02, *SE* = 0.446), *t*(499) = 2.71, *p* = 0.007, *d* = 0.16, 0.95, 0.04, 0.28. However, the effect size was small, revealing that this finding was not substantial in real terms.

Of course, this latter interpretation would be unpopular with *Twaddle and Sons* who would like to believe that their book had a huge effect on relationship happiness.

## Task 9.5

> In Chapter 1 (Task 6) we looked at data from people who had been forced to marry goats and dogs and measured their life satisfaction as well as how much they like animals (**animal_bride.csv**). Conduct a *t*-test to see whether life satisfaction depends upon the type of animal to which a person was married.

### Load the data

``` r
goat_tib <- readr::read_csv("../data/animal_bride.csv") %>% 
  dplyr::mutate(
    wife = forcats::as_factor(wife)
  )
```

Alternative, load the data directly from the `discovr` package:

``` r
goat_tib <- discovr::animal_bride
```

### Summary statistics

``` r
goat_summary <- goat_tib %>% 
  dplyr::group_by(wife) %>% 
  dplyr::summarize(
    mean = mean(life_satisfaction),
    sd = sd(life_satisfaction),
    ci_lower = ggplot2::mean_cl_normal(life_satisfaction)$ymin,
    ci_upper = ggplot2::mean_cl_normal(life_satisfaction)$ymax
  )
goat_summary
```

| wife |  mean |    sd | ci_lower | ci_upper |
|:-----|------:|------:|---------:|---------:|
| Goat | 38.17 | 15.51 |    28.31 |    48.02 |
| Dog  | 60.12 | 11.10 |    50.84 |    69.41 |

Table 4: Summary statistics

### Fit the model

``` r
goat_mod <- t.test(life_satisfaction ~ wife, data = goat_tib)
goat_mod 
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  life_satisfaction by wife
    ## t = -3.6879, df = 17.843, p-value = 0.001704
    ## alternative hypothesis: true difference in means between group Goat and group Dog is not equal to 0
    ## 95 percent confidence interval:
    ##  -34.475353  -9.441314
    ## sample estimates:
    ## mean in group Goat  mean in group Dog 
    ##           38.16667           60.12500

We can estimate Cohen’s \$ d \$ as follows:

``` r
d_goat <- effectsize::cohens_d(life_satisfaction ~ wife, data = goat_tib)
d_goat
```

    ## Cohen's d |         95% CI
    ## --------------------------
    ## -1.57     | [-2.59, -0.53]
    ## 
    ## - Estimated using pooled SD.

### Report the findings

As well as being statistically significant, this effect is very large and so represents a substantive finding. We could report:

- On average, the life satisfaction of men married to dogs (*M* = 60.13, *SE* = 3.93) was significantly higher than that of men who were married to goats (*M* = 38.17, *SE* = 4.48), *t*(17.84) = -3.69, *p* = 0.002, *d* = -1.57, 0.95, -2.59, -0.53.

## Task 9.6

> Repeat the t-test from Task 5 but turn of Welch’s correction. Then fit a linear model to see whether life satisfaction is significantly predicted from the type of animal that was married. What do you notice about the t-value and significance in these two models?

Fit the t-test without Welch’s correction:

``` r
goat_mod <- t.test(life_satisfaction ~ wife, data = goat_tib, var.equal = TRUE)
goat_mod 
```

    ## 
    ##  Two Sample t-test
    ## 
    ## data:  life_satisfaction by wife
    ## t = -3.4458, df = 18, p-value = 0.002883
    ## alternative hypothesis: true difference in means between group Goat and group Dog is not equal to 0
    ## 95 percent confidence interval:
    ##  -35.346354  -8.570312
    ## sample estimates:
    ## mean in group Goat  mean in group Dog 
    ##           38.16667           60.12500

Now the linear model:

``` r
goat_lm <- lm(life_satisfaction ~ wife, data = goat_tib)
summary(goat_lm)
```

    ## 
    ## Call:
    ## lm(formula = life_satisfaction ~ wife, data = goat_tib)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -32.167  -5.906   4.354   8.833  17.833 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)   38.167      4.030   9.470 2.05e-08 ***
    ## wifeDog       21.958      6.372   3.446  0.00288 ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 13.96 on 18 degrees of freedom
    ## Multiple R-squared:  0.3975, Adjusted R-squared:  0.364 
    ## F-statistic: 11.87 on 1 and 18 DF,  p-value: 0.002883

The values of *t* and *p* are the same. (Technically, *t* is different because for the linear model it is a positive value and for the *t*-test it is negative However, the sign of *t* merely reflects which way around you coded the dog and goat groups. The linear model, by default, has coded the groups the opposite way around to the *t*-test.) The main point I wanted to make here is that whether you run these data through the `lm()` or `t.test()` functions, the results are identical.

## Task 9.7

> In Chapter 6 we looked at hygiene scores over three days of a rock music festival (**download_festival.csv**). Do a paired-samples t-test to see whether hygiene scores on day 1 differed from those on day 3.

### Load the data

``` r
download_tib <- readr::read_csv("../data/download_festival.csv") %>% 
  dplyr::mutate(
    gender = forcats::as_factor(gender)
  )
```

Alternative, load the data directly from the `discovr` package:

``` r
download_tib <- discovr::download
```

### Summary statistics

are missing values for days 2 and 3 so we need to remember to include `na.rm = TRUE` in the functions for the mean, sd and confidence interval.

It’s also useful if we convert the data to tidy format:

``` r
download_tidy_tib <- download_tib %>% 
  tidyr::pivot_longer(
    cols = day_1:day_3,
    names_to = "day",
    values_to = "hygiene"
  )
```

``` r
download_summary <- download_tidy_tib %>% 
  dplyr::group_by(day) %>% 
  dplyr::summarize(
    mean = mean(hygiene, na.rm = TRUE),
    sd = sd(hygiene, na.rm = TRUE),
    ci_lower = ggplot2::mean_cl_normal(hygiene)$ymin,
    ci_upper = ggplot2::mean_cl_normal(hygiene)$ymax
  )

download_summary
```

| day   | mean |   sd | ci_lower | ci_upper |
|:------|-----:|-----:|---------:|---------:|
| day_1 | 1.79 | 0.94 |     1.73 |     1.86 |
| day_2 | 0.96 | 0.72 |     0.87 |     1.05 |
| day_3 | 0.98 | 0.71 |     0.85 |     1.10 |

Table 5: Summary statistics

### Fit the model

We need to run a paired samples *t*-test on these data. We need to ignore the day 2 scores because we want to compare days 1 and 3 only, and to add to our woe we have missing values for days 2 and 3, so we need to deal with those (the `t.test()` function will fail if there are `NA`s. In the book we looked only at inputting variables into `t.test()` in a formula:

`t.test(outcome ~ predictor, data = tibble)`

This method works well for tidy data (hence why I use it in the book). However, there is an alterantive way to use the function where you input the sets of scores for your two groups as separate variables:

`t.test(x = first_set_of_scores, y = second_set_of_scores)`

We have used this sort of input for other functions in the chapter. This input comes in handy when you have missing values and paired scores because if we have the `day_1` and `day_3` scores in separate columns (i.e. in messy format), then we can place these variables into the `t.test()` function and include `na.action = "na.exclude"` and the function will ignore any participant who doesn’t have scores for both days. So, we could execute:

``` r
download_mod <- t.test(download_tib$day_1, download_tib$day_3, paired = TRUE, na.action = "na.exclude")
download_mod
```

    ## 
    ##  Paired t-test
    ## 
    ## data:  download_tib$day_1 and download_tib$day_3
    ## t = 10.587, df = 122, p-value < 2.2e-16
    ## alternative hypothesis: true mean difference is not equal to 0
    ## 95 percent confidence interval:
    ##  0.5487477 0.8011710
    ## sample estimates:
    ## mean difference 
    ##       0.6749593

### Effect size

To calculate \$ d \$ we first need to filter out the day two data from the original tibble using `dplyr::filter()`, within which we include `day != "day_2"` which translates as *the variable **day** is not equal to ‘day_2’*.

``` r
d_download <- download_tidy_tib %>% 
  dplyr::filter(day != "day_2") %>% 
  effectsize::cohens_d(hygiene ~ day, data = .)

d_download
```

    ## Cohen's d |       95% CI
    ## ------------------------
    ## 0.89      | [0.70, 1.08]
    ## 
    ## - Estimated using pooled SD.

### Reporting the analysis

We could report:

- On average, hygiene scores significantly decreased from day 1 (*M* = 1.65, *SE* = 0.06), to day 3 (*M* = 0.98, *SE* = 0.06) of the Download music festival, *t*(122) = 10.59, *p* = 0, *d* = 0.89, 0.95, 0.7, 1.08.

## Task 9.8

> A psychologist was interested in the cross-species differences between men and dogs. She observed a group of dogs and a group of men in a naturalistic setting (20 of each). She classified several behaviours as being dog-like (urinating against trees and lampposts, attempts to copulate with anything that moved, and attempts to lick their own genitals). For each man and dog she counted the number of dog-like behaviours displayed in a 24-hour period. It was hypothesized that dogs would display more dog-like behaviours than men. Test this hypothesis using a robust test. (**men_dogs.csv**)

### Load the data

``` r
dogs_tib <- readr::read_csv("../data/men_dogs.csv") %>% 
  dplyr::mutate(
    species = forcats::as_factor(species)
  )
```

Alternative, load the data directly from the `discovr` package:

``` r
dogs_tib <- discovr::men_dogs
```

### Summary statistics

There are missing values for days 2 and 3 so we need to remember to include `na.rm = TRUE` in the functions for the mean, sd and confidence interval.

``` r
dogs_summary <- dogs_tib %>% 
  dplyr::group_by(species) %>% 
  dplyr::summarize(
    mean = mean(behaviour),
    sd = sd(behaviour),
    ci_lower = ggplot2::mean_cl_normal(behaviour)$ymin,
    ci_upper = ggplot2::mean_cl_normal(behaviour)$ymax
  )

dogs_summary
```

| species |  mean |    sd | ci_lower | ci_upper |
|:--------|------:|------:|---------:|---------:|
| Dog     | 28.05 | 10.98 |    22.91 |    33.19 |
| Man     | 26.85 |  9.90 |    22.22 |    31.48 |

Table 6: Summary statistics

### Fit the model

Fit the model

``` r
dog_mod <- t.test(behaviour ~ species, data = dogs_tib)
dog_mod 
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  behaviour by species
    ## t = 0.36297, df = 37.6, p-value = 0.7187
    ## alternative hypothesis: true difference in means between group Dog and group Man is not equal to 0
    ## 95 percent confidence interval:
    ##  -5.495178  7.895178
    ## sample estimates:
    ## mean in group Dog mean in group Man 
    ##             28.05             26.85

We can estimate Cohen’s \$ d \$ as follows:

``` r
d_dog <- effectsize::cohens_d(behaviour ~ species, data = dogs_tib)
d_dog
```

    ## Cohen's d |        95% CI
    ## -------------------------
    ## 0.11      | [-0.51, 0.73]
    ## 
    ## - Estimated using pooled SD.

### Report the findings

The effect is not statistically significant, and is a small effect. We could report:

- On average, men (*M* = 26.85, *SE* = 2.23) engaged in less dog-like behaviour than dogs (*M* = 28.05, *SE* = 2.37). However, this difference, 1.2, 95% CI \[-5.50 to 7.90\], was not significant, *t*(37.6) = 0.36, *p* = 0.719, *d* = 0.11, 0.95, -0.51, 0.73.

## Task 9.9

> Both Ozzy Osbourne and Judas Priest have been accused of putting backward masked messages on their albums that subliminally influence poor unsuspecting teenagers into doing things like blowing their heads off with shotguns. A psychologist was interested in whether backward masked messages could have an effect. He created a version of Taylor Swifts’ ‘Shake it off’ that contained the masked message ‘deliver your soul to the dark lord’ repeated in the chorus. He took this version, and the original, and played one version (randomly) to a group of 32 people. Six months later he played them whatever version they hadn’t heard the time before. So, each person heard both the original and the version with the masked message, but at different points in time. The psychologist measured the number of satanic intrusions the person had in the week after listening to each version. Test the hypothesis that the backward message would lead to more intrusions (**dark_lord.csv**) using a robust test.

### Load the data

``` r
dark_tib <- readr::read_csv("../data/dark_lord.csv") %>% 
  dplyr::mutate(
    message = forcats::as_factor(message)
  )
```

Alternative, load the data directly from the `discovr` package:

``` r
dark_tib <- discovr::dark_lord
```

### Summary statistics

There are missing values for days 2 and 3 so we need to remember to include `na.rm = TRUE` in the functions for the mean, sd and confidence interval.

``` r
dark_summary <- dark_tib %>% 
  dplyr::group_by(message) %>% 
  dplyr::summarize(
    mean = mean(intrusions),
    sd = sd(intrusions),
    ci_lower = ggplot2::mean_cl_normal(intrusions)$ymin,
    ci_upper = ggplot2::mean_cl_normal(intrusions)$ymax
  )

dark_summary
```

    ## # A tibble: 2 × 5
    ##   message     mean    sd ci_lower ci_upper
    ##   <fct>      <dbl> <dbl>    <dbl>    <dbl>
    ## 1 Message     9.16  3.55     7.88     10.4
    ## 2 No message 11.5   4.38     9.92     13.1

| message    |  mean |   sd | ci_lower | ci_upper |
|:-----------|------:|-----:|---------:|---------:|
| Message    |  9.16 | 3.55 |     7.88 |    10.44 |
| No message | 11.50 | 4.38 |     9.92 |    13.08 |

Table 7: Summary statistics

### Fit the model

We need to run a paired samples *t*-test on these data. We need to make sure we sort the file by **id** so that the pairing is done correctly.

``` r
dark_messy_tib <- dark_tib %>% 
  tidyr::spread(value = intrusions, key = message)

dark_mod <- WRS2::yuend(dark_messy_tib$Message, dark_messy_tib$`No message`)
dark_mod
```

    ## Call:
    ## WRS2::yuend(x = dark_messy_tib$Message, y = dark_messy_tib$`No message`)
    ## 
    ## Test statistic: -1.9638 (df = 19), p-value = 0.06435
    ## 
    ## Trimmed mean difference:  -1.55 
    ## 95 percent confidence interval:
    ## -3.202     0.102 
    ## 
    ## Explanatory measure of effect size: 0.36

### Effect size

``` r
d_dark <- effectsize::cohens_d(intrusions ~ message, data = dark_tib)
```

### Reporting the analysis

- Participants had fewer Satanic intrusions after hearing the backward message (*M* = 9.16, *SE* = 0.62), than after hearing the normal version of the Taylor Swift song (*M* = 11.50, *SE* = 0.80). This difference, -1.55, 95% CI \[-3.2, 0.1\], was not significant, *t*(19) = -1.96, *p* = 0.064. However, it represented a substantial effect, *d* = -0.59, 0.95, -1.09, -0.08.

## Task 9.10

> Test whether the number of offers was significantly different in people listening to Bon Scott than in those listening to Brian Johnson, using a robust independent *t*-test with bootstrapping. Do your results differ from Oxoby (2008)? (**acdc.csv**)

### Load the data

``` r
oxoby_tib <- readr::read_csv("../data/acdc.csv") %>% 
  dplyr::mutate(
    singer = forcats::as_factor(singer)
  )
```

Alternative, load the data directly from the `discovr` package:

``` r
oxoby_tib <- discovr::acdc
```

### Summary statistics

``` r
oxoby_summary <- oxoby_tib %>% 
  dplyr::group_by(singer) %>% 
  dplyr::summarize(
    mean = mean(offer),
    sd = sd(offer),
    ci_lower = ggplot2::mean_cl_normal(offer)$ymin,
    ci_upper = ggplot2::mean_cl_normal(offer)$ymax
  )

oxoby_summary
```

| singer        | mean |   sd | ci_lower | ci_upper |
|:--------------|-----:|-----:|---------:|---------:|
| Bon Scott     | 3.28 | 1.18 |     2.69 |     3.86 |
| Brian Johnson | 4.00 | 0.97 |     3.52 |     4.48 |

Table 8: Summary statistics

### Fit the model

Fit the model

``` r
acdc_mod <- WRS2::yuenbt(offer ~ singer, data = oxoby_tib, nboot = 1000, side = TRUE)
acdc_mod
```

    ## Call:
    ## WRS2::yuenbt(formula = offer ~ singer, data = oxoby_tib, nboot = 1000, 
    ##     side = TRUE)
    ## 
    ## Test statistic: -1.7339 (df = NA), p-value = 0.075
    ## 
    ## Trimmed mean difference:  -0.83333 
    ## 95 percent confidence interval:
    ## -1.7726     0.106

The bootstrap confidence interval ranged from -1.77 to 0.11, which just about crosses zero suggesting that (if we assume that it is one of the 95% of confidence intervals that contain the true value) that the effect in the population could be zero.

We can estimate Cohen’s \$ d \$ as follows:

``` r
d_acdc <- effectsize::cohens_d(offer ~ singer, data = oxoby_tib)
d_acdc
```

    ## Cohen's d |        95% CI
    ## -------------------------
    ## -0.67     | [-1.34, 0.01]
    ## 
    ## - Estimated using pooled SD.

### Report the findings

We could report:

- On average, more offers were made when listening to Brian Johnson (*M* = 4.00, *SE* = 0.23) than Bon Scott (*M* = 3.28, *SE* = 0.28). This difference, -0.72, BCa 95% CI \[-1.77, 0.11\], was not significant, *t* = -1.73, *p* = 0.075; however, it produced a medium effect, *d* = -0.67, 0.95, -1.34, 0.01.
