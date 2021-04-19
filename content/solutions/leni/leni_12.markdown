---
title: Labcoat Leni solutions Chapter 12
linktitle: Leni Chapter 12
toc: true
type: docs
date: "2020-08-03T00:00:00Z"
draft: false
menu:
  leni:
    parent: Labcoat Leni
    weight: 12

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 12

---

<img src="/img/leni_banner.png" alt = "Labcoat Leni character from Discovering Statistics using R and RStudio" width="600">

{{% alert note %}}

<p>This document contains abridged sections from <em>Discovering Statistics Using R and RStudio</em> by <a href="/index.html#about">Andy Field</a> so there are some copyright considerations. You can use this material for teaching and non-profit activities but please do not meddle with it or claim it as your own work. See the full license terms at the bottom of the page.</p>

{{% /alert %}}

## Space invaders

### Load the data

To load the data from the CSV file (assuming you have set up a project folder as suggested in the book) and set the factor and its levels:

``` r
muris_tib <- readr::read_csv("../data/muris_2008.csv") %>% 
  dplyr::mutate(
    gender = forcats::as_factor(gender),
    training = forcats::as_factor(training)
  )
```

Alternative, load the data directly from the `discovr` package:

``` r
muris_tib <- discovr::muris_2008
```

### Fit the model

In the chapter we looked at how to select contrasts, but because our main predictor variable (the type of training) has only two levels (positive or negative) we don’t need contrasts: the main effect of this variable can only reflect differences between the two types of training. We can, therefore, use the default behaviour of {{&lt; icon name=“r-project” pack=“fab” &gt;}}.

``` r
muris_lm <- lm(int_bias ~ training + gender + age + scared, data = muris_tib)
car::Anova(muris_lm, type = 3)
```

    ## Anova Table (Type III tests)
    ## 
    ## Response: int_bias
    ##             Sum Sq Df F value    Pr(>F)    
    ## (Intercept)   7953  1  4.8245 0.0316298 *  
    ## training     22129  1 13.4248 0.0005010 ***
    ## gender       11083  1  6.7236 0.0117414 *  
    ## age           2643  1  1.6036 0.2099092    
    ## scared       26400  1 16.0157 0.0001636 ***
    ## Residuals   107147 65                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

We can see that even after adjusting for the effects of age, gender and natural anxiety, the training had a significant effect on the subsequent bias score, *F*(1, 65) = 13.43, *p* &lt; .001. In terms of the covariates, age did not have a significant influence on the acquisition of interpretational biases. However, anxiety (scared) and gender did.

This code gives us the adjusted means:

``` r
modelbased::estimate_means(muris_lm, fixed = c("age", "gender", "scared")) %>% 
  knitr::kable(digits = 2)
```

| training          | gender |   age | scared |   Mean |   SE | CI\_low | CI\_high |
|:------------------|:-------|------:|-------:|-------:|-----:|--------:|---------:|
| Positive training | Boy    | 10.03 |   17.7 |  95.15 | 8.21 |   78.75 |   111.55 |
| Negative training | Boy    | 10.03 |   17.7 | 131.18 | 9.06 |  113.09 |   149.28 |

The adjusted means tell us that interpretational biases were stronger (higher) after negative training (adjusting for age, gender and SCARED). This result is as expected. It seems then that giving children feedback that tells them to interpret ambiguous situations negatively induces an interpretational bias that persists into everyday situations, which is an important step towards understanding how these biases develop.

To interpret the covariates, let’s look at the model parameters:

``` r
broom::tidy(muris_lm, conf.int = TRUE) %>% 
  knitr::kable(digits = 2)
```

| term                      | estimate | std.error | statistic | p.value | conf.low | conf.high |
|:--------------------------|---------:|----------:|----------:|--------:|---------:|----------:|
| (Intercept)               |   132.61 |     60.37 |      2.20 |    0.03 |    12.04 |    253.19 |
| trainingNegative training |    36.03 |      9.83 |      3.66 |    0.00 |    16.39 |     55.68 |
| genderGirl                |    26.12 |     10.07 |      2.59 |    0.01 |     6.00 |     46.24 |
| age                       |    -7.28 |      5.75 |     -1.27 |    0.21 |   -18.76 |      4.20 |
| scared                    |     2.01 |      0.50 |      4.00 |    0.00 |     1.01 |      3.01 |

For anxiety (**scared**), *b* = 2.01, which reflects a positive relationship. Therefore, as anxiety increases, the interpretational bias increases also (this is what you would expect, because anxious children would be more likely to naturally interpret ambiguous situations in a negative way). For **genderGirl**, *b* = 26.12, which again is positive, but to interpret this we need to think about how the children were coded in the data editor. The fact that the effect is named **genderGirl** tells us that this is the effect of girls relative to boys (i.e. boys are the reference category). Therefore, as a child ‘changes’ (not literally) from a boy to a girl, their interpretation biases increase. In other words, girls show a stronger natural tendency to interpret ambiguous situations negatively. Remember that **age** didn’t significantly affect interpretation biases.

One important thing to remember is that although anxiety and gender naturally affected whether children interpreted ambiguous situations negatively, the training (the experiences on the alien planet) had an effect adjusting for these natural tendencies (in other words, the effects of training cannot be explained by gender or natural anxiety levels in the sample).

Have a look at the original article to see how Muris et al. reported the results of this analysis – this can help you to see how you can report your own data from an ANCOVA. (One bit of good practice that you should note is that they report effect sizes from their analysis – as you will see from the book chapter, this is an excellent thing to do.)
