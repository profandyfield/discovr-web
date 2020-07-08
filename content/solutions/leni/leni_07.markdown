---
title: Labcoat Leni solutions Chapter 7
linktitle: Leni Chapter 7
toc: true
type: docs
date: "2020-07-07T00:00:00Z"
draft: false
menu:
  leni:
    parent: Labcoat Leni
    weight: 7

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 7

---

<!--html_preserve--><img src="/img/leni_banner.png" alt = "Labcoat Leni character from Discovering Statistics using R and RStudio" width="600"><!--/html_preserve-->

{{% alert note %}}

<!--html_preserve--><p>This document contains abridged sections from <em>Discovering Statistics Using R and RStudio</em> by <a href="/index.html#about">Andy Field</a> so there are some copyright considerations. You can use this material for teaching and non-profit activities but please do not meddle with it or claim it as your own work. See the full license terms at the bottom of the page.</p><!--/html_preserve-->

{{% /alert %}}




## Why do you like your lecturers?

We can run this analysis by loading the file and just pretty much selecting everything in the variable list and running a Pearson correlation.

### Load the file


```r
library(tidyverse)
chamorro_tib <- readr::read_csv("../data/chamorro_premuzic.csv") %>% 
  dplyr::mutate(
    sex = forcats::as_factor(sex)
  )
```

Alternative, load the data directly from the `discovr` package:


```r
chamorro_tib <- discovr::chamorro_premuzic
```

### Obtain correlations

To get the correlations using `correlation()` (note I have set `p_adjust = "none"` because they didn't correct *p*-values for multiple tests in the paper):


```r
chamorro_r <- chamorro_tib %>% 
  dplyr::select(-c(age, sex)) %>%
  correlation::correlation(p_adjust = "none")
```


```r
chamorro_r %>% 
  knitr::kable(digits = 3)
```



|Parameter1   |Parameter2   |      r| CI_low| CI_high|      t|  df|     p|Method  | n_Obs|
|:------------|:------------|------:|------:|-------:|------:|---:|-----:|:-------|-----:|
|stu_neurotic |stu_extro    | -0.336| -0.419|  -0.249| -7.288| 416| 0.000|Pearson |   418|
|stu_neurotic |stu_open     | -0.055| -0.150|   0.041| -1.131| 416| 0.259|Pearson |   418|
|stu_neurotic |stu_agree    |  0.006| -0.091|   0.104|  0.131| 406| 0.896|Pearson |   408|
|stu_neurotic |stu_consc    | -0.196| -0.287|  -0.102| -4.067| 414| 0.000|Pearson |   416|
|stu_neurotic |lec_neurotic |  0.007| -0.090|   0.103|  0.133| 411| 0.895|Pearson |   413|
|stu_neurotic |lec_extro    | -0.081| -0.196|   0.036| -1.358| 279| 0.176|Pearson |   281|
|stu_neurotic |lec_open     | -0.018| -0.114|   0.078| -0.369| 414| 0.712|Pearson |   416|
|stu_neurotic |lec_agree    |  0.101|  0.004|   0.195|  2.050| 411| 0.041|Pearson |   413|
|stu_neurotic |lec_consc    |  0.003| -0.094|   0.099|  0.055| 411| 0.956|Pearson |   413|
|stu_extro    |stu_open     |  0.069| -0.027|   0.164|  1.408| 414| 0.160|Pearson |   416|
|stu_extro    |stu_agree    |  0.080| -0.017|   0.176|  1.622| 404| 0.106|Pearson |   406|
|stu_extro    |stu_consc    |  0.186|  0.092|   0.278|  3.852| 412| 0.000|Pearson |   414|
|stu_extro    |lec_neurotic | -0.099| -0.194|  -0.002| -2.012| 409| 0.045|Pearson |   411|
|stu_extro    |lec_extro    |  0.153|  0.037|   0.265|  2.586| 279| 0.010|Pearson |   281|
|stu_extro    |lec_open     |  0.068| -0.028|   0.164|  1.389| 412| 0.165|Pearson |   414|
|stu_extro    |lec_agree    |  0.004| -0.093|   0.101|  0.086| 409| 0.932|Pearson |   411|
|stu_extro    |lec_consc    | -0.010| -0.106|   0.087| -0.197| 409| 0.844|Pearson |   411|
|stu_open     |stu_agree    | -0.037| -0.134|   0.061| -0.737| 404| 0.461|Pearson |   406|
|stu_open     |stu_consc    | -0.091| -0.185|   0.006| -1.846| 412| 0.066|Pearson |   414|
|stu_open     |lec_neurotic | -0.101| -0.196|  -0.004| -2.054| 409| 0.041|Pearson |   411|
|stu_open     |lec_extro    |  0.041| -0.077|   0.157|  0.677| 279| 0.499|Pearson |   281|
|stu_open     |lec_open     |  0.201|  0.107|   0.292|  4.162| 412| 0.000|Pearson |   414|
|stu_open     |lec_agree    | -0.163| -0.256|  -0.067| -3.340| 409| 0.001|Pearson |   411|
|stu_open     |lec_consc    | -0.034| -0.130|   0.063| -0.684| 409| 0.494|Pearson |   411|
|stu_agree    |stu_consc    |  0.522|  0.448|   0.590| 12.286| 402| 0.000|Pearson |   404|
|stu_agree    |lec_neurotic | -0.021| -0.118|   0.076| -0.431| 404| 0.667|Pearson |   406|
|stu_agree    |lec_extro    |  0.050| -0.069|   0.167|  0.822| 274| 0.412|Pearson |   276|
|stu_agree    |lec_open     |  0.107|  0.010|   0.202|  2.158| 406| 0.031|Pearson |   408|
|stu_agree    |lec_agree    |  0.164|  0.067|   0.257|  3.331| 403| 0.001|Pearson |   405|
|stu_agree    |lec_consc    |  0.198|  0.102|   0.290|  4.050| 403| 0.000|Pearson |   405|
|stu_consc    |lec_neurotic | -0.140| -0.234|  -0.043| -2.849| 407| 0.005|Pearson |   409|
|stu_consc    |lec_extro    |  0.102| -0.016|   0.216|  1.701| 278| 0.090|Pearson |   280|
|stu_consc    |lec_open     |  0.027| -0.070|   0.123|  0.550| 410| 0.582|Pearson |   412|
|stu_consc    |lec_agree    |  0.133|  0.036|   0.227|  2.700| 407| 0.007|Pearson |   409|
|stu_consc    |lec_consc    |  0.216|  0.122|   0.307|  4.468| 407| 0.000|Pearson |   409|
|lec_neurotic |lec_extro    | -0.002| -0.119|   0.116| -0.032| 277| 0.975|Pearson |   279|
|lec_neurotic |lec_open     |  0.037| -0.060|   0.132|  0.746| 413| 0.456|Pearson |   415|
|lec_neurotic |lec_agree    |  0.045| -0.052|   0.141|  0.914| 412| 0.361|Pearson |   414|
|lec_neurotic |lec_consc    | -0.258| -0.346|  -0.166| -5.422| 412| 0.000|Pearson |   414|
|lec_extro    |lec_open     |  0.492|  0.399|   0.576|  9.467| 280| 0.000|Pearson |   282|
|lec_extro    |lec_agree    |  0.118|  0.000|   0.232|  1.976| 278| 0.049|Pearson |   280|
|lec_extro    |lec_consc    |  0.101| -0.017|   0.215|  1.688| 279| 0.093|Pearson |   281|
|lec_open     |lec_agree    |  0.242|  0.149|   0.330|  5.058| 413| 0.000|Pearson |   415|
|lec_open     |lec_consc    |  0.120|  0.024|   0.214|  2.458| 413| 0.014|Pearson |   415|
|lec_agree    |lec_consc    |  0.240|  0.147|   0.329|  5.022| 412| 0.000|Pearson |   414|


This looks pretty horrendous, but there are a lot of correlations that we don’t need. We’re interested only in the correlations between students’ personality and what they want in lecturers. We’re not interested in how their own five personality traits correlate with each other (i.e. if a student is neurotic are they conscientious too?). Let's focus in on these correlations by using filter and applying the function `grepl()`, which returns TRUE if it finds an expression. Within `filter()` we ask for cases where the pattern "stu" is found for the variable `Parameter1` (this is what `grepl("stu", Parameter1) == TRUE` does) **and** where the pattern "lec" is found for the variable `Parameter2` (this is what `grepl("lec", Parameter2) == TRUE` does). This has the effect of returning the 25 correlations between student personality traits and those desired in lecturers. I round of the code by rounding the values to two decimal places to match the paper:


```r
chamorro_r_reduced <- chamorro_r %>% 
  dplyr::filter(grepl("stu", Parameter1) == TRUE & grepl("lec", Parameter2))
```


```r
chamorro_r_reduced %>% 
  knitr::kable(digits = 3)
```



|Parameter1   |Parameter2   |      r| CI_low| CI_high|      t|  df|     p|Method  | n_Obs|
|:------------|:------------|------:|------:|-------:|------:|---:|-----:|:-------|-----:|
|stu_neurotic |lec_neurotic |  0.007| -0.090|   0.103|  0.133| 411| 0.895|Pearson |   413|
|stu_neurotic |lec_extro    | -0.081| -0.196|   0.036| -1.358| 279| 0.176|Pearson |   281|
|stu_neurotic |lec_open     | -0.018| -0.114|   0.078| -0.369| 414| 0.712|Pearson |   416|
|stu_neurotic |lec_agree    |  0.101|  0.004|   0.195|  2.050| 411| 0.041|Pearson |   413|
|stu_neurotic |lec_consc    |  0.003| -0.094|   0.099|  0.055| 411| 0.956|Pearson |   413|
|stu_extro    |lec_neurotic | -0.099| -0.194|  -0.002| -2.012| 409| 0.045|Pearson |   411|
|stu_extro    |lec_extro    |  0.153|  0.037|   0.265|  2.586| 279| 0.010|Pearson |   281|
|stu_extro    |lec_open     |  0.068| -0.028|   0.164|  1.389| 412| 0.165|Pearson |   414|
|stu_extro    |lec_agree    |  0.004| -0.093|   0.101|  0.086| 409| 0.932|Pearson |   411|
|stu_extro    |lec_consc    | -0.010| -0.106|   0.087| -0.197| 409| 0.844|Pearson |   411|
|stu_open     |lec_neurotic | -0.101| -0.196|  -0.004| -2.054| 409| 0.041|Pearson |   411|
|stu_open     |lec_extro    |  0.041| -0.077|   0.157|  0.677| 279| 0.499|Pearson |   281|
|stu_open     |lec_open     |  0.201|  0.107|   0.292|  4.162| 412| 0.000|Pearson |   414|
|stu_open     |lec_agree    | -0.163| -0.256|  -0.067| -3.340| 409| 0.001|Pearson |   411|
|stu_open     |lec_consc    | -0.034| -0.130|   0.063| -0.684| 409| 0.494|Pearson |   411|
|stu_agree    |lec_neurotic | -0.021| -0.118|   0.076| -0.431| 404| 0.667|Pearson |   406|
|stu_agree    |lec_extro    |  0.050| -0.069|   0.167|  0.822| 274| 0.412|Pearson |   276|
|stu_agree    |lec_open     |  0.107|  0.010|   0.202|  2.158| 406| 0.031|Pearson |   408|
|stu_agree    |lec_agree    |  0.164|  0.067|   0.257|  3.331| 403| 0.001|Pearson |   405|
|stu_agree    |lec_consc    |  0.198|  0.102|   0.290|  4.050| 403| 0.000|Pearson |   405|
|stu_consc    |lec_neurotic | -0.140| -0.234|  -0.043| -2.849| 407| 0.005|Pearson |   409|
|stu_consc    |lec_extro    |  0.102| -0.016|   0.216|  1.701| 278| 0.090|Pearson |   280|
|stu_consc    |lec_open     |  0.027| -0.070|   0.123|  0.550| 410| 0.582|Pearson |   412|
|stu_consc    |lec_agree    |  0.133|  0.036|   0.227|  2.700| 407| 0.007|Pearson |   409|
|stu_consc    |lec_consc    |  0.216|  0.122|   0.307|  4.468| 407| 0.000|Pearson |   409|

These values replicate the values reported in the original research paper (part of the authors’ table is below so you can see how they reported these values – match these values to the values in your output):

{{< figure library="true" src="ds_c07_leni_fig_01.png" title="Table from Chamorro-Premuzic et al. (2008)" lightbox="true" >}}


As for what we can conclude, well, neurotic students tend to want agreeable lecturers, $ r = .10 $, $ p = .041$; extroverted students tend to want extroverted lecturers, $ r = .15$, $ p = .010 $; students who are open to experience tend to want lecturers who are open to experience, $ r = .20$, $ p < .001$, and don't want agreeable lecturers, $ r = -.16$, $ p < .001$; agreeable students want every sort of lecturer apart from neurotic. Finally, conscientious students tend to want conscientious lecturers, $ r = .22$, $ p < .001$, and extroverted ones, $ r = .10$, $ p = .09$ (note that the authors report the one-tailed *p*-value), but don't want neurotic ones, $ r = -.14$, $ p = .005$.
