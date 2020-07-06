---
title: Smart Alex solutions Chapter 3
linktitle: Alex Chapter 3
toc: true
type: docs
date: "2020-07-06T00:00:00Z"
draft: false
menu:
  alex:
    parent: Smart Alex
    weight: 3

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 3

---

<img src="/img/dsus_smart_alex_banner.png" alt = "Smart Alex charatcer from Discovering Statistics using R and RStudio" width="600">


***
This document may contain abridged sections from *Discovering Statistics Using R and RStudio* by [Andy Field](https://www.discoveringstatistics.com/) so there are some copyright considerations, but the material is offered under a [Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License](http://creativecommons.org/licenses/by-nc-nd/4.0/). Basically you can use this material for teaching and non-profit activities but please do not meddle with it or claim it as your own work.

***



## Task 3.1

> Why do we use samples?

We are usually interested in populations, but because we cannot collect data from every human being (or whatever) in the population, we collect data from a small subset of the population (known as a sample) and use these data to infer things about the population as a whole.

## Task 3.2

> What is the mean and how do we tell if it’s representative of our data?

The mean is a simple statistical model of the centre of a distribution of scores. A hypothetical estimate of the ‘typical’ score. We use the variance, or standard deviation, to tell us whether it is representative of our data. The standard deviation is a measure of how much error there is associated with the mean: a small standard deviation indicates that the mean is a good representation of our data.

## Task 3.3

> What’s the difference between the standard deviation and the standard error?

The standard deviation tells us how much observations in our sample differ from the mean value within our sample. The standard error tells us not about how the sample mean represents the sample itself, but how well the sample mean represents the population mean. The standard error is the standard deviation of the sampling distribution of a statistic. For a given statistic (e.g. the mean) it tells us how much variability there is in this statistic across samples from the same population. Large values, therefore, indicate that a statistic from a given sample may not be an accurate reflection of the population from which the sample came.

## Task 3.4

>In Chapter 1 we used an example of the time in seconds taken for 21 heavy smokers to fall off a treadmill at the fastest setting (18, 16, 18, 24, 23, 22, 22, 23, 26, 29, 32, 34, 34, 36, 36, 43, 42, 49, 46, 46, 57). Calculate standard error and 95% confidence interval for these data.

If you did the tasks in Chapter 1, you’ll know that the mean is 32.19 seconds:
$$ \begin{aligned} \overline{X} &= \frac{\sum_{i=1}^{n} x_i}{n} \\\\
  \ &= \frac{16+(2\times18)+(2\times22)+(2\times23)+24+26+29+32+(2\times34)+(2\times36)+42+43+(2\times46)+49+57}{21} \\\\
  \ &= \frac{676}{21} \\\\
  \ &= 32.19 \end{aligned} $$

We also worked out that the sum of squared errors was 2685.24; the variance was 2685.24/20 = 134.26; the standard deviation is the square root of the variance, so was $ \sqrt(134.26) $ = 11.59.
The standard error will be:

$$ SE = \frac{s}{\sqrt{N}} = \frac{11.59}{\sqrt{21}} = 2.53 $$

The sample is small, so to calculate the confidence interval we need to find the appropriate value of *t*. First we need to calculate the degrees of freedom, $ N - 1 $. With 21 data points, the degrees of freedom are 20. For a 95% confidence interval we can look up the value in the column labelled ‘Two-Tailed Test’, ‘0.05’ in the table of critical values of the *t*-distribution (Appendix). The corresponding value is 2.09. The confidence intervals is, therefore, given by:

- Lower boundary of confidence interval = $ \overline{X}-(2.09\times SE) $ = 32.19 – (2.09 × 2.53) = 26.90
- Upper boundary of confidence interval = $ \overline{X}+(2.09\times SE) $ = 32.19 + (2.09 × 2.53) = 37.48

## Task 3.5

> What do the sum of squares, variance and standard deviation represent? How do they differ?

All of these measures tell us something about how well the mean fits the observed sample data. Large values (relative to the scale of measurement) suggest the mean is a poor fit of the observed scores, and small values suggest a good fit. They are also, therefore, measures of dispersion, with large values indicating a spread-out distribution of scores and small values showing a more tightly packed distribution. These measures all represent the same thing, but differ in how they express it. The sum of squared errors is a ‘total’ and is, therefore, affected by the number of data points. The variance is the ‘average’ variability but in units squared. The standard deviation is the average variation but converted back to the original units of measurement. As such, the size of the standard deviation can be compared to the mean (because they are in the same units of measurement).

## Task 3.6

>What is a test statistic and what does it tell us?

A test statistic is a statistic for which we know how frequently different values occur. The observed value of such a statistic is typically used to test hypotheses, or to establish whether a model is a reasonable representation of what’s happening in the population.

## Task 3.7

>What are Type I and Type II errors?

A Type I error occurs when we believe that there is a genuine effect in our population, when in fact there isn’t. A Type II error occurs when we believe that there is no effect in the population when, in reality, there is.

## Task 3.8

> What is statistical power?

Power is the ability of a test to detect an effect of a particular size (a value of 0.8 is a good level to aim for).

## Task 3.9

> Figure 2.16 shows two experiments that looked at the effect of singing versus conversation on how much time a woman would spend with a man. In both experiments the means were 10 (singing) and 12 (conversation), the standard deviations in all groups were 3, but the group sizes were 10 per group in the first experiment and 100 per group in the second. Compute the values of the confidence intervals displayed in the Figure.

### Experiment 1:

In both groups, because they have a standard deviation of 3 and a sample size of 10, the standard error will be:

$$ SE = \frac{s}{\sqrt{N}} = \frac{3}{\sqrt{10}} = 0.95 $$

The sample is small, so to calculate the confidence interval we need to find the appropriate value of *t*. First we need to calculate the degrees of freedom, $ N - 1 $. With 10 data points, the degrees of freedom are 9. For a 95% confidence interval we can look up the value in the column labelled ‘Two-Tailed Test’, ‘0.05’ in the table of critical values of the *t*-distribution (Appendix). The corresponding value is 2.26. The confidence interval for the singing group is, therefore, given by:

- Lower boundary of confidence interval = $ \overline{X}-(2.26\times SE) $ = 10 – (2.26 × 0.95) = 7.85
- Upper boundary of confidence interval = $ \overline{X}+(2.26\times SE) $ = 10 + (2.26 × 0.95) = 12.15

For the conversation group:

- Lower boundary of confidence interval = $ \overline{X}-(2.26\times SE) $ = 12 – (2.26 × 0.95) = 9.85
- Upper boundary of confidence interval = $ \overline{X}+(2.26\times SE) $ = 12 + (2.26 × 0.95) = 14.15

### Experiment 2
In both groups, because they have a standard deviation of 3 and a sample size of 100, the standard error will be:

$$ SE = \frac{s}{\sqrt{N}} = \frac{3}{\sqrt{100}} = 0.3 $$
The sample is large, so to calculate the confidence interval we need to find the appropriate value of *z*. For a 95% confidence interval we should look up the value of 0.025 in the column labelled Smaller Portion in the table of the standard normal distribution (Appendix). The corresponding value is 1.96. The confidence interval for the singing group is, therefore, given by:

- Lower boundary of confidence interval = $ \overline{X}-(1.96\times SE) $ = 10 – (1.96 × 0.3) = 9.41
- Upper boundary of confidence interval = $ \overline{X}+(1.96\times SE) $ = 10 + (1.96 × 0.3) = 10.59

For the conversation group:

- Lower boundary of confidence interval = $ \overline{X}-(1.96\times SE) $ = 12 – (1.96 × 0.3) = 11.41
- Upper boundary of confidence interval = $ \overline{X}+(1.96\times SE) $ = 12 + (1.96 × 0.3) = 12.59

## Task 3.10

> Figure 2.17 shows a similar study to above, but the means were 10 (singing) and 10.01 (conversation), the standard deviations in both groups were 3, and each group contained 1 million people. Compute the values of the confidence intervals displayed in the figure.

In both groups, because they have a standard deviation of 3 and a sample size of 1,000,000, the standard error will be:

$$ SE = \frac{s}{\sqrt{N}} = \frac{3}{\sqrt{1000000}} = 0.003 $$
The sample is large, so to calculate the confidence interval we need to find the appropriate value of z. For a 95% confidence interval we should look up the value of 0.025 in the column labelled Smaller Portion in the table of the standard normal distribution (Appendix). The corresponding value is 1.96. The confidence interval for the singing group is, therefore, given by:

- Lower boundary of confidence interval = $ \overline{X}-(1.96\times SE) $ = 10 – (1.96 × 0.003) = 9.99412
- Upper boundary of confidence interval = $ \overline{X}+(1.96\times SE) $= 10 + (1.96 × 0.003) = 10.00588
For the conversation group:

- Lower boundary of confidence interval = $ \overline{X}-(1.96\times SE) $ = 10.01 – (1.96 × 0.003) = 10.00412
- Upper boundary of confidence interval = $ \overline{X}+(1.96\times SE) $ = 10.01 + (1.96 × 0.003) = 10.01588

Note: these values will look slightly different than the graph because the exact means were 10.00147 and 10.01006, but we rounded off to 10 and 10.01 to make life a bit easier. If you use these exact values you’d get, for the singing group:

- Lower boundary of confidence interval = 10.00147 – (1.96 × 0.003) = 9.99559
- Upper boundary of confidence interval = 10.00147 + (1.96 × 0.003) = 10.00735

For the conversation group:

- Lower boundary of confidence interval  = 10.01006 – (1.96 × 0.003) = 10.00418
- Upper boundary of confidence interval = 10.01006 + (1.96 × 0.003) = 10.01594

## Task 3.11

> In Chapter 2 (Task 8) we looked at an example of how many games it took a sportsperson before they hit the ‘red zone’ Calculate the standard error and confidence interval for those data.

We worked out in Chapter 1 that the mean was 10.27, the standard deviation 4.15, and there were 11 sportspeople in the sample. The standard error will be:

$$ SE = \frac{s}{\sqrt{N}} = \frac{4.15}{\sqrt{11}} = 1.25 $$
The sample is small, so to calculate the confidence interval we need to find the appropriate value of *t*. First we need to calculate the degrees of freedom, $ N - 1 $. With 11 data points, the degrees of freedom are 10. For a 95% confidence interval we can look up the value in the column labelled ‘Two-Tailed Test’, ‘.05’ in the table of critical values of the *t*-distribution (Appendix). The corresponding value is 2.23. The confidence interval is, therefore, given by:

- Lower boundary of confidence interval = $ \overline{X}-(2.23\times SE) $ = 10.27 – (2.23 × 1.25) = 7.48
- Upper boundary of confidence interval = $ \overline{X}+(2.23\times SE) $ = 10.27 + (2.23 × 1.25) = 13.06

## Task 3.12

> At a rival club to the one I support, they similarly measured the number of consecutive games it took their players before they reached the red zone. The data are: 6, 17, 7, 3, 8, 9, 4, 13, 11, 14, 7. Calculate the mean, standard deviation, and confidence interval for these data.

First we need to compute the mean:

$$ \begin{aligned} \overline{X} &= \frac{\sum_{i=1}^{n} x_i}{n} \\\\
&= \frac{6+17+7+3+8+9+4+13+11+14+7}{11} \\\\
&= \frac{99}{11} \\\\
&= 9.00 \end{aligned} $$

Then the standard deviation, which we do as follows:





| Score| Error (score - mean)| Error squared|
|-----:|--------------------:|-------------:|
|     6|                   -3|             9|
|    17|                    8|            64|
|     7|                   -2|             4|
|     3|                   -6|            36|
|     8|                   -1|             1|
|     9|                    0|             0|
|     4|                   -5|            25|
|    13|                    4|            16|
|    11|                    2|             4|
|    14|                    5|            25|
|     7|                   -2|             4|

The sum of squared errors is:

$$ \begin{aligned}
SS &= 9 + 64 + 4 + 36 + 1 + 0 + 25 + 16 + 4 + 25 + 4  \\\\
&= 188 \end{aligned} $$

The variance is the sum of squared errors divided by the degrees of freedom:

$$ \begin{aligned}
s^2 &= \frac{SS}{N - 1} \\\\
&= \frac{188}{10} \\\\
&= 18.8 \end{aligned} $$

The standard deviation is the square root of the variance:

$$ \begin{aligned}
s &= \sqrt{s^2} \\\\
&= \sqrt{18.8} \\\\
&= 4.34 \end{aligned} $$

There were 11 sportspeople in the sample, so the standard error will be:

$$ SE = \frac{s}{\sqrt{N}} = \frac{4.34}{\sqrt{11}} = 1.31 $$

The sample is small, so to calculate the confidence interval we need to find the appropriate value of *t*. First we need to calculate the degrees of freedom, $ N - 1 $. With 11 data points, the degrees of freedom are 10. For a 95% confidence interval we can look up the value in the column labelled ‘Two-Tailed Test’, ‘0.05’ in the table of critical values of the *t*-distribution (Appendix). The corresponding value is 2.23. The confidence intervals is, therefore, given by:

- Lower boundary of confidence interval = $ \overline{X}-(2.23\times SE) $ = 9 – (2.23 × 1.31) = 6.08
- Upper boundary of confidence interval = $ \overline{X}+(2.23\times SE) $ = 9 + (2.23 × 1.31) = 11.92

## Task 3.13

> In Chapter 2 (Task 9) we looked at the length in days of nine celebrity marriages. Here are the length in days of nine marriages, one being mine and the other eight being those of some of my friends and family (in all but one case up to the day I’m writing this, which is 8 March 2012, but in the 91-day case it was the entire duration – this isn’t my marriage, in case you’re wondering: 210, 91, 3901, 1339, 662, 453, 16672, 21963, 222. Calculate the mean, standard deviation and confidence interval for these data. 

First we need to compute the mean:

$$ \begin{aligned} \overline{X} &= \frac{\sum_{i=1}^{n} x_i}{n} \\\\
&= \frac{210+91+3901+1339+662+453+16672+21963+222}{9} \\\\
&= \frac{45513}{9} \\\\
&= 5057 \end{aligned} $$

Compute the standard deviation as follows:





| Score| Error (score - mean)| Error squared|
|-----:|--------------------:|-------------:|
|   210|                -4847|      23493409|
|    91|                -4966|      24661156|
|  3901|                -1156|       1336336|
|  1339|                -3718|      13823524|
|   662|                -4395|      19316025|
|   453|                -4604|      21196816|
| 16672|                11615|     134908225|
| 21963|                16906|     285812836|
|   222|                -4835|      23377225|

The sum of squared errors is:

$$ \begin{aligned} SS &= 23493409 + 24661156 + 1336336 + 13823524 + 19316025 + 21196816 + 134908225 + 285812836 + 23377225   \\\\
&= 547925552 \end{aligned} $$

The variance is the sum of squared errors divided by the degrees of freedom:

$$ \begin{aligned} s^2 &= \frac{SS}{N - 1} \\\\
&= \frac{547925552}{8} \\\\
&= 68490694 \end{aligned} $$

The standard deviation is the square root of the variance:

$$ \begin{aligned} s &= \sqrt{s^2} \\\\
&= \sqrt{68490694} \\\\
&= 8275.91 \end{aligned} $$

The standard error is:

$$ SE = \frac{s}{\sqrt{N}} = \frac{8275.91}{\sqrt{9}} = 2758.64 $$

The sample is small, so to calculate the confidence interval we need to find the appropriate value of *t*. First we need to calculate the degrees of freedom, $ N - 1 $. With 9 data points, the degrees of freedom are 8. For a 95% confidence interval we can look up the value in the column labelled ‘Two-Tailed Test’, ‘0.05’ in the table of critical values of the *t*-distribution (Appendix). The corresponding value is 2.31. The confidence interval is, therefore, given by:

- Lower boundary of CI = $ \overline{X}-(2.31\times SE) $ = 5057 – (2.31 × 2758.64) = 1315.46
- Upper boundary of CI = $ \overline{X}+(2.31\times SE) $ = 5057 + (2.31 × 2758.64) = 11429.46
