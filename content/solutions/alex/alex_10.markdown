---
title: Smart Alex solutions Chapter 10
linktitle: Alex Chapter 10
toc: true
type: docs
date: "2020-07-06T00:00:00Z"
draft: false
menu:
  alex:
    parent: Smart Alex
    weight: 10

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 10

---

<img src="/img/dsus_smart_alex_banner.png" alt = "Smart Alex charatcer from Discovering Statistics using R and RStudio" width="600">


***
This document may contain abridged sections from *Discovering Statistics Using R and RStudio* by [Andy Field](https://www.discoveringstatistics.com/) so there are some copyright considerations, but the material is offered under a [Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License](http://creativecommons.org/licenses/by-nc-nd/4.0/). Basically you can use this material for teaching and non-profit activities but please do not meddle with it or claim it as your own work.

***



## Task 10.1


> McNulty et al. (2008) found a relationship between a person’s attractiveness and how much support they give their partner among newlywed heterosexual couples. The data are in **mcnulty_2008.csv**, Is this relationship moderated by spouse (i.e., whether the data were from the husband or wife)?

### Load the data


```r
mcnulty_tib <- readr::read_csv("../data/mcnulty_2008.csv") %>% 
  dplyr::mutate(
    spouse = forcats::as_factor(spouse) %>%
      forcats::fct_relevel(., "Husband")
  )
```

Alternative, load the data directly from the `discovr` package:


```r
mcnulty_tib <- discovr::mcnulty_2008
```

### Centre the predictors


```r
# Create a general function to do the centring
centre <- function(var){
  var - mean(var, na.rm = TRUE)
}

# use the general function to centre multiple variables at once
mcnulty_tib <- mcnulty_tib %>% 
  dplyr::mutate_at(
    vars(attractiveness , support, satisfaction),
    list(cent = centre)
  )
```


### Fit the model


```r
support_lm <- lm(support ~ attractiveness_cent*spouse, data = mcnulty_tib)
broom::glance(support_lm) %>% 
    knitr::kable(digits = 3)
```



| r.squared| adj.r.squared| sigma| statistic| p.value| df| logLik|     AIC|     BIC| deviance| df.residual| nobs|
|---------:|-------------:|-----:|---------:|-------:|--:|------:|-------:|-------:|--------:|-----------:|----:|
|     0.085|         0.068| 0.203|     4.975|   0.003|  3| 31.122| -52.244| -36.745|     6.57|         160|  164|

```r
broom::tidy(support_lm, conf.int = TRUE) %>% 
    knitr::kable(digits = 3)
```



|term                           | estimate| std.error| statistic| p.value| conf.low| conf.high|
|:------------------------------|--------:|---------:|---------:|-------:|--------:|---------:|
|(Intercept)                    |    0.222|     0.022|     9.900|   0.000|    0.177|     0.266|
|attractiveness_cent            |   -0.060|     0.020|    -2.974|   0.003|   -0.100|    -0.020|
|spouseWife                     |    0.024|     0.032|     0.755|   0.451|   -0.039|     0.086|
|attractiveness_cent:spouseWife |    0.105|     0.028|     3.769|   0.000|    0.050|     0.161|

Fit a robust model:


```r
parameters::model_parameters(support_lm, robust = TRUE, vcov.type = "HC4") %>% 
    knitr::kable(digits = 3)
```



|Parameter                      | Coefficient|    SE| CI_low| CI_high|      t| df_error|     p|
|:------------------------------|-----------:|-----:|------:|-------:|------:|--------:|-----:|
|(Intercept)                    |       0.222| 0.023|  0.176|   0.267|  9.564|      160| 0.000|
|attractiveness_cent            |      -0.060| 0.020| -0.100|  -0.020| -2.955|      160| 0.004|
|spouseWife                     |       0.024| 0.032| -0.040|   0.087|  0.744|      160| 0.458|
|attractiveness_cent:spouseWife |       0.105| 0.030|  0.047|   0.164|  3.568|      160| 0.000|

Moderation is shown up by a significant interaction effect, and in this case the interaction is highly significant, *b* = 0.105, 95% CI [0.050, 0.16], *t* = 3.57, *p* < 0.001, indicating that the relationship between attractiveness and support is moderated by spouse.

## Task 10.2

> Produce the simple slopes analysis for Task 1.


```r
interactions::sim_slopes(
  support_lm,
  pred = attractiveness_cent,
  modx = spouse,
  jnplot = FALSE,
  robust = TRUE,
  confint = TRUE
  )
#> SIMPLE SLOPES ANALYSIS 
#> 
#> Slope of attractiveness_cent when spouse = Wife: 
#> 
#>   Est.   S.E.   2.5%   97.5%   t val.      p
#> ------ ------ ------ ------- -------- ------
#>   0.05   0.02   0.00    0.09     2.12   0.04
#> 
#> Slope of attractiveness_cent when spouse = Husband: 
#> 
#>    Est.   S.E.    2.5%   97.5%   t val.      p
#> ------- ------ ------- ------- -------- ------
#>   -0.06   0.02   -0.10   -0.02    -2.95   0.00
```

Essentially, the output shows the results of two different regressions:

* When spouse = husband, there is a significant negative relationship between attractiveness and support, *b* = $ -0.06$, 95% CI [$ -0.10 $, $ -0.02 $], *t* = $ -2.95 $, *p* < 0.01.
* When spouse = wife, there is a significant positive relationship between attractiveness and support, *b* = 0.05, 95% CI [0.00, 0.09], *t* = 2.12, *p* = 0.04.

These results tell us that the relationship between attractiveness of a person and amount of support given to their spouse is different for husbands and wives. Specifically, for wives, as attractiveness increases the level of support that they give to their husbands increases, whereas for husbands, as attractiveness increases the amount of support they give to their wives decreases:


## Task 11.3

> McNulty et al. (2008) also found a relationship between a person’s attractiveness and their relationship satisfaction among newlyweds.  Using the same data as in Tasks 1 and 2, find out if this relationship is moderated by spouse?


```r
satis_lm <- lm(satisfaction ~ attractiveness_cent*spouse, data = mcnulty_tib)
broom::glance(satis_lm) %>% 
    knitr::kable(digits = 3)
```



| r.squared| adj.r.squared| sigma| statistic| p.value| df|   logLik|     AIC|     BIC| deviance| df.residual| nobs|
|---------:|-------------:|-----:|---------:|-------:|--:|--------:|-------:|-------:|--------:|-----------:|----:|
|     0.028|          0.01| 4.444|     1.547|   0.204|  3| -475.297| 960.593| 976.092| 3159.877|         160|  164|

```r
broom::tidy(satis_lm, conf.int = TRUE) %>% 
    knitr::kable(digits = 3)
```



|term                           | estimate| std.error| statistic| p.value| conf.low| conf.high|
|:------------------------------|--------:|---------:|---------:|-------:|--------:|---------:|
|(Intercept)                    |   33.728|     0.491|    68.723|   0.000|   32.759|    34.697|
|attractiveness_cent            |   -0.884|     0.441|    -2.003|   0.047|   -1.755|    -0.012|
|spouseWife                     |   -0.024|     0.694|    -0.034|   0.973|   -1.394|     1.347|
|attractiveness_cent:spouseWife |    0.547|     0.613|     0.892|   0.374|   -0.664|     1.757|

Fit a robust model:


```r
parameters::model_parameters(satis_lm, robust = TRUE, vcov.type = "HC4") %>% 
    knitr::kable(digits = 3)
```



|Parameter                      | Coefficient|    SE| CI_low| CI_high|      t| df_error|     p|
|:------------------------------|-----------:|-----:|------:|-------:|------:|--------:|-----:|
|(Intercept)                    |      33.728| 0.409| 32.919|  34.536| 82.403|      160| 0.000|
|attractiveness_cent            |      -0.884| 0.383| -1.640|  -0.128| -2.309|      160| 0.022|
|spouseWife                     |      -0.024| 0.702| -1.411|   1.363| -0.034|      160| 0.973|
|attractiveness_cent:spouseWife |       0.547| 0.577| -0.593|   1.687|  0.947|      160| 0.345|

Moderation is shown up by a significant interaction effect, and in this case the interaction is not significant, *b* = 0.547, 95% CI [$ -0.59 $, $ 1.69 $], *t* = 0.95, *p* = 0.345, indicating that the relationship between attractiveness and relationship satisfaction is not significantly moderated by spouse.

## Task 11.4

> In this chapter we tested a mediation model of infidelity for Lambert et al.’s data. Repeat this analysis but using **hook_ups** as the measure of infidelity.

### Load the data


```r
infidelity_tib <- readr::read_csv("../data/lambert_2012.csv")
```

Alternative, load the data directly from the `discovr` package:


```r
infidelity_tib <- discovr::lambert_2012
```

### Fit the model


```r
hookup_mod <- 'hook_ups ~ c*ln_porn + b*commit
                   commit ~ a*ln_porn

                   indirect_effect := a*b
                   total_effect := c + (a*b)
                   '

hookup_fit <- lavaan::sem(hookup_mod, data = infidelity_tib, missing = "FIML", estimator = "MLR")

broom::glance(hookup_fit) %>% 
    knitr::kable(digits = 3)
```



| agfi|      AIC|      BIC| cfi| chisq| npar| rmsea| rmsea.conf.high| srmr| tli|converged |estimator | ngroups|missing_method | nobs| norig| nexcluded|
|----:|--------:|--------:|---:|-----:|----:|-----:|---------------:|----:|---:|:---------|:---------|-------:|:--------------|----:|-----:|---------:|
|    1| 1389.512| 1413.876|   1|     0|    7|     0|               0|    0|   1|TRUE      |ML        |       1|ml             |  240|   240|         0|

```r

broom::tidy(hookup_fit, conf.int = TRUE) %>% 
    knitr::kable(digits = 3)
```



|term                    |op |label           | estimate| std.error| statistic| p.value| conf.low| conf.high| std.lv| std.all| std.nox|
|:-----------------------|:--|:---------------|--------:|---------:|---------:|-------:|--------:|---------:|------:|-------:|-------:|
|hook_ups ~ ln_porn      |~  |c               |    1.288|     0.516|     2.497|   0.013|    0.277|     2.299|  1.288|   0.187|   0.843|
|hook_ups ~ commit       |~  |b               |   -0.620|     0.131|    -4.716|   0.000|   -0.877|    -0.362| -0.620|  -0.298|  -0.298|
|commit ~ ln_porn        |~  |a               |   -0.471|     0.229|    -2.056|   0.040|   -0.919|    -0.022| -0.471|  -0.142|  -0.639|
|hook_ups ~~ hook_ups    |~~ |                |    2.009|     0.404|     4.968|   0.000|    1.217|     2.802|  2.009|   0.860|   0.860|
|commit ~~ commit        |~~ |                |    0.531|     0.050|    10.665|   0.000|    0.433|     0.628|  0.531|   0.980|   0.980|
|ln_porn ~~ ln_porn      |~~ |                |    0.049|     0.000|        NA|      NA|    0.049|     0.049|  0.049|   1.000|   0.049|
|hook_ups ~1             |~1 |                |    3.231|     0.597|     5.409|   0.000|    2.061|     4.402|  3.231|   2.114|   2.114|
|commit ~1               |~1 |                |    4.203|     0.053|    79.576|   0.000|    4.100|     4.307|  4.203|   5.711|   5.711|
|ln_porn ~1              |~1 |                |    0.126|     0.000|        NA|      NA|    0.126|     0.126|  0.126|   0.567|   0.126|
|indirect_effect := a*b  |:= |indirect_effect |    0.292|     0.153|     1.911|   0.056|   -0.007|     0.591|  0.292|   0.042|   0.191|
|total_effect := c+(a*b) |:= |total_effect    |    1.580|     0.547|     2.888|   0.004|    0.508|     2.652|  1.580|   0.229|   1.034|

Is there evidence for mediation?

* Pornography consumption significantly predicts hook-ups, *b* = 1.29, 95% CI [0.28, 2.30], *t* = 2.50, *p* = 0.013. As pornography consumption increases, the number of hook-ups increases also.
* Pornography consumption significantly predicts relationship commitment, *b* = $ -0.47$, 95% CI [$ -0.92 $, $ -0.02 $], *t* = $ -2.06 $, *p* = .04. As pornography consumption increases commitment declines.
* Relationship commitment significantly predicts hook-ups, *b* = $ -0.62$, 95% CI [$ -0.88 $, $ -0.36 $], *t* = 4.97, *p* < .001. As relationship commitment increases the number of hook-ups decreases.
* The indirect effect of pornography consumption on hook_ups through relationship commitment is not quite significant, *b* = $ 0.29$, 95% CI [$ -0.01 $, $ 0.59 $], *t* = 1.91, *p* = .056.

As such, there is not significant mediation (although there nearly is ...).

## Task 11.5

> Tablets like the iPad are very popular. A company owner was interested in how to make his brand of tablets more desirable. He collected data on how cool people perceived a product’s advertising to be (**advert_cool**), how cool they thought the product was (**product_cool**), and how desirable they found the product (**desirability**). Test his theory that the relationship between cool advertising and product desirability is mediated by how cool people think the product is (**tablets.csv**). Am I showing my age by using the word ‘cool’?

### Load the data


```r
tablet_tib <- readr::read_csv("../data/tablets.csv")
```

Alternative, load the data directly from the `discovr` package:


```r
tablet_tib <- discovr::tablets
```


### Fit the model


```r
tablet_mod <- 'desirability ~ c*advert_cool + b*product_cool
                   product_cool ~ a*advert_cool

                   indirect_effect := a*b
                   total_effect := c + (a*b)
                   '

tablet_fit <- lavaan::sem(tablet_mod, data = tablet_tib, estimator = "MLR")

broom::glance(tablet_fit) %>% 
    knitr::kable(digits = 3)
```



| agfi|      AIC|      BIC| cfi| chisq| npar| rmsea| rmsea.conf.high| srmr| tli|converged |estimator | ngroups|missing_method | nobs| norig| nexcluded|
|----:|--------:|--------:|---:|-----:|----:|-----:|---------------:|----:|---:|:---------|:---------|-------:|:--------------|----:|-----:|---------:|
|    1| 1056.814| 1074.217|   1|     0|    5|     0|               0|    0|   1|TRUE      |ML        |       1|listwise       |  240|   240|         0|

```r

broom::tidy(tablet_fit, conf.int = TRUE) %>% 
    knitr::kable(digits = 3)
```



|term                         |op |label           | estimate| std.error| statistic| p.value| conf.low| conf.high| std.lv| std.all| std.nox|
|:----------------------------|:--|:---------------|--------:|---------:|---------:|-------:|--------:|---------:|------:|-------:|-------:|
|desirability ~ advert_cool   |~  |c               |    0.200|     0.064|     3.114|   0.002|    0.074|     0.326|  0.200|   0.207|   0.267|
|desirability ~ product_cool  |~  |b               |    0.232|     0.059|     3.961|   0.000|    0.117|     0.346|  0.232|   0.229|   0.229|
|product_cool ~ advert_cool   |~  |a               |    0.152|     0.062|     2.429|   0.015|    0.029|     0.274|  0.152|   0.159|   0.205|
|desirability ~~ desirability |~~ |                |    0.502|     0.055|     9.155|   0.000|    0.395|     0.610|  0.502|   0.890|   0.890|
|product_cool ~~ product_cool |~~ |                |    0.535|     0.042|    12.704|   0.000|    0.453|     0.618|  0.535|   0.975|   0.975|
|advert_cool ~~ advert_cool   |~~ |                |    0.605|     0.000|        NA|      NA|    0.605|     0.605|  0.605|   1.000|   0.605|
|indirect_effect := a*b       |:= |indirect_effect |    0.035|     0.017|     2.031|   0.042|    0.001|     0.069|  0.035|   0.036|   0.047|
|total_effect := c+(a*b)      |:= |total_effect    |    0.235|     0.064|     3.684|   0.000|    0.110|     0.361|  0.235|   0.244|   0.313|

* Advert coolness significantly predicts desirability, *b* = 0.20, 95% CI [0.07, 0.33], *t* = 3.11, *p* = 0.002. As advert coolness increases, desirability increases also.
* Advert coolness significantly predicts perceptions of a product, *b* = 0.15, 95% CI [0.02, 0.03], *t* = 2.43, *p* = 0.015. As advert coolness increases product coolness incraeses also.
* Product coolness significantly predicts desirability, *b* = 0.23, 95% CI [0.12, 0.35], *t* = 3.96, *p* < 0.001. Products perceived to be more cool are more desitable.
* The indirect effect of advert coolness on desirability through product coolness is significant, *b* = 0.04, 95% CI [0.00, 0.07], *t* = 2.03, *p* = 0.042. As such, there is  significant mediation.

Ypu could report this as:

* There was a significant indirect effect of how cool people think a products’ advertising is on the desirability of the product though how cool they think the product is, *b* = 0.04, 95% CI [0.00, 0.07], *t* = 2.03, *p* = 0.042. This represents a relatively small effect.
