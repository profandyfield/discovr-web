---
title: Smart Alex solutions Chapter 18
linktitle: Alex Chapter 18
toc: true
type: docs
date: "2021-04-19T00:00:00Z"
draft: false
menu:
  alex:
    parent: Smart Alex
    weight: 18

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 18

---

<img src="/img/dsus_smart_alex_banner.png" alt = "Smart Alex charatcer from Discovering Statistics using R and RStudio" width="600">

{{% alert note %}}

<p>This document contains abridged sections from <em>Discovering Statistics Using R and RStudio</em> by <a href="/index.html#about">Andy Field</a> so there are some copyright considerations. You can use this material for teaching and non-profit activities but please do not meddle with it or claim it as your own work. See the full license terms at the bottom of the page.</p>

{{% /alert %}}

## Task 18.1

> Rerun the analysis in this chapter using principal component analysis and compare the results to those in the chapter.

### Load the data

To load the data from the CSV file (assuming you have set up a project folder as suggested in the book):

``` r
raq_tib <- here::here("data/raq.csv") %>%
  readr::read_csv()
```

Alternative, load the data directly from the `discovr` package:

``` r
raq_tib <- discovr::raq
```

### Fit the model

All of the descriptives, correlation matrices, KMO tests and so on are unaffected by our choice of principal components as the method of dimension reduction. Also in the book chapter we did parallel analysis based on components and this suggested 4 components (as did the parallel analysis based on components). So, follow everything in the book (code and interpretation) up to the point at which we for the main model.

As a reminder, we set up the correlation matrix to be based on polychoric correlations

``` r
# create tibble that contains only the questionnaire items
raq_items_tib <- raq_tib %>% 
  dplyr::select(-id)
# get the polychoric correlation object
raq_poly <- psych::polychoric(raq_items_tib)
# store the polychoric correlation matrix
raq_cor <- raq_poly$rho
```

Things start to get different at the point of fitting the model. We can use the same code as the book chapter except that we use the `pca()` (or `principal()` if you prefer) function instead of `fa()` and we need to remove `scores = "tenBerge"` because for PCA there is only a single method for computing component scores (and this is used by default). We also need to add `rotate = "oblimin"` because for PCA the default is to use an orthogonal rotation (varimax). I’ve also changed the name of the object to store this in to `raq_pca` to reflect the fact we’ve done PCA and not component analysis.

From the raw data:

``` r
raq_pca <- psych::pca(raq_items_tib,
                    nfactors = 4,
                    cor = "poly",
                    rotate = "oblimin"
                    )
```

From the correlation matrix:

``` r
raq_pca <- psych::pca(raq_cor,
                    n.obs = 2571,
                    nfactors = 4,
                    rotate = "oblimin"
                    )
```

To see the output:

``` r
raq_pca
```

Note that the components are labelled `TC1` to `TC4` (unlike for the component analysis in the book where the labels were `MR1` etc.). We are given some information about how much variance each component accounts for.

    ##                        TC1  TC2  TC3  TC4
    ## SS loadings           3.67 2.77 2.60 2.32
    ## Proportion Var        0.16 0.12 0.11 0.10
    ## Cumulative Var        0.16 0.28 0.39 0.49
    ## Proportion Explained  0.32 0.24 0.23 0.20
    ## Cumulative Proportion 0.32 0.57 0.80 1.00

We see, for example, from `Proportion Var` that **TC1** accounts for 0.16 of the overall variance (16%) and **TC2** accounts for 0.12 of the variance (12%) and so on. The `Cumulative Var` is the proportion of variance explained cumulatively by the components. So, cumulatively, **TC1** accounts for 0.16 of the overall variance (16%) and **TC1** and **TC2** together account for 0.16 + 0.12 = 0.28 of the variance (28%). Importantly, we can see that all four components in combination explain 0.49 of the overall variance (49%).

The **Proportion Explained** is the proportion of the explained variance, that is explained by a component. So, of the 49% of variance accounted for, 0.32 (32%) is attributable to **TC1**, 0.25 (25%) to **TC2**, 0.24 (24%) to **TC3** and 0.19 (19%) to **TC4**.

    ## 
    ## Factor analysis with Call: principal(r = r, nfactors = nfactors, residuals = residuals, 
    ##     rotate = rotate, n.obs = n.obs, covar = covar, scores = scores, 
    ##     missing = missing, impute = impute, oblique.scores = oblique.scores, 
    ##     method = method, use = use, cor = cor, correct = 0.5, weight = NULL)
    ## 
    ## Test of the hypothesis that 4 factors are sufficient.
    ## The degrees of freedom for the model is 167  and the objective function was  0.63 
    ## The number of observations was  2571  with Chi Square =  1614.3  with prob <  4.9e-235 
    ## 
    ## The root mean square of the residuals (RMSA) is  0.05 
    ## 
    ##  With component correlations of 
    ##      TC1  TC2  TC3  TC4
    ## TC1 1.00 0.34 0.38 0.41
    ## TC2 0.34 1.00 0.21 0.25
    ## TC3 0.38 0.21 1.00 0.41
    ## TC4 0.41 0.25 0.41 1.00

The correlations between components are also displayed. These are all non-zero indicating that components are correlated (and oblique rotation was appropriate). It also tells us the degree to which components are correlated. All of the components positively, and fairly strongly, correlate with each other. In other words, the latent constructs represented by the components are related.

In terms of fit

-   The chi-square statistic is \$ \\chi^2 = \$ 1614.3, *p* &lt; 0.001. This is consistent with when we ran the analysis as factor analysis in the chapter.
-   The RMSR is 0.05.

Let’s look at the loadings (I’ve suppressed values below 0.2 and sorted).

``` r
parameters::model_parameters(raq_pca, threshold = 0.2, sort = TRUE) %>% 
  kableExtra::kable(digits = 2)
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Variable
</th>
<th style="text-align:right;">
TC1
</th>
<th style="text-align:right;">
TC2
</th>
<th style="text-align:right;">
TC3
</th>
<th style="text-align:right;">
TC4
</th>
<th style="text-align:right;">
Complexity
</th>
<th style="text-align:right;">
Uniqueness
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
raq\_06
</td>
<td style="text-align:right;">
0.80
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.02
</td>
<td style="text-align:right;">
0.29
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_18
</td>
<td style="text-align:right;">
0.69
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.03
</td>
<td style="text-align:right;">
0.49
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_13
</td>
<td style="text-align:right;">
0.68
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.02
</td>
<td style="text-align:right;">
0.56
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_07
</td>
<td style="text-align:right;">
0.65
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.01
</td>
<td style="text-align:right;">
0.56
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_10
</td>
<td style="text-align:right;">
0.63
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.09
</td>
<td style="text-align:right;">
0.63
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_15
</td>
<td style="text-align:right;">
0.58
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.02
</td>
<td style="text-align:right;">
0.63
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_14
</td>
<td style="text-align:right;">
0.53
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.03
</td>
<td style="text-align:right;">
0.70
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_05
</td>
<td style="text-align:right;">
0.50
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.86
</td>
<td style="text-align:right;">
0.42
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_23
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.86
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.03
</td>
<td style="text-align:right;">
0.31
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_09
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.86
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.03
</td>
<td style="text-align:right;">
0.30
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_19
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
0.65
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.27
</td>
<td style="text-align:right;">
0.41
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_22
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.62
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.16
</td>
<td style="text-align:right;">
0.48
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_02
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
0.59
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.36
</td>
<td style="text-align:right;">
0.52
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_16
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.63
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.02
</td>
<td style="text-align:right;">
0.63
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_04
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.62
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.03
</td>
<td style="text-align:right;">
0.58
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_21
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.59
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.13
</td>
<td style="text-align:right;">
0.53
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_12
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.58
</td>
<td style="text-align:right;">
-0.21
</td>
<td style="text-align:right;">
1.26
</td>
<td style="text-align:right;">
0.72
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_20
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.56
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.09
</td>
<td style="text-align:right;">
0.60
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_03
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
-0.54
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.01
</td>
<td style="text-align:right;">
0.70
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_01
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.51
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.06
</td>
<td style="text-align:right;">
0.72
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_08
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.84
</td>
<td style="text-align:right;">
1.01
</td>
<td style="text-align:right;">
0.24
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_11
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.83
</td>
<td style="text-align:right;">
1.00
</td>
<td style="text-align:right;">
0.30
</td>
</tr>
<tr>
<td style="text-align:left;">
raq\_17
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.83
</td>
<td style="text-align:right;">
1.00
</td>
<td style="text-align:right;">
0.33
</td>
</tr>
</tbody>
</table>

The clusters of items match the book chapter where we used factor analysis instead of PCA. The questions that load highly on **TC1** seem to be items that relate to **Fear of computers**:

-   **raq\_05**: *I don’t understand statistics*
-   **raq\_06**: *I have little experience of computers*
-   **raq\_07**: *All computers hate me*
-   **raq\_10**: *Computers are useful only for playing games*
-   **raq\_13**: *I worry that I will cause irreparable damage because of my incompetence with computers*
-   **raq\_14**: *Computers have minds of their own and deliberately go wrong whenever I use them*
-   **raq\_15**: *Computers are out to get me*
-   **raq\_18**: *R always crashes when I try to use it*

Note that item 5 also loads highly onto **TC3**.

The questions that load highly on **TC2** seem to be items that relate to **Fear of peer/social evaluation**:

-   **raq\_02**: *My friends will think I’m stupid for not being able to cope with {{&lt; icon name=“r-project” pack=“fab” &gt;}}*
-   **raq\_09**: *My friends are better at statistics than me*
-   **raq\_19**: *Everybody looks at me when I use {{&lt; icon name=“r-project” pack=“fab” &gt;}}*
-   **raq\_22**: *My friends are better at {{&lt; icon name=“r-project” pack=“fab” &gt;}} than I am*
-   **raq\_23**: *If I am good at statistics people will think I am a nerd*

The questions that load highly on **TC3** seem to be items that relate to **Fear of statistics**:

-   **raq\_01**: *Statistics make me cry*
-   **raq\_03**: *Standard deviations excite me*
-   **raq\_04**: *I dream that Pearson is attacking me with correlation coefficients*
-   **raq\_05**: *I don’t understand statistics*
-   **raq\_12**: *People try to tell you that {{&lt; icon name=“r-project” pack=“fab” &gt;}} makes statistics easier to understand but it doesn’t*
-   **raq\_16**: *I weep openly at the mention of central tendency*
-   **raq\_20**: *I can’t sleep for thoughts of eigenvectors*
-   **raq\_21**: *I wake up under my duvet thinking that I am trapped under a normal distribution*

The questions that load highly on **TC4** seem to be items that relate to **Fear of mathematics**:

-   **raq\_08**: *I have never been good at mathematics*
-   **raq\_11**: *I did badly at mathematics at school*
-   **raq\_17**: *I slip into a coma whenever I see an equation*

Basically using PCA hasn’t changed the interpretation.

## Task 18.2

> The University of Sussex constantly seeks to employ the best people possible as lecturers. They wanted to revise the ‘Teaching of Statistics for Scientific Experiments’ (TOSSE) questionnaire, which is based on Bland’s theory that says that good research methods lecturers should have: (1) a profound love of statistics; (2) an enthusiasm for experimental design; (3) a love of teaching; and (4) a complete absence of normal interpersonal skills. These characteristics should be related (i.e., correlated). The University revised this questionnaire to become the ‘Teaching of Statistics for Scientific Experiments – Revised (TOSSE – R; Error! Reference source not found.). They gave this questionnaire to 661 research methods lecturers to see if it supported Bland’s theory. Conduct a factor analysis using maximum likelihood (with appropriate rotation) and interpret the component structure.

### Load the data

To load the data from the CSV file (assuming you have set up a project folder as suggested in the book):

``` r
tosr_tib <- here::here("data/tosser.csv") %>%
  readr::read_csv()
```

Alternative, load the data directly from the `discovr` package:

``` r
tosr_tib <- discovr::tosser
```

### Create correlation matrix

The data file has a variable in it containing participants’ ids. Let’s store a version of the data that only has the item scores.

``` r
tosr_items_tib <- tosr_tib %>% 
  dplyr::select(-id)
```

We can create the correlations between variables by executing (again, items were rated on Likert response scales, so we’ll use polychoric correlations).

``` r
tosr_poly <- psych::polychoric(tosr_items_tib)
tosr_cor <- tosr_poly$rho
```

To get a plot of the correlations we can execute:

``` r
psych::cor.plot(tosr_cor, upper = FALSE)
```

<img src="/solutions/alex/alex_18_files/figure-html/unnamed-chunk-17-1.png" width="672" />

### The Bartlett test

``` r
psych::cortest.bartlett(tosr_cor, n = 661)
```

    ## $chisq
    ## [1] 6392.17
    ## 
    ## $p.value
    ## [1] 0
    ## 
    ## $df
    ## [1] 378

This (basically useless) tests confirms that the correlation matrix is significantly different from an identity matrix (i.e. correlations are non-zero).

Determinant of the correlation matrix:

``` r
det(tosr_cor)
```

    ## [1] 5.345715e-05

The determinant of the correlation matrix was 0.00005345715, which is greater than 0.00001 and, therefore, indicates that multicollinearity is unlikley to be a problem in these data.

### The KMO test

``` r
psych::KMO(tosr_cor)
```

    ## Kaiser-Meyer-Olkin factor adequacy
    ## Call: psych::KMO(r = tosr_cor)
    ## Overall MSA =  0.91
    ## MSA for each item = 
    ## tosr_01 tosr_02 tosr_03 tosr_04 tosr_05 tosr_06 tosr_07 tosr_08 tosr_09 tosr_10 
    ##    0.85    0.93    0.76    0.89    0.86    0.93    0.96    0.87    0.87    0.92 
    ## tosr_11 tosr_12 tosr_13 tosr_14 tosr_15 tosr_16 tosr_17 tosr_18 tosr_19 tosr_20 
    ##    0.96    0.93    0.82    0.85    0.87    0.83    0.83    0.96    0.94    0.95 
    ## tosr_21 tosr_22 tosr_23 tosr_24 tosr_25 tosr_26 tosr_27 tosr_28 
    ##    0.81    0.83    0.91    0.88    0.96    0.94    0.93    0.93

The KMO measure of sampling adequacy is 0.91, which is above Kaiser’s (1974) recommendation of 0.5. This value is also ‘marvellous.’ Individual items KMO values ranged from 0.76 to 0.96. As such, the evidence suggests that the sample size is adequate to yield distinct and reliable factors.

### Distributions for items

``` r
tosr_tidy_tib <- tosr_items_tib %>% 
  tidyr::pivot_longer(
    cols = tosr_01:tosr_28,
    names_to = "Item",
    values_to = "Response"
  ) %>% 
  dplyr::mutate(
    Item = gsub("tosr_", "TOSSER ", Item)
  )

ggplot2::ggplot(tosr_tidy_tib, aes(Response)) +
  geom_histogram(binwidth = 1, fill = "#136CB9", colour = "#136CB9", alpha = 0.5) +
  labs(y = "Frequency") +
  facet_wrap(~ Item, ncol = 6) +
  theme_minimal()
```

<img src="/solutions/alex/alex_18_files/figure-html/unnamed-chunk-22-1.png" width="672" />

### Parallel analysis

``` r
psych::fa.parallel(tosr_cor, fm = "ml", fa = "fa", n.obs = 661)
```

<img src="/solutions/alex/alex_18_files/figure-html/unnamed-chunk-23-1.png" width="672" />

    ## Parallel analysis suggests that the number of factors =  4  and the number of components =  NA

Based on parallel analysis five factors should be extracted.

### Factor analysis

Create the factor analysis object. The question asks us to use maximum likelihood so I have included `fm = "ml"`. We choose an oblique rotation (the default) because the question says that the constructs we’re measuring are related.

``` r
tosr_fa <- psych::fa(tosr_cor,
                    n.obs = 661,
                    fm = "ml",
                    nfactors = 4,
                    scores = "tenBerge"
                    )
```

``` r
summary(tosr_fa)
```

    ## 
    ## Factor analysis with Call: psych::fa(r = tosr_cor, nfactors = 4, n.obs = 661, scores = "tenBerge", 
    ##     fm = "ml")
    ## 
    ## Test of the hypothesis that 4 factors are sufficient.
    ## The degrees of freedom for the model is 272  and the objective function was  0.7 
    ## The number of observations was  661  with Chi Square =  450.06  with prob <  6.1e-11 
    ## 
    ## The root mean square of the residuals (RMSA) is  0.02 
    ## The df corrected root mean square of the residuals is  0.03 
    ## 
    ## Tucker Lewis Index of factoring reliability =  0.959
    ## RMSEA index =  0.031  and the 10 % confidence intervals are  0.026 0.037
    ## BIC =  -1316.24
    ##  With factor correlations of 
    ##       ML1  ML3  ML2   ML4
    ## ML1  1.00 0.08 0.11 -0.39
    ## ML3  0.08 1.00 0.32  0.23
    ## ML2  0.11 0.32 1.00  0.31
    ## ML4 -0.39 0.23 0.31  1.00

In terms of fit

-   The chi-square statistic is \$ \\chi^2 = \$(272) 450.06, *p* &lt; 0.001. This is consistent with when we ran the analysis as factor analysis in the chapter.
-   The Tucker Lewis Index of factoring reliability (TFI) is given as 0.96, which is equal to 0.96.
-   The RMSEA = 0.031 90% CI \[0.026, 0.037\], which is below than 0.05.
-   The RMSR is 0.02, which is smaller than both 0.09 and 0.06.

Remember that we’re looking for a combination of TLI &gt; 0.96 and SRMR (RMSR in the output) &lt; 0.06, and a combination of RMSEA &lt; 0.05 and SRMR &lt; 0.09. With the caveat that universal cut-offs need to be taken with a pinch of salt, it’s reasonable to conclude that the model has good fit.

Inspect the factor loadings:

``` r
parameters::model_parameters(tosr_fa, threshold = 0.2, sort = TRUE) %>% 
  knitr::kable(digits = 2)
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Variable
</th>
<th style="text-align:right;">
ML1
</th>
<th style="text-align:right;">
ML3
</th>
<th style="text-align:right;">
ML2
</th>
<th style="text-align:right;">
ML4
</th>
<th style="text-align:right;">
Complexity
</th>
<th style="text-align:right;">
Uniqueness
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
tosr\_02
</td>
<td style="text-align:right;">
-0.79
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.07
</td>
<td style="text-align:right;">
0.42
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_19
</td>
<td style="text-align:right;">
0.76
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.12
</td>
<td style="text-align:right;">
0.30
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_20
</td>
<td style="text-align:right;">
0.72
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.15
</td>
<td style="text-align:right;">
0.44
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_10
</td>
<td style="text-align:right;">
0.69
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.32
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.49
</td>
<td style="text-align:right;">
0.41
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_26
</td>
<td style="text-align:right;">
0.69
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.12
</td>
<td style="text-align:right;">
0.43
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_25
</td>
<td style="text-align:right;">
0.68
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.07
</td>
<td style="text-align:right;">
0.49
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_06
</td>
<td style="text-align:right;">
-0.66
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.07
</td>
<td style="text-align:right;">
0.55
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_07
</td>
<td style="text-align:right;">
0.62
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.08
</td>
<td style="text-align:right;">
0.56
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_27
</td>
<td style="text-align:right;">
-0.59
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.07
</td>
<td style="text-align:right;">
0.68
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_11
</td>
<td style="text-align:right;">
0.54
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.35
</td>
<td style="text-align:right;">
0.58
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_18
</td>
<td style="text-align:right;">
0.48
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.29
</td>
<td style="text-align:right;">
0.69
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_14
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.65
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.48
</td>
<td style="text-align:right;">
0.35
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_17
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.63
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.18
</td>
<td style="text-align:right;">
0.58
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_16
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.55
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.20
</td>
<td style="text-align:right;">
0.68
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_22
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.50
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.06
</td>
<td style="text-align:right;">
0.78
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_08
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.49
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
-0.26
</td>
<td style="text-align:right;">
1.73
</td>
<td style="text-align:right;">
0.70
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_13
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.48
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.14
</td>
<td style="text-align:right;">
0.79
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_09
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.34
</td>
<td style="text-align:right;">
0.34
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
2.37
</td>
<td style="text-align:right;">
0.68
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_21
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.62
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.07
</td>
<td style="text-align:right;">
0.60
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_04
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
0.56
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.62
</td>
<td style="text-align:right;">
0.44
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_01
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.52
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.13
</td>
<td style="text-align:right;">
0.70
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_03
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.46
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.60
</td>
<td style="text-align:right;">
0.81
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_24
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.40
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.29
</td>
<td style="text-align:right;">
0.77
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_15
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
0.33
</td>
<td style="text-align:right;">
2.10
</td>
<td style="text-align:right;">
0.65
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_05
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.56
</td>
<td style="text-align:right;">
1.07
</td>
<td style="text-align:right;">
0.67
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_28
</td>
<td style="text-align:right;">
-0.35
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.48
</td>
<td style="text-align:right;">
1.98
</td>
<td style="text-align:right;">
0.46
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_23
</td>
<td style="text-align:right;">
-0.28
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.44
</td>
<td style="text-align:right;">
1.72
</td>
<td style="text-align:right;">
0.62
</td>
</tr>
<tr>
<td style="text-align:left;">
tosr\_12
</td>
<td style="text-align:right;">
-0.22
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
1.96
</td>
<td style="text-align:right;">
0.76
</td>
</tr>
</tbody>
</table>

#### Factor 1

This factor seems to relate to teaching.

-   Q2: I wish students would stop bugging me with their shit.
-   Q19: I like to help students
-   Q20: Passing on knowledge is the greatest gift you can bestow an individual
-   Q10: I could spend all day explaining statistics to people
-   Q26: I spend lots of time helping students
-   Q25: I love teaching
-   Q6: Teaching others makes me want to swallow a large bottle of bleach because the pain of my burning oesophagus would be light relief in comparison
-   Q7: Helping others to understand sums of squares is a great feeling
-   Q27: I love teaching because students have to pretend to like me or they’ll get bad marks
-   Q11: I like it when people tell me I’ve helped them to understand factor rotation
-   Q18: Standing in front of 300 people in no way makes me lose control of my bowels

#### Factor 2

This factor 1 seems to relate to research methods.

-   Q14: I’d rather think about appropriate outcome variables than go for a drink with my friends
-   Q17: I enjoy sitting in the park contemplating whether to use participant observation in my next experiment
-   Q16: Thinking about whether to use repeated or independent measures thrills me
-   Q22: I quiver with excitement when thinking about designing my next experiment
-   Q8: I like control conditions
-   Q13: Designing experiments is fun
-   Q9: I calculate 3 ANOVAs in my head before getting out of bed \[*equally loaded on factor 3*\]

#### Factor 3

This factor seems to relate to statistics.

-   Q9: I calculate 3 ANOVAs in my head before getting out of bed \[*equally loaded on factor 3*\]
-   Q21: Thinking about Bonferroni corrections gives me a tingly feeling in my groin
-   Q4: I worship at the shrine of Pearson
-   Q1: I once woke up in the middle of a vegetable patch hugging a turnip that I’d mistakenly dug up thinking it was Roy’s largest root
-   Q3: I memorize probability values for the *F*-distribution
-   Q 24: I tried to build myself a time machine so that I could go back to the 1930s and follow Mahalanobis on my hands and knees licking the ground on which he’d just trodden
-   Q15: I soil my pants with excitement at the mere mention of factor analysis \[*equally loaded on factor 4*\]

#### Factor 4

This factor seems to relate to social functioning. Not sure where the soiling pants comes in but probably if you’re the sort of person who soils their pants at the mention of factor analysis then things are going to get social awkward for you sooner rather than later.

-   Q5: I still live with my mother and have little personal hygiene
-   Q28: My cat is my only friend
-   Q23: I often spend my spare time talking to the pigeons … and even they die of boredom
-   Q12: People fall asleep as soon as I open my mouth to speak
-   Q15: I soil my pants with excitement at the mere mention of factor analysis \[*equally loaded on factor 4*\]

## Task 18.3

> Dr Sian Williams (University of Brighton) devised a questionnaire to measure organizational ability. She predicted five components to do with organizational ability:(1) preference for organization; (2) goal achievement; (3) planning approach; (4) acceptance of delays; and (5) preference for routine. Williams’s questionnaire contains 28 items using a seven-point Likert scale (1 = strongly disagree, 4 = neither, 7 = strongly agree). She gave it to 239 people. Run a factor analysis (following the settings in this chapter) on the data in **williams.csv**.

### Load the data

To load the data from the CSV file (assuming you have set up a project folder as suggested in the book):

``` r
org_tib <- here::here("data/williams.csv") %>%
  readr::read_csv()
```

Alternative, load the data directly from the `discovr` package:

``` r
org_tib <- discovr::williams
```

### Fit the model

The questionnaire items are as follows:

1.  I like to have a plan to work to in everyday life
2.  I feel frustrated when things don’t go to plan
3.  I get most things done in a day that I want to
4.  I stick to a plan once I have made it
5.  I enjoy spontaneity and uncertainty
6.  I feel frustrated if I can’t find something I need
7.  I find it difficult to follow a plan through
8.  I am an organized person
9.  I like to know what I have to do in a day
10. Disorganized people annoy me
11. I leave things to the last minute
12. I have many different plans relating to the same goal
13. I like to have my documents filed and in order
14. I find it easy to work in a disorganized environment
15. I make ‘to do’ lists and achieve most of the things on it
16. My workspace is messy and disorganized
17. I like to be organized
18. Interruptions to my daily routine annoy me
19. I feel that I am wasting my time
20. I forget the plans I have made
21. I prioritize the things I have to do
22. I like to work in an organized environment
23. I feel relaxed when I don’t have a routine
24. I set deadlines for myself and achieve them
25. I change rather aimlessly from one activity to another during the day
26. I have trouble organizing the things I have to do
27. I put tasks off to another day
28. I feel restricted by schedules and plans

### Create correlation matrix

The data file has a variables in it containing participants’ demographic information. Let’s store a version of the data that only has the item scores.

``` r
org_items_tib <- org_tib %>% 
  dplyr::select(-id)
```

We can create the correlations between variables by executing (again, items were rated on Likert response scales, so we’ll use polychoric correlations).

``` r
org_poly <- psych::polychoric(org_items_tib)
org_cor <- org_poly$rho
```

To get a plot of the correlations we can execute:

``` r
psych::cor.plot(org_cor, upper = FALSE)
```

<img src="/solutions/alex/alex_18_files/figure-html/unnamed-chunk-32-1.png" width="672" />

### The Bartlett test

``` r
psych::cortest.bartlett(org_cor, n = 239)
```

    ## $chisq
    ## [1] 3679.19
    ## 
    ## $p.value
    ## [1] 0
    ## 
    ## $df
    ## [1] 378

This (basically useless) tests confirms that the correlation matrix is significantly different from an identity matrix (i.e. correlations are non-zero).

Determinant of the correlation matrix:

``` r
det(org_cor)
```

    ## [1] 9.699541e-08

The determinant of the correlation matrix was 0.00000009699541, which is smaller than 0.00001 and, therefore, indicates that multicollinearity could be a problem in these data.

### The KMO test

``` r
psych::KMO(org_cor)
```

    ## Kaiser-Meyer-Olkin factor adequacy
    ## Call: psych::KMO(r = org_cor)
    ## Overall MSA =  0.88
    ## MSA for each item = 
    ## org_01 org_02 org_03 org_04 org_05 org_06 org_07 org_08 org_09 org_10 org_11 
    ##   0.93   0.78   0.84   0.82   0.85   0.76   0.83   0.94   0.94   0.90   0.91 
    ## org_12 org_13 org_14 org_15 org_16 org_17 org_18 org_19 org_20 org_21 org_22 
    ##   0.57   0.93   0.88   0.88   0.94   0.91   0.85   0.76   0.79   0.85   0.88 
    ## org_23 org_24 org_25 org_26 org_27 org_28 
    ##   0.82   0.89   0.87   0.90   0.86   0.82

The KMO measure of sampling adequacy is 0.88, which is above Kaiser’s (1974) recommendation of 0.5. This value is also ‘meritorious’ (and almost ‘marvellous’). Individual items KMO values ranged from 0.57 to 0.94. As such, the evidence suggests that the sample size is adequate to yield distinct and reliable factors.

### Distributions for items

``` r
org_tidy_tib <- org_items_tib %>% 
  tidyr::pivot_longer(
    cols = org_01:org_28,
    names_to = "Item",
    values_to = "Response"
  ) %>% 
  dplyr::mutate(
    Item = gsub("org_", "ORG ", Item)
  )

ggplot2::ggplot(org_tidy_tib, aes(Response)) +
  geom_histogram(binwidth = 1, fill = "#136CB9", colour = "#136CB9", alpha = 0.5) +
  labs(y = "Frequency") +
  facet_wrap(~ Item, ncol = 6) +
  theme_minimal()
```

<img src="/solutions/alex/alex_18_files/figure-html/unnamed-chunk-37-1.png" width="672" />

### Parallel analysis

``` r
psych::fa.parallel(org_cor, fm = "ml", fa = "fa", n.obs = 239)
```

<img src="/solutions/alex/alex_18_files/figure-html/unnamed-chunk-38-1.png" width="672" />

    ## Parallel analysis suggests that the number of factors =  5  and the number of components =  NA

Based on parallel analysis five factors should be extracted.

### Factor analysis

Create the factor analysis object. The question asks us to use maximum likelihood so I have included `fm = "ml"`. We choose an oblique rotation (the default) because the question says that the constructs we’re measuring are related.

``` r
org_fa <- psych::fa(org_cor,
                    n.obs = 239,
                    fm = "minres",
                    nfactors = 5
                    )
```

``` r
summary(org_fa)
```

    ## 
    ## Factor analysis with Call: psych::fa(r = org_cor, nfactors = 5, n.obs = 239, fm = "minres")
    ## 
    ## Test of the hypothesis that 5 factors are sufficient.
    ## The degrees of freedom for the model is 248  and the objective function was  2.51 
    ## The number of observations was  239  with Chi Square =  563.4  with prob <  1.4e-26 
    ## 
    ## The root mean square of the residuals (RMSA) is  0.04 
    ## The df corrected root mean square of the residuals is  0.04 
    ## 
    ## Tucker Lewis Index of factoring reliability =  0.852
    ## RMSEA index =  0.073  and the 10 % confidence intervals are  0.065 0.081
    ## BIC =  -794.77
    ##  With factor correlations of 
    ##      MR1   MR2  MR4  MR3   MR5
    ## MR1 1.00  0.35 0.45 0.38  0.30
    ## MR2 0.35  1.00 0.35 0.21 -0.08
    ## MR4 0.45  0.35 1.00 0.22  0.29
    ## MR3 0.38  0.21 0.22 1.00  0.25
    ## MR5 0.30 -0.08 0.29 0.25  1.00

In terms of fit

-   The chi-square statistic is \$ \\chi^2 = \$(248) 563.4, *p* &lt; 0.001. This is consistent with when we ran the analysis as factor analysis in the chapter.
-   The Tucker Lewis Index of factoring reliability (TFI) is given as 0.85, which is well below 0.96.
-   The RMSEA = 0.073 90% CI \[0.065, 0.081\], which is greater than 0.05.
-   The RMSR is 0.04, which is smaller than both 0.09 and 0.06.

Remember that we’re looking for a combination of TLI &gt; 0.96 and SRMR (RMSR in the output) &lt; 0.06, and a combination of RMSEA &lt; 0.05 and SRMR &lt; 0.09. With the caveat that universal cut-offs need to be taken with a pinch of salt, it’s reasonable to conclude that the model has poor fit.

Inspect the factor loadings:

``` r
parameters::model_parameters(org_fa, threshold = 0.2, sort = TRUE) %>% 
  knitr::kable(digits = 2)
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Variable
</th>
<th style="text-align:right;">
MR1
</th>
<th style="text-align:right;">
MR2
</th>
<th style="text-align:right;">
MR4
</th>
<th style="text-align:right;">
MR3
</th>
<th style="text-align:right;">
MR5
</th>
<th style="text-align:right;">
Complexity
</th>
<th style="text-align:right;">
Uniqueness
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
org\_14
</td>
<td style="text-align:right;">
0.78
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
-0.27
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.38
</td>
<td style="text-align:right;">
0.34
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_16
</td>
<td style="text-align:right;">
0.78
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.14
</td>
<td style="text-align:right;">
0.35
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_22
</td>
<td style="text-align:right;">
0.77
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.22
</td>
<td style="text-align:right;">
0.19
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_17
</td>
<td style="text-align:right;">
0.72
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.25
</td>
<td style="text-align:right;">
0.25
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_08
</td>
<td style="text-align:right;">
0.50
</td>
<td style="text-align:right;">
0.30
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
2.31
</td>
<td style="text-align:right;">
0.28
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_13
</td>
<td style="text-align:right;">
0.49
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.62
</td>
<td style="text-align:right;">
0.51
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_10
</td>
<td style="text-align:right;">
0.40
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
1.94
</td>
<td style="text-align:right;">
0.65
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_19
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.63
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.23
</td>
<td style="text-align:right;">
0.60
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_27
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.61
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.34
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.58
</td>
<td style="text-align:right;">
0.39
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_25
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.60
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.12
</td>
<td style="text-align:right;">
0.52
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_20
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.58
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.09
</td>
<td style="text-align:right;">
0.63
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_26
</td>
<td style="text-align:right;">
0.38
</td>
<td style="text-align:right;">
0.47
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
-0.25
</td>
<td style="text-align:right;">
2.56
</td>
<td style="text-align:right;">
0.42
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_07
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.46
</td>
<td style="text-align:right;">
0.32
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.90
</td>
<td style="text-align:right;">
0.57
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_11
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
0.21
</td>
<td style="text-align:right;">
0.20
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
3.30
</td>
<td style="text-align:right;">
0.47
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_24
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.69
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.22
</td>
<td style="text-align:right;">
0.39
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_03
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.25
</td>
<td style="text-align:right;">
0.55
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.55
</td>
<td style="text-align:right;">
0.51
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_04
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.26
</td>
<td style="text-align:right;">
0.49
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
2.21
</td>
<td style="text-align:right;">
0.49
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_21
</td>
<td style="text-align:right;">
0.43
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.45
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
2.05
</td>
<td style="text-align:right;">
0.46
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_15
</td>
<td style="text-align:right;">
0.36
</td>
<td style="text-align:right;">
-0.22
</td>
<td style="text-align:right;">
0.44
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
2.72
</td>
<td style="text-align:right;">
0.56
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_01
</td>
<td style="text-align:right;">
0.31
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.43
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.22
</td>
<td style="text-align:right;">
3.11
</td>
<td style="text-align:right;">
0.38
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_23
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.66
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.25
</td>
<td style="text-align:right;">
0.49
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_05
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.65
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.10
</td>
<td style="text-align:right;">
0.51
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_28
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.63
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.18
</td>
<td style="text-align:right;">
0.53
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_12
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.33
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.70
</td>
<td style="text-align:right;">
0.87
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_02
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.71
</td>
<td style="text-align:right;">
1.04
</td>
<td style="text-align:right;">
0.45
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_06
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.70
</td>
<td style="text-align:right;">
1.06
</td>
<td style="text-align:right;">
0.53
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_18
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.28
</td>
<td style="text-align:right;">
0.47
</td>
<td style="text-align:right;">
2.04
</td>
<td style="text-align:right;">
0.55
</td>
</tr>
<tr>
<td style="text-align:left;">
org\_09
</td>
<td style="text-align:right;">
0.32
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.32
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.34
</td>
<td style="text-align:right;">
3.46
</td>
<td style="text-align:right;">
0.34
</td>
</tr>
</tbody>
</table>

#### Factor 1

This factor 1 seems to relate to *preference for organization*.

-   Q14: I find it easy to work in a disorganized environment
-   Q16: My workspace is messy and disorganized
-   Q22: I like to work in an organized environment
-   Q17: I like to be organized
-   Q8: I am an organized person
-   Q13: I like to have my documents filed and in order
-   Q10: Disorganized people annoy me

#### Factor 2

This factor seems to relate to *goal achievement* (it probably depends how you define goal achievement but does seem to relate to your ability to follow a plan through!).

-   Q19: I feel that I am wasting my time
-   Q27: I put tasks off to another day
-   Q25: I change rather aimlessly from one activity to another during the day
-   Q20: I forget the plans I have made
-   Q26: I have trouble organizing the things I have to do
-   Q7: I find it difficult to follow a plan through
-   Q11: I leave things to the last minute

#### Factor 3

This factor seems to relate to *planning approach*.

-   Q24: I set deadlines for myself and achieve them
-   Q3: I get most things done in a day that I want to
-   Q4: I stick to a plan once I have made it
-   Q21: I prioritize the things I have to do
-   Q15: I make ‘to do’ lists and achieve most of the things on it
-   Q1: I like to have a plan to work to in everyday life

#### Factor 4

This factor seems to relate to *preference for routine*.

-   Q23: I feel relaxed when I don’t have a routine
-   Q5: I enjoy spontaneity and uncertainty
-   Q28: I feel restricted by schedules and plans
-   Q12: I have many different plans relating to the same goal

#### Factor 5

This factor seems to relate to *acceptance of delays*.

-   Q2: I feel frustrated when things don’t go to plan
-   Q6: I feel frustrated if I can’t find something I need
-   Q18: Interruptions to my daily routine annoy me
-   Q9: I like to know what I have to do in a day

It seems as though there is some factorial validity to the hypothesized structure. (But remember that this model has poor fit.)

## Task 18.4

> Zibarras et al., (2008) looked at the relationship between personality and creativity. They used the Hogan Development Survey (HDS), which measures 11 dysfunctional dispositions of employed adults: being **volatile**, **mistrustful**, **cautious**, **detached**, **passive\_aggressive**, **arrogant**, **manipulative**, **dramatic**, **eccentric**, **perfectionist**, and **dependent**. Zibarras et al. wanted to reduce these 11 traits down and, based on parallel analysis, found that they could be reduced to three components. They ran a principal component analysis with varimax rotation. Repeat this analysis (**zibarras\_2008.csv**) to see which personality dimensions clustered together (see page 210 of the original paper).

### Load the data

To load the data from the CSV file (assuming you have set up a project folder as suggested in the book):

``` r
zibarras_tib <- here::here("data/zibarras_2018.csv") %>%
  readr::read_csv()
```

Alternative, load the data directly from the `discovr` package:

``` r
zibarras_tib <- discovr::zibarras_2008
```

Like the authors, I ran the analysis with principal components and varimax rotation.

### Create correlation matrix

The data file has a variable in it containing participants’ ids. Let’s store a version of the data that only has the item scores.

``` r
zibarras_tib <- zibarras_tib %>% 
  dplyr::select(-id)
```

We can create the correlations between variables by executing.

``` r
zibarras_cor <- cor(zibarras_tib)
```

To get a plot of the correlations we can execute:

``` r
psych::cor.plot(zibarras_cor, upper = FALSE)
```

<img src="/solutions/alex/alex_18_files/figure-html/unnamed-chunk-46-1.png" width="672" />

### The Bartlett test

``` r
psych::cortest.bartlett(zibarras_cor, n = 207)
```

    ## $chisq
    ## [1] 527.8976
    ## 
    ## $p.value
    ## [1] 1.841689e-78
    ## 
    ## $df
    ## [1] 55

This (basically useless) tests confirms that the correlation matrix is significantly different from an identity matrix (i.e. correlations are non-zero).

### The KMO test

``` r
psych::KMO(zibarras_cor)
```

    ## Kaiser-Meyer-Olkin factor adequacy
    ## Call: psych::KMO(r = zibarras_cor)
    ## Overall MSA =  0.68
    ## MSA for each item = 
    ##           volatile        mistrustful           cautious           detached 
    ##               0.52               0.62               0.71               0.56 
    ## passive_aggressive           arrogant       manipulative           dramatic 
    ##               0.50               0.76               0.81               0.72 
    ##          eccentric         perfectist          dependent 
    ##               0.82               0.54               0.58

The KMO measure of sampling adequacy is 0.68, which is above Kaiser’s (1974) recommendation of 0.5. Individual items KMO values ranged from 0.5 to 0.82. Thee values are in the mediocre to middling range. The sample size is probably adequate to yield distinct and reliable factors.

### Distributions for items

``` r
zib_tidy_tib <- zibarras_tib %>% 
  tidyr::pivot_longer(
    cols = volatile:dependent,
    names_to = "Item",
    values_to = "Response"
  ) %>% 
  dplyr::mutate(
    Item = stringr::str_to_sentence(Item)
  )

ggplot2::ggplot(zib_tidy_tib, aes(Response)) +
  geom_histogram(binwidth = 1, fill = "#136CB9", colour = "#136CB9", alpha = 0.5) +
  labs(y = "Frequency") +
  facet_wrap(~ Item, ncol = 3) +
  theme_minimal()
```

<img src="/solutions/alex/alex_18_files/figure-html/unnamed-chunk-50-1.png" width="672" />

### Parallel analysis

``` r
psych::fa.parallel(zibarras_cor, fa = "pc", n.obs = 207)
```

<img src="/solutions/alex/alex_18_files/figure-html/unnamed-chunk-51-1.png" width="672" />

    ## Parallel analysis suggests that the number of factors =  NA  and the number of components =  3

Based on parallel analysis three components should be extracted (as the authors did in the paper).

### PCA

Create the PCA object. We choose an orthogonal rotation (varimax) because that’s what the authors did - this is the default for PCA so we don’t need to specify it explicitly.

``` r
zib_pca <- psych::pca(zibarras_cor,
                    n.obs = 207,
                    nfactors = 3
                    )
```

``` r
summary(zib_pca)
```

    ## 
    ## Factor analysis with Call: principal(r = r, nfactors = nfactors, residuals = residuals, 
    ##     rotate = rotate, n.obs = n.obs, covar = covar, scores = scores, 
    ##     missing = missing, impute = impute, oblique.scores = oblique.scores, 
    ##     method = method, use = use, cor = cor, correct = 0.5, weight = NULL)
    ## 
    ## Test of the hypothesis that 3 factors are sufficient.
    ## The degrees of freedom for the model is 25  and the objective function was  0.92 
    ## The number of observations was  207  with Chi Square =  182.93  with prob <  5.7e-26 
    ## 
    ## The root mean square of the residuals (RMSA) is  0.1

Inspect the factor loadings:

``` r
parameters::model_parameters(zib_pca, threshold = 0.2, sort = TRUE) %>% 
  knitr::kable(digits = 2)
```

<table>
<thead>
<tr>
<th style="text-align:left;">
Variable
</th>
<th style="text-align:right;">
RC1
</th>
<th style="text-align:right;">
RC2
</th>
<th style="text-align:right;">
RC3
</th>
<th style="text-align:right;">
Complexity
</th>
<th style="text-align:right;">
Uniqueness
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
dramatic
</td>
<td style="text-align:right;">
0.83
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.11
</td>
<td style="text-align:right;">
0.27
</td>
</tr>
<tr>
<td style="text-align:left;">
manipulative
</td>
<td style="text-align:right;">
0.79
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.03
</td>
<td style="text-align:right;">
0.37
</td>
</tr>
<tr>
<td style="text-align:left;">
arrogant
</td>
<td style="text-align:right;">
0.68
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.06
</td>
<td style="text-align:right;">
0.53
</td>
</tr>
<tr>
<td style="text-align:left;">
cautious
</td>
<td style="text-align:right;">
-0.66
</td>
<td style="text-align:right;">
0.50
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.87
</td>
<td style="text-align:right;">
0.31
</td>
</tr>
<tr>
<td style="text-align:left;">
eccentric
</td>
<td style="text-align:right;">
0.55
</td>
<td style="text-align:right;">
0.30
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.73
</td>
<td style="text-align:right;">
0.59
</td>
</tr>
<tr>
<td style="text-align:left;">
perfectist
</td>
<td style="text-align:right;">
-0.32
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.09
</td>
<td style="text-align:right;">
0.89
</td>
</tr>
<tr>
<td style="text-align:left;">
volatile
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.79
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
1.03
</td>
<td style="text-align:right;">
0.37
</td>
</tr>
<tr>
<td style="text-align:left;">
mistrustful
</td>
<td style="text-align:right;">
0.27
</td>
<td style="text-align:right;">
0.68
</td>
<td style="text-align:right;">
0.24
</td>
<td style="text-align:right;">
1.58
</td>
<td style="text-align:right;">
0.40
</td>
</tr>
<tr>
<td style="text-align:left;">
detached
</td>
<td style="text-align:right;">
-0.28
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.76
</td>
<td style="text-align:right;">
1.39
</td>
<td style="text-align:right;">
0.30
</td>
</tr>
<tr>
<td style="text-align:left;">
dependent
</td>
<td style="text-align:right;">
-0.38
</td>
<td style="text-align:right;">
0.33
</td>
<td style="text-align:right;">
-0.64
</td>
<td style="text-align:right;">
2.21
</td>
<td style="text-align:right;">
0.33
</td>
</tr>
<tr>
<td style="text-align:left;">
passive\_aggressive
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
</td>
<td style="text-align:right;">
0.62
</td>
<td style="text-align:right;">
1.17
</td>
<td style="text-align:right;">
0.59
</td>
</tr>
</tbody>
</table>

The output shows the rotated component matrix, from which we see this pattern:

-   Component 1:
    -   Dramatic
    -   Manipulative
    -   Arrogant
    -   Cautious (negative weight)
    -   Eccentric
    -   Perfectionist (negative weight)
-   Component 2:
    -   Volatile
    -   Mistrustful
-   Component 3:
    -   Detached
    -   Dependent (negative weight)
    -   Passive-aggressive

Compare these results to those of Zibarras et al. (Table 4 from the original paper reproduced below), and note that they are the same.

<img src="/img/ds_c18_sa_04_table_04.png" alt = "Table 4 from Zibarras et al. (2008)" width="600">
