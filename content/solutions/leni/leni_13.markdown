---
title: Labcoat Leni solutions Chapter 13
linktitle: Leni Chapter 13
toc: true
type: docs
date: "2021-06-23T00:00:00Z"
draft: false
menu:
  leni:
    parent: Labcoat Leni
    weight: 13

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 13

---

<img src="/img/leni_banner.png" alt = "Labcoat Leni character from Discovering Statistics using R and RStudio" width="600">

{{% alert note %}}

<p>This document contains abridged sections from <em>Discovering Statistics Using R and RStudio</em> by <a href="/index.html#about">Andy Field</a> so there are some copyright considerations. You can use this material for teaching and non-profit activities but please do not meddle with it or claim it as your own work. See the full license terms at the bottom of the page.</p>

{{% /alert %}}

## Don’t forget your toothbrush

### Load the data

To load the data from the CSV file (assuming you have set up a project folder as suggested in the book) and set the factor and its levels:

``` r
davey_tib <- readr::read_csv("../data/davey_2003.csv") %>% 
  dplyr::mutate(
    stop_rule = forcats::as_factor(stop_rule),
    mood = forcats::as_factor(mood) %>% forcats::fct_relevel(., "Neutral")
  )
```

Alternative, load the data directly from the `discovr` package:

``` r
davey_tib <- discovr::davey_2003
```

### Plot the data

``` r
ggplot2::ggplot(davey_tib, aes(x = mood, y = checks, colour = stop_rule)) +
  geom_violin(alpha = 0.5) +
  stat_summary(fun.data = "mean_cl_normal", position = position_dodge(width = 0.9)) +
  scale_y_continuous(breaks = seq(0, 40, 5)) +
  labs(y = "Checks (out of 10)", x = "Mood induction", colour = "Stop rule") +
  discovr::scale_colour_ssoass() +
  theme_minimal()
```

<img src="/solutions/leni/leni_13_files/figure-html/unnamed-chunk-6-1.png" width="672" />

The plot shows that when in a negative mood people performed more checks when using an *as many as can* stop rule than when using a *feel like continuing* stop rule. In a positive mood the opposite was true, and in neutral moods the number of checks was very similar in the two stop rule conditions.

## Fit the model

### Fitting the model using `afex::aov_4()`

``` r
davey_afx <- afex::aov_4(checks ~ mood*stop_rule + (1|id), data = davey_tib)
davey_afx
```

    ## Anova Table (Type 3 tests)
    ## 
    ## Response: checks
    ##           Effect    df   MSE       F  ges p.value
    ## 1           mood 2, 54 24.97    0.68 .025    .509
    ## 2      stop_rule 1, 54 24.97    2.09 .037    .154
    ## 3 mood:stop_rule 2, 54 24.97 6.35 ** .190    .003
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '+' 0.1 ' ' 1

## Fitting the model using `lm()`

Set contrasts for **stop\_rule**:

``` r
many_vs_feel <- c(-0.5, 0.5)
contrasts(davey_tib$stop_rule) <- many_vs_feel
```

Set contrasts for **mood**. What we really want here is a contrast that compares positive mood to neutral and negative mood to neutral, but this contrast isn’t orthogonal and we need orthogonal contrasts for the type III sums of squares. Instead we’ll use the build in `contr.sum`, which will give us `sum to zero` contrasts, which are orthogonal.

``` r
contrasts(davey_tib$mood) <- contr.sum(3)
```

Fit the model and print Type III sums of squares:

``` r
davey_lm <- lm(checks ~ mood*stop_rule, data = davey_tib)
car::Anova(davey_lm, type = 3)
```

    ## Anova Table (Type III tests)
    ## 
    ## Response: checks
    ##                Sum Sq Df  F value    Pr(>F)    
    ## (Intercept)    6448.1  1 258.1904 < 2.2e-16 ***
    ## mood             34.1  2   0.6834  0.509222    
    ## stop_rule        52.3  1   2.0928  0.153771    
    ## mood:stop_rule  316.9  2   6.3452  0.003349 ** 
    ## Residuals      1348.6 54                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

The resulting output can be interpreted as follows.

-   The main effect of mood was not significant, *F*(2, 54) = 0.68, *p* = .51, indicating that the number of checks (when we ignore the stop rule adopted) was roughly the same regardless of whether the person was in a positive, negative or neutral mood.
-   Similarly, the main effect of stop rule was not significant, *F*(1, 54) = 2.09, *p* = .15, indicating that the number of checks (when we ignore the mood induced) was roughly the same regardless of whether the person used an ‘as many as can’ or a ‘feel like continuing’ stop rule.
-   The mood × stop rule interaction was significant, *F*(2, 54) = 6.35, *p* = .003, indicating that the mood combined with the stop rule significantly affected checking behaviour. Looking at the graph, a negative mood in combination with an ‘as many as can’ stop rule increased checking, as did the combination of a ‘feel like continuing’ stop rule and a positive mood, just as Davey et al. predicted.
