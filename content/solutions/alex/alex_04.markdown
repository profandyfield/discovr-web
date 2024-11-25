---
title: Smart Alex solutions Chapter 4
linktitle: Alex Chapter 4
toc: true
type: docs
date: "2020-07-06T00:00:00Z"
draft: false
menu:
  alex:
    parent: Smart Alex
    weight: 4

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 4

---

<!--html_preserve--><img src="/img/dsus_smart_alex_banner.png" alt = "Smart Alex charatcer from Discovering Statistics using R and RStudio" width="600"><!--/html_preserve-->

{{% alert note %}}

<!--html_preserve--><p>This document contains abridged sections from <em>Discovering Statistics Using R and RStudio</em> by <a href="/index.html#about">Andy Field</a> so there are some copyright considerations. You can use this material for teaching and non-profit activities but please do not meddle with it or claim it as your own work. See the full license terms at the bottom of the page.</p><!--/html_preserve-->

{{% /alert %}}




## Task 4.1

> What is an effect size and how is it measured?

An effect size is an objective and standardized measure of the magnitude of an observed effect. Measures include Cohen’s *d*, the odds ratio and Pearson’s correlations coefficient, *r*. Cohen’s *d*, for example, is the difference between two means divided by either the standard deviation of the control group, or by a pooled standard deviation.

## Task 4.2

> In Chapter 1 (Task 8) we looked at an example of how many games it took a sportsperson before they hit the ‘red zone’, then in Chapter 2 we looked at data from a rival club. Compute and interpret Cohen’s *d* for the difference in the mean number of games it took players to become fatigued in the two teams mentioned in those tasks.

Cohen’s *d*  is defined as:

$$ \hat{d} = \frac{\bar{X_1}-\bar{X_2}}{s} $$
There isn’t an obvious control group, so let's use a pooled estimate of the standard deviation:
$$ \begin{aligned} s_p &= \sqrt{\frac{(N_1-1) s_1^2+(N_2-1) s_2^2}{N_1+N_2-2}} \\\\
&= \sqrt{\frac{(11-1)4.15^2+(11-1)4.34^2}{11+11-2}} \\\\
&= \sqrt{\frac{360.23}{20}} \\\\
&= 4.24 \end{aligned} $$

Therefore, Cohen’s *d* is:

$$ \hat{d} = \frac{10.27-9}{4.24} = 0.30 $$
 
Therefore, the second team fatigued in fewer matches than the first team by about 1/3 standard deviation. By the benchmarks that we probably shouldn’t use, this is a small to medium effect, but I guess if you’re managing a top-flight sports team, fatiguing 1/3 of a standard deviation faster than one of your opponents could make quite a substantial difference to your performance and team rotation over the season.

## Task 4.3

> Calculate and interpret Cohen’s *d* for the difference in the mean duration of the celebrity marriages in Chapter 1 (Task 9) and me and my friend’s marriages (Chapter 2, Task 13). 

Cohen’s *d*  is defined as:

$$ \hat{d} = \frac{\bar{X_1}-\bar{X_2}}{s} $$
 
There isn’t an obvious control group, so let's use a pooled estimate of the standard deviation:

$$ \begin{aligned} s_p &= \sqrt{\frac{(N_1-1) s_1^2+(N_2-1) s_2^2}{N_1+N_2-2}} \\\\
&= \sqrt{\frac{(11-1)476.29^2+(9-1)8275.91^2}{11+9-2}} \\\\
&= \sqrt{\frac{550194093}{18}} \\\\
&= 5528.68 \end{aligned} $$

Therefore, Cohen’s *d* is:

$$ \hat{d} = \frac{5057-238.91}{5528.68} = 0.87 $$
Therefore, my friend’s marriages are 0.87 standard deviations longer than the sample of celebrities. By the benchmarks that we probably shouldn’t use, this is a large effect.

## Task 4.4

> What are the problems with null hypothesis significance testing?

- We can’t conclude that an effect is important because the p-value from which we determine significance is affected by sample size. Therefore, the word ‘significant’ is meaningless when referring to a p-value.
- The null hypothesis is never true. If the p-value is greater than .05 then we can decide to reject the alternative hypothesis, but this is not the same thing as the null hypothesis being true: a non-significant result tells us is that the effect is not big enough to be found but it doesn’t tell us that the effect is zero. 
- A significant result does not tell us that the null hypothesis is false (see text for details).
- It encourages all or nothing thinking: if *p* < 0.05 then an effect is significant, but if *p* > 0.05 it is not. So, a *p* = 0.0499 is significant but a *p* = 0.0501 is not, even though these ps differ by only 0.0002. 

## Task 4.5

> What is the difference between a confidence interval and a credible interval?

A 95% confidence interval is set so that before the data are collected there is a long-run probability of 0.95 (or 95%) that the interval will contain the true value of the parameter. This means that in 100 random samples, the intervals will contain the true value in 95 of them but won’t in 5. Once the data are collected, your sample is either one of the 95% that produces an interval containing the true value, or one of the 5% that does not. In other words, having collected the data, the probability of the interval containing the true value of the parameter is either 0 (it does not contain it) or 1 (it does contain it), but you do not know which. A credible interval is different in that it reflects the plausible probability that the interval contains the true value. For example, a 95% credible interval has a plausible 0.95 probability of containing the true value.

## Task 4.6

> What is a meta-analysis?

Meta-analysis is where effect sizes from different studies testing the same hypothesis are combined to get a better estimate of the size of the effect in the population.

## Task 4.7

> What does a Bayes factor tell us?

The Bayes factor is the ratio of the probability of the data given the alternative hypothesis to that of the data given the null hypothesis. A Bayes factor less than 1 supports the null hypothesis (it suggests the data are more likely given the null hypothesis than the alternative hypothesis); conversely, a Bayes factor greater than 1 suggests that the observed data are more likely given the alternative hypothesis than the null. Values between 1 and 3 are considered evidence for the alternative hypothesis that is ‘barely worth mentioning’, values between 3 and 10 are considered to indicate evidence for the alternative hypothesis that ‘has substance’, and values greater than 10 are strong evidence for the alternative hypothesis.

## Task 4.8

> Various studies have shown that students who use laptops in class often do worse on their modules (Payne-Carter, Greenberg, & Walker, 2016; Sana, Weston, & Cepeda, 2013). Table 4.3 shows some fabricated data that mimics what has been found. What is the odds ratio for passing the exam if the student uses a laptop in class compared to if they don’t?





Table: (\#tab:t8.xtble)Table 4.1 (reproduced): Number of people who passed or failed an exam classified by whether they take their laptop to class

|     | Laptop| No Laptop| Sum|
|:----|------:|---------:|---:|
|Pass |     24|        49|  73|
|Fail |     16|        11|  27|
|Sum  |     40|        60| 100|

First we compute the odds of passing when a laptop is used in class:

$$ \begin{aligned} \text{Odds}_{\text{pass when laptop is used}} &= \frac{\text{Number of laptop users passing exam}}{\text{Number of laptop users failing exam}} \\\\
&= \frac{24}{16} \\\\
&= 1.5 \end{aligned} $$

Next we compute the odds of passing when a laptop is *not* used in class:

$$ \begin{aligned} \text{Odds}_{\text{pass when laptop is not used}} &= \frac{\text{Number of students without laptops passing exam}}{\text{Number of students without laptops failing exam}} \\\\
&= \frac{49}{11} \\\\
&= 4.45 \end{aligned} $$

The odds ratio is the ratio of the two odds that we have just computed:

$$ \begin{aligned} \text{Odds Ratio} &= \frac{\text{Odds}_{\text{pass when laptop is used}}}{\text{Odds}_{\text{pass when laptop is not used}}} \\\\
&= \frac{1.5}{4.45} \\\\
&= 0.34 \end{aligned} $$

The odds of passing when using a laptop are 0.34 times those when a laptop is not used. If we take the reciprocal of this, we could say that the odds of passing when not using a laptop are 2.97 times those when a laptop is used.

## Task 4.9

> From the data in Table 4.1 (reproduced) what is the conditional probability that someone used a laptop given that they passed the exam, p(laptop|pass). What is the conditional probability of that someone didn’t use a laptop in class given they passed the exam, p(no laptop |pass)?

The conditional probability that someone used a laptop given they passed the exam is 0.33, or a 33% chance:
$$ \begin{aligned} p(\text{laptop|pass}) &= \frac{p(\text{laptop ∩ pass})}{p(\text{pass})} \\\\
&= \frac{{24}/{100}}{{73}/{100}} \\\\
&= \frac{0.24}{0.73} \\\\ 
&= 0.33 \end{aligned}$$`

The conditional probability that someone didn’t use a laptop in class given they passed the exam is 0.67 or a 67% chance.
$$ \begin{aligned} p(\text{no laptop|pass}) &=\frac{p(\text{no laptop ∩ pass})}{p(\text{pass})} \\\\
&=\frac{{49}/{100}}{{73}/{100}} \\\\
&=\frac{0.49}{0.73} \\\\
&=0.67 \end{aligned}$$`

## Task 4.10

> Using the data in Table 4.1 (reproduced), what are the posterior odds of someone using a laptop in class (compared to not using one) given that they passed the exam?

The posterior odds are the ratio of the posterior probability for one hypothesis to another. In this example it would be the ratio of the probability that a used a laptop given that they passed (which we have already calculated above to be 0.33) to the probability that they did not use a laptop in class given that they passed (which we have already calculated above to be 0.67). The value turns out to be 0.49, which means that the probability that someone used a laptop in class if they passed the exam is about half of the probability that someone didn’t use a laptop in class given that they passed the exam.

$$ \begin{aligned} \text{posterior odds} &= \frac{p(\text{hypothesis 1|data})}{p(\text{hypothesis 2|data})} \\\\
&= \frac{p(\text{laptop|pass})}{p(\text{no laptop| pass})} \\\\
&= \frac{0.33}{0.67} \\\\
&= 0.49 \end{aligned}$$`
