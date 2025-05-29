---
title: Labcoat Leni solutions Chapter 1
linktitle: Leni Chapter 1
toc: true
type: docs
date: "2020-07-07T00:00:00Z"
draft: false
menu:
  leni:
    parent: Labcoat Leni
    weight: 1

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 1

---

<img src="/img/leni_banner.png" alt = "Labcoat Leni character from Discovering Statistics using R and RStudio" width="600">

{{% alert note %}}

<p>This document contains abridged sections from <em>Discovering Statistics Using R and RStudio</em> by <a href="/index.html#about">Andy Field</a> so there are some copyright considerations. You can use this material for teaching and non-profit activities but please do not meddle with it or claim it as your own work. See the full license terms at the bottom of the page.</p>

{{% /alert %}}

There are several ways to enter the Oxoby data, here’s one of them:

``` r
oxoby_tib <- tibble::tibble(.rows = 36) |> 
  dplyr::mutate(
        singer = c(rep("Bon Scott", 18), rep("Brian Johnson", 18)) |> forcats::as_factor(),
        offer = c(1, 2, 2, 2, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 2, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5, 5, 5)
        ) 

# You can go on to save this tibble to a csv in your data folder using:

oxoby_tib |> 
  readr::write_csv(here::here("data/acdc.csv"))
```
