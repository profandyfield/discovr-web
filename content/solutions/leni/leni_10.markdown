---
title: Labcoat Leni solutions Chapter 10
linktitle: Leni Chapter 10
toc: true
type: docs
date: "2020-07-07T00:00:00Z"
draft: false
menu:
  leni:
    parent: Labcoat Leni
    weight: 10

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 10

---

<!--html_preserve--><img src="/img/leni_banner.png" alt = "Labcoat Leni character from Discovering Statistics using R and RStudio" width="600"><!--/html_preserve-->

{{% alert note %}}

<!--html_preserve--><p>This document contains abridged sections from <em>Discovering Statistics Using R and RStudio</em> by <a href="/index.html#about">Andy Field</a> so there are some copyright considerations. You can use this material for teaching and non-profit activities but please do not meddle with it or claim it as your own work. See the full license terms at the bottom of the page.</p><!--/html_preserve-->

{{% /alert %}}



## Load the file


```r
massar_tib <- readr::read_csv("../data/massar_2012.csv")
```

Alternative, load the data directly from the `discovr` package:


```r
massar_tib <- discovr::massar_2012
```

## Solution using Baron and Kenny's method

Baron and Kenny suggested that mediation is tested through three linear models:

1. A linear model predicting the outcome (**gossip**) from the predictor variable (**age**).
2. A linear model predicting the mediator (**mate_value**) from the predictor variable (**age**).
3. A linear model predicting the outcome (**gossip**) from both the predictor variable (**age**) and the mediator (**mate_value**).

These models test the four conditions of mediation: (1) the predictor variable (**age**) must significantly predict the outcome variable (**gossip**) in model 1; (2) the predictor variable (**age**) must significantly predict the mediator (**mate_value**) in model 2; (3) the mediator (**mate_value**) must significantly predict the outcome (**gossip**) variable in model 3; and (4) the predictor variable (**age**) must predict the outcome variable (**gossip**) less strongly in model 3 than in model 1.

The paper reports standardized betas so I've used the `parameters` package to summarize the models using standardized coefficients.

### Model 1


```r
m1 <- lm(gossip ~ age, data = massar_tib)
```


```r
parameters::model_parameters(m1, standardize = "refit") %>% 
  knitr::kable(digits = 2)
```



|Parameter   | Coefficient|   SE| CI_low| CI_high|     t| df_error|    p|
|:-----------|-----------:|----:|------:|-------:|-----:|--------:|----:|
|(Intercept) |        0.00| 0.11|  -0.21|    0.21|  0.00|       80| 1.00|
|age         |       -0.28| 0.11|  -0.49|   -0.06| -2.59|       80| 0.01|

Model 1 indicates that the first condition of mediation was met, in that participant age was a significant predictor of the tendency to gossip, $ t\text{(80)} = -2.59 $, $ p = .011 $.


```r
m2 <- lm(mate_value ~ age, data = massar_tib)
```


```r
parameters::model_parameters(m2, standardize = "refit") %>% 
  knitr::kable(digits = 2)
```



|Parameter   | Coefficient|  SE| CI_low| CI_high|     t| df_error|  p|
|:-----------|-----------:|---:|------:|-------:|-----:|--------:|--:|
|(Intercept) |        0.00| 0.1|  -0.21|    0.21|  0.00|       79|  1|
|age         |       -0.38| 0.1|  -0.59|   -0.17| -3.67|       79|  0|

Model 2 shows that the second condition of mediation was met: participant age was a significant predictor of mate value, $ t\text{(79)} = -3.67 $, $ p < .001 $.


```r
m3 <- lm(gossip ~ age + mate_value, data = massar_tib)
```


```r
parameters::model_parameters(m3, standardize = "refit") %>% 
  knitr::kable(digits = 2)
```



|Parameter   | Coefficient|   SE| CI_low| CI_high|     t| df_error|    p|
|:-----------|-----------:|----:|------:|-------:|-----:|--------:|----:|
|(Intercept) |        0.00| 0.10|  -0.20|    0.20|  0.00|       78| 1.00|
|age         |       -0.14| 0.11|  -0.35|    0.08| -1.28|       78| 0.21|
|mate_value  |        0.39| 0.11|   0.17|    0.61|  3.59|       78| 0.00|

Model 3 shows that the third condition of mediation has been met: mate value significantly predicted the tendency to gossip while adjusting for participant age, $ t\text{(78)} = 3.59 $, $ p < .001 $. The fourth condition of mediation has also been met: the parameter estimate  between participant age and tendency to gossip decreased substantially when adjusting for mate value, in fact it is no longer significant, $ t\text{(78)} = -1.28$, $p  = 0.21 $. Therefore, we can conclude that the author's prediction is supported, and the relationship between participant age and tendency to gossip is mediated by mate value.

{{< figure library="true" src="ds_c10_leni_fig_01.png" title="Diagram of the mediation model, taken from Massar et al. (2012)" lightbox="true" >}}

## Solution using `lavaan`


```r
massar_mod <- 'gossip ~ c*age + b*mate_value
                   mate_value ~ a*age

                   indirect_effect := a*b
                   total_effect := c + (a*b)
                   '

massar_fit <- lavaan::sem(massar_mod, data = massar_tib, missing = "FIML", estimator = "MLR")
```


```r
broom::tidy(massar_fit, conf.int = TRUE) %>% 
  knitr::kable(digits = 2)
```



|term                     |op |label           | estimate| std.error| statistic| p.value| conf.low| conf.high| std.lv| std.all| std.nox|
|:------------------------|:--|:---------------|--------:|---------:|---------:|-------:|--------:|---------:|------:|-------:|-------:|
|gossip ~ age             |~  |c               |    -0.01|      0.01|     -1.36|    0.17|    -0.03|      0.00|  -0.01|   -0.13|   -0.01|
|gossip ~ mate_value      |~  |b               |     0.45|      0.14|      3.26|    0.00|     0.18|      0.72|   0.45|    0.39|    0.39|
|mate_value ~ age         |~  |a               |    -0.03|      0.01|     -3.64|    0.00|    -0.04|     -0.01|  -0.03|   -0.38|   -0.03|
|gossip ~~ gossip         |~~ |                |     0.77|      0.09|      8.64|    0.00|     0.59|      0.94|   0.77|    0.79|    0.79|
|mate_value ~~ mate_value |~~ |                |     0.62|      0.10|      6.17|    0.00|     0.42|      0.81|   0.62|    0.86|    0.86|
|age ~~ age               |~~ |                |   149.25|      0.00|        NA|      NA|   149.25|    149.25| 149.25|    1.00|  149.25|
|gossip ~1                |~1 |                |     1.18|      0.53|      2.23|    0.03|     0.14|      2.22|   1.18|    1.21|    1.21|
|mate_value ~1            |~1 |                |     3.79|      0.23|     16.28|    0.00|     3.33|      4.25|   3.79|    4.47|    4.47|
|age ~1                   |~1 |                |    30.37|      0.00|        NA|      NA|    30.37|     30.37|  30.37|    2.49|   30.37|
|indirect_effect := a*b   |:= |indirect_effect |    -0.01|      0.01|     -2.21|    0.03|    -0.02|      0.00|  -0.01|   -0.15|   -0.01|
|total_effect := c+(a*b)  |:= |total_effect    |    -0.02|      0.01|     -2.89|    0.00|    -0.04|     -0.01|  -0.02|   -0.28|   -0.02|

The output shows that age significantly predicts mate value, $ b = -0.03\text{, } t = -3.64\text{, } p < .001 $. We can see that while age does not significantly predict tendency to gossip with mate value in the model, $ b = -0.01\text{, } t = -1.36\text{, } p = .17 $, mate value does significantly predict tendency to gossip, $ b = 0.45\text{, } t = 3.26\text{, } p = .0001 $. The negative *b* for age tells us that as age increases, tendency to gossip declines (and vice versa), but the positive *b* for mate value indicates that as mate value increases, tendency to gossip increases also. These relationships are in the predicted direction.

The total effect shows that when mate value is not in the model, age significantly predicts tendency to gossip, $ b = -0.02\text{, } t = -2.89\text{, } p = .004 $. Finally, the indirect effect of age on gossip is significant, $ b = -0.012\text{, 95% CI} [-0.022, -0.0001] \text{, } t = -2.21\text{, } p = .027 $. Put another way, mate value is a significant mediator of the relationship between age and tendency to gossip.
