---
title: "discovr: a package of interactive tutorials"
output: 
  html_document
bibliography: [../../static/bib/milton_rocks.bib]
link-citations: true
---




<div style="float: right"><img src="/img/discovr_hex.png" width="150"></div>

## What is discovr?

The `discovr` package will contain tutorials associated with my textbook [Discovering Statistics using R and RStudio](https://www.discoveringstatistics.com/books/discovering-statistics-using-r/), due out in early 2021. It will include all datasets, but most important it will contain a series of interactive tutorials that teach {{< icon name="r-project" pack="fab" >}} alongside the chapters of the book. The tutorials are written using a package called [learnr](https://rstudio.github.io/learnr/). Once a tutorial is running it's a bit like reading excerpts of the book but with places where you can practice the R code that you have just been taught. The `discovr` package is free (as are all things {{< icon name="r-project" pack="fab" >}}-related) and offered to support tutors and students using my textbook.

## What are R and RStudio`?

If you're using a textbook about {{< icon name="r-project" pack="fab" >}} then you probably already know what it is. If not, [R](https://www.r-project.org/) is a free software environment for statistical analysis and graphics. RStudio is a user interface through which to use {{< icon name="r-project" pack="fab" >}}. RStudio adds functionality that make working with {{< icon name="r-project" pack="fab" >}} easier, more efficient, and generally more pleasant than working in {{< icon name="r-project" pack="fab" >}} alone.

You can get started with [R](https://www.r-project.org/) and [RStudio](https://www.rstudio.com/) by completing this tutorial (includes videos):

* [Getting started with R and RStudio interactive tutorial](http://milton-the-cat.rocks/learnr/r/r_getting_started/)
 
## Contents of discovr

The tutorials are named to correspond (roughly) to the relevant chapter of the book. For example, *discovr_04* would be a good tutorial to run alongside teaching related to chapter 4, and so on. Some longer chapters have several tutorials that break the content into more manageable chunks. Given the current global situation and the fact that lots of instructors are needing to teach remotely I may make what I have available in summer 2020 (for teaching in Autumn 2020), and update as and when I have new tutorials written.

* **discovr_01**: Key concepts in {{< icon name="r-project" pack="fab" >}} (functions and objects, packages and functions, style, data types, tidyverse, tibbles)
* **discovr_02**: Summarizing data (frequency distributions, grouped frequency distributions, relative frequencies, histograms, mean, median, variance, standard deviation, interquartile range)
* **discovr_03**: Confidence intervals: interactive app demonstrating what a confidence interval is, computing normal and bootstrap confidence intervals using R, adding confidence intervals to data summaries.
* **discovr_05**: Visualizing data. The ggplot2 package, boxplots, plotting means, violin plots, scatterplots, grouping by colour, grouping using facets, adjusting scales, adjusting positions."
* **discovr_06**: The beast of bias. Restructuring data from messy to tidy format (and back). Spotting outliers using histograms and boxplots. Calculating z-scores (standardizing scores). Writing your own function. Using z-scores to detect outliers. Q-Q plots. Calculating skewness, kurtosis and the number of valid cases. Grouping summary statistics by multiple categorical/grouping variables.
* **discovr_07**: Associations. Plotting data with GGally. Pearson's r, Spearman's Rho, Kendall's tau, robust correlations.
* **discovr_08**: The general linear model (GLM). Visualizing the data, fitting GLMs with one and two predictors. Viewing model parameters with broom, model parameters, standard errors, confidence intervals, fit statistics, significance.
* **discovr_09**: Categorical predictors with two categories (comparing two means). Comparing two independent means, comparing two related means, effect sizes.
* **discovr_10**: Moderation and mediation. Centring variables (grand mean centring), specifying interaction terms, moderation analysis, simple slopes analysis, Johnson-Neyman intervals, mediation with one predictor, direct and indirect effects, mediation using lavaan.


## Installing discovr

<p style =   "border-radius: 10px; padding: 10px; border: 2px solid #CA3E34; background-color: #CA3E34; background-color: rgba(202, 62, 52, 0.1); color: #CA3E34;"> **NOTE**: This package is incomplete but under active development. I have released it early in case it is useful for instructors needing to move rapidly to remote learning because of the current global pandemic. Check [the GitHub page](https://github.com/profandyfield/discovr) for updates/new tutorials.</p>

To use `discovr` you first need to install {{< icon name="r-project" pack="fab" >}} and RStudio. To learn how to do this and to get oriented with {{< icon name="r-project" pack="fab" >}} and RStudio complete my interactive tutorial, [getting started with R and RStudio](/learnr/r/r_getting_started/).

You can get the development version of the package from [github.com/profandyfield/discovr](https://github.com/profandyfield/discovr). 


## Running a tutorial

In RStudio Version 1.3 onwards there is a tutorial pane. Having executed

```
library(discovr)
```

A list of tutorials appears in this pane. Scroll through them and click on the <img src="/img/start_tutorial.png" alt="Start tutorial button" width="64" style="display: inline-block"> button to run the tutorial:

<img src="/img/run_tutorial_pane_discovr.png" width="700">

Alternatively, to run a particular tutorial from the console execute:

```
library(discovr)
learnr::run_tutorial("name_of_tutorial", package = "discovr")
```

and replace "name of tutorial" with the name of the tutorial you want to run. For example, to run tutorial 3 (for Chapter 3) execute:

```
learnr::run_tutorial("discovr_03", package = "discovr")
```

The name of each tutorial is in bold in the list above. Once the command to run the tutorial is executed it will spring to life in the tutorial pane.


## Suggested workflow

The tutorials are self-contained (you practice code in code boxes) so you don't need to use RStudio at the same time. However, to get the most from them I would recommend that you create an RStudio project and within that open (and save) a new RMarkdown file each time to work through a tutorial. Within that Markdown file, replicate parts of the code from the tutorial (in code chunks) and use Markdown to write notes about what you have done, and to reflect on things that you have struggled with, or note useful tips to help you remember things. Basically, write a learning journal. This workflow has the advantage of not just teaching you the code that you need to do certain things, but also provides practice in using RStudio itself.

Here's a video explaining how I use my other package of tutorials, [adventr](adventr.html), within my own classes. I'd adopt the same workflow with `discovr`.

<!--html_preserve--><iframe src="https://www.youtube.com/embed/FE0ntX0dyc4" width="420" height="315" frameborder="0" allowfullscreen=""></iframe><!--/html_preserve-->


## Other resources
### Statistics

* The tutorials typically follow examples described in detail in [Discovering Statistics using R and RStudio](https://www.discoveringstatistics.com/books/discovering-statistics-using-r/). That book covers the theoretical side of the statistical models, and has more depth on conducting and interpreting the models in these tutorials.
* If any of the statistical content doesn't make sense, you could try my more introductory book [An adventure in statistics](https://www.discoveringstatistics.com/books/an-adventure-in-statistics/).
* There are free lectures and screencasts on my [YouTube channel](https://www.youtube.com/user/ProfAndyField/).
* There are free statistical resources on my websites [www.discoveringstatistics.com](http://www.discoveringstatistics.com) and [milton-the-cat.rocks](http://milton-the-cat.rocks).

### {{< icon name="r-project" pack="fab" >}}

* [R for data science](http://r4ds.had.co.nz/index.html) by is an open-access book by the creator of the tidyverse (Hadley Wickham). It covers the *tidyverse* and data management.
* [ModernDive](http://moderndive.com/index.html) is an open-access textbook on {{< icon name="r-project" pack="fab" >}} and RStudio.
* [RStudio cheat sheets](https://www.rstudio.com/resources/cheatsheets/).
* [RStudio list of online resources](https://www.rstudio.com/online-learning/).

## References


