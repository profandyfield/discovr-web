---
title: R code Chapter 1
linktitle: Code Chapter 1
toc: true
type: docs
date: "2020-07-07T00:00:00Z"
draft: false
menu:
  code:
    parent: R Code
    weight: 1

# Prev/next pager order (if `docs_section_pager` enabled in `params.toml`)
weight: 1

---

<img src="/img/space_pirate.png" alt = "Mae Jemstone character from Discovering Statistics using R and RStudio" width="200">

{{% alert note %}}

<p>This document contains abridged sections from <em>Discovering Statistics Using R and RStudio</em> by <a href="/index.html#about">Andy Field</a> so there are some copyright considerations. You can use this material for teaching and non-profit activities but please do not meddle with it or claim it as your own work. See the full license terms at the bottom of the page.</p>

{{% /alert %}}

``` r
# Make sure to load this packages
library(tidyverse)
```

## Functions and objects

``` r
metallica <- c("Lars","James","Jason", "Kirk")
metallica <- metallica[metallica != "Jason"]
metallica <- c(metallica, "Rob")

print(metallica)
```

    ## [1] "Lars"  "James" "Kirk"  "Rob"

``` r
metallica |> print()
```

    ## [1] "Lars"  "James" "Kirk"  "Rob"

## R markdown

### Basic text formatting

-   Italic (\*): `Make text *italic* by placing it between asterisks (with no spaces)` will knit as: Make text *italic* by placing it between asterisks (with no spaces)
-   Bold (\*\*): `Make text **bold** by placing it between asterisks (with no spaces)` will knit as: Make text **bold** by placing it between asterisks (with no spaces)
-   Superscript (^^): `Make text^superscript^ by placing it between carats (with no spaces)` will knit as: Make text<sup>superscript</sup> by placing it between asterisks (with no spaces)
-   Subscript (\~\~): `Make text~subscript~ by placing it between tildes (with no spaces)` will knit as: Make text<sub>subscript</sub> by placing it between tildes (with no spaces)
-   Footnote \[^\1\]: `A footnote[^1] and a second footnote[^2]` will knit as: A footnote[^1] and a second footnote[^2]

### Headings

You can use hashes to make headings of different levels. For example:

    # Level 1 heading
    ## Level 2 heading
    ### Level 3 heading
    #### Level 4 heading
    ##### Level 5 heading
    ###### Level 6 heading

will knit as:

# Level 1 heading

## Level 2 heading

### Level 3 heading

#### Level 4 heading

##### Level 5 heading

###### Level 6 heading

### Bullet lists

Single bullet lists, this:

    * This is the first bullet
    * This is the second
    * This is the third

will knit as:

-   This is the first bullet
-   This is the second
-   This is the third

Numbered bullet lists, this:

    1. This is the first entry
    2. This is the second
    3. This is the third

will knit as:

1.  This is the first entry
2.  This is the second
3.  This is the third

Complex lists. This:

    * This is the first bullet point
        + this is a sub-bullet
        + so is this
    * This is the second bullet
        + This is a sub-bullet
            - I've gone crazy and done a third level of bullets
            - It had to be done
    * and this is the third

will knit as:

-   This is the first bullet point
    -   this is a sub-bullet
    -   so is this
-   This is the second bullet
    -   This is a sub-bullet
        -   I’ve gone crazy and done a third level of bullets
        -   It had to be done
-   and this is the third

### Hyperlinks

You use `[text do display](web address)` to insert hyperlinks. For example:

`My favourite band is [Iron Maiden](https://ironmaiden.com/)` will knit as:

My favourite band is [Iron Maiden](https://ironmaiden.com/)

### Images

You use `![Image caption (optional)](path to image)` to insert images. For example:

`![Figure 1: I love my spaniel](andy_milton.png)` knits as:

{{\< figure library=“true” src=“andy_milton.png” title=“Figure 1: I love my spaniel” lightbox=“true” \>}}

### Tables

Insert tables using raw text. \| denotes a column and the colon position denotes the alignment of the column, for example `|---:|` is right justified, `|:---|` is left justified, and `|:---:|` is centred.

    : My top 3 Iron Maiden albums

    | Name                   | Year   | Cover rating | Favourite track |
    |:-----------------------|:----:|------:|:--------------------------------:|
    |Piece of mind           | 1983 | ****  | The Flight of Icarus             |
    |The Number of the beast | 1982 | ****  | Children of the damned           |
    |Powerslave              | 1984 | ***** | The rime of the ancient mariner  |

knits as:

| Name                      |  Year  | Cover rating |          Favourite track          |
|:--------------------------|:------:|-------------:|:---------------------------------:|
| “Piece of mind”           | “1983” |   “\*\*\*\*” |      “The Flight of Icarus”       |
| “The Number of the beast” | “1982” |   “\*\*\*\*” |     “Children of the damned”      |
| “Powerslave”              | “1984” | “\*\*\*\*\*” | “The rime of the ancient mariner” |

My top 3 Iron Maiden albums

Alternative, put your data in a tibble (more on this later) and use `knitr::kable()`:

    tibble::tribble(
    ~Name, ~Year, ~`Cover rating`, ~`Favourite track`,
    "Piece of mind", "1983",  "****", "The Flight of Icarus",
    "The Number of the beast", "1982", "****", "Children of the damned",
    "Powerslave", "1984", "*****", "The rime of the ancient mariner"
    ) |> 
    knitr::kable(caption = "My top 3 Iron Maiden albums")

will knit as:

``` r
tibble::tribble(
~Name, ~Year, ~`Cover rating`, ~`Favourite track`,
"Piece of mind", "1983",  "****", "The Flight of Icarus",
"The Number of the beast", "1982", "****", "Children of the damned",
"Powerslave", "1984", "*****", "The rime of the ancient mariner"
) |> 
knitr::kable(caption = "My top 3 Iron Maiden albums")
```

| Name                    | Year | Cover rating | Favourite track                 |
|:------------------------|:-----|:-------------|:--------------------------------|
| Piece of mind           | 1983 | \*\*\*\*     | The Flight of Icarus            |
| The Number of the beast | 1982 | \*\*\*\*     | Children of the damned          |
| Powerslave              | 1984 | \*\*\*\*\*   | The rime of the ancient mariner |

Table 1: My top 3 Iron Maiden albums

### Equations

You can include equations in R markdown using latex commands. You include an equation by enclosing it within `$$` (or a single `$` if you want the equation within the line of text you’re writing). To give you a flavour:

    We can include the linear model in a sentence like this: $Y_i = b_0 + b_1X_i + \epsilon_i$

which will knit as:

We can include the linear model in a sentence like this: \$ Y_i = b_0 + b_1X_i + \_i \$

Or, if we want it within its own paragraph we’d write it as this:

    $$
    Y_i = b_0 + b_1X_i + \epsilon_i
    $$

which knits as:

$$
Y_i = b_0 + b_1X_i + \epsilon_i
$$

## Tidyverse and the pipe operator (\|\>)

``` r
core_members <- metallica |> 
  subset(metallica != "Rob") |> 
  sort()

core_members
```

    ## [1] "James" "Kirk"  "Lars"

## Getting data into R

``` r
name <- c("Lars Ulrich","James Hetfield", "Kirk Hammett", "Rob Trujillo", "Jason Newsted", "Cliff Burton", "Dave Mustaine")

# Numeric variables stored as double
songs_written <-  c(111, 112, 56, 16, 3, 11, 6)
net_worth <- c(300000000, 300000000, 200000000, 20000000, 40000000, 1000000, 20000000)

# Numeric variables stored as integer
songs_written_int <-  c(111L, 112L, 56L, 16L, 3L, 11L, 6L)
net_worth_int <- c(300000000L, 300000000L, 200000000L, 20000000L, 40000000L, 1000000L, 20000000L)

# Date variables
birth_date <- c("1963-12-26", "1963-08-03", "1962-11-18", "1964-10-23", "1963-03-04", "1962-02-10", "1961-09-13") |> lubridate::ymd()

death_date <- c(NA, NA, NA, NA, NA, "1986-09-27", NA) |> 
  lubridate::ymd()

# Logical variables
current_member <- c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE)

# Factor variables
instrument <- c(2, 0, 0, 1, 1, 1, 0) |> factor(levels = 0:2, labels = c("Guitar", "Bass", "Drums"))


instrument <- c("Drums", "Guitar", "Guitar", "Bass", "Bass", "Bass", "Guitar") |>
  forcats::as_factor() |>
  forcats::fct_relevel("Guitar", "Bass", "Drums")

levels(instrument)
```

    ## [1] "Guitar" "Bass"   "Drums"

``` r
levels(instrument) <- c("Proper guitar", "Bass guitar", "Drums") 
```

## Tibbles and data frames

### Creating data frames

``` r
metalli_dat <- data.frame(name, birth_date, death_date, instrument, current_member, songs_written, net_worth)
```

### Creating tibbles

``` r
metalli_tib <- tibble::tibble(name, birth_date, death_date, instrument, current_member, songs_written, net_worth)
```

### Viewing dataframes and tibbles

``` r
metalli_tib
```

    ## # A tibble: 7 × 7
    ##   name           birth_date death_date instrument    current_m…¹ songs…² net_w…³
    ##   <chr>          <date>     <date>     <fct>         <lgl>         <dbl>   <dbl>
    ## 1 Lars Ulrich    1963-12-26 NA         Drums         TRUE            111     3e8
    ## 2 James Hetfield 1963-08-03 NA         Proper guitar TRUE            112     3e8
    ## 3 Kirk Hammett   1962-11-18 NA         Proper guitar TRUE             56     2e8
    ## 4 Rob Trujillo   1964-10-23 NA         Bass guitar   TRUE             16     2e7
    ## 5 Jason Newsted  1963-03-04 NA         Bass guitar   FALSE             3     4e7
    ## 6 Cliff Burton   1962-02-10 1986-09-27 Bass guitar   FALSE            11     1e6
    ## 7 Dave Mustaine  1961-09-13 NA         Proper guitar FALSE             6     2e7
    ## # … with abbreviated variable names ¹​current_member, ²​songs_written, ³​net_worth

``` r
# View(metalli_tib) 
```

### Creating an empty tibble

``` r
#to create an empty tibble called empty_tib that has 50 rows, execute:

empty_tib <- tibble::tibble(.rows = 10)
```

### Creating new variables within a tibble

Using base R:

``` r
metalli_tib$albums <-  c(10, 10, 10, 2, 4, 3, 0)
```

Using `dplyrr:mutate()`:

``` r
metalli_tib <- metalli_tib |> 
  dplyr::mutate(
        albums = c(10, 10, 10, 2, 4, 3, 0)
  )

metalli_tib
```

    ## # A tibble: 7 × 8
    ##   name           birth_date death_date instrument curre…¹ songs…² net_w…³ albums
    ##   <chr>          <date>     <date>     <fct>      <lgl>     <dbl>   <dbl>  <dbl>
    ## 1 Lars Ulrich    1963-12-26 NA         Drums      TRUE        111     3e8     10
    ## 2 James Hetfield 1963-08-03 NA         Proper gu… TRUE        112     3e8     10
    ## 3 Kirk Hammett   1962-11-18 NA         Proper gu… TRUE         56     2e8     10
    ## 4 Rob Trujillo   1964-10-23 NA         Bass guit… TRUE         16     2e7      2
    ## 5 Jason Newsted  1963-03-04 NA         Bass guit… FALSE         3     4e7      4
    ## 6 Cliff Burton   1962-02-10 1986-09-27 Bass guit… FALSE        11     1e6      3
    ## 7 Dave Mustaine  1961-09-13 NA         Proper gu… FALSE         6     2e7      0
    ## # … with abbreviated variable names ¹​current_member, ²​songs_written, ³​net_worth

You can create your data set by initializing a tibble and then defining each variable. Note that in this context we use `=` rather than `<-` to assign values to each variable, and that each variable definition ends with a comma (except the last). For example, we can create `metalli_tib` from scratch as follows:

``` r
metalli_tib <- tibble::tibble(
    name = c("Lars Ulrich","James Hetfield", "Kirk Hammett", "Rob Trujillo", "Jason Newsted", "Cliff Burton", "Dave Mustaine"),
    birth_date = c("1963-12-26", "1963-08-03", "1962-11-18", "1964-10-23", "1963-03-04", "1962-02-10", "1961-09-13") |> lubridate::ymd(),
    death_date = c(NA, NA, NA, NA, NA, "1986-09-27", NA) |> 
  lubridate::ymd(),
  instrument = c("Drums", "Guitar", "Guitar", "Bass", "Bass", "Bass", "Guitar") |>
  forcats::as_factor() |> forcats::fct_relevel("Guitar", "Bass", "Drums"),
  current_member = c(TRUE, TRUE, TRUE, TRUE, FALSE, FALSE, FALSE),
  songs_written =  c(111, 112, 56, 16, 3, 11, 6),
net_worth = c(300000000, 300000000, 200000000, 20000000, 40000000, 1000000, 20000000)
  )
```

and now add one that quantifies how much they have earned per song that they contributed to:

``` r
metalli_tib <- metalli_tib |> 
  dplyr::mutate(
        worth_per_song = net_worth/songs_written
  )
metalli_tib
```

    ## # A tibble: 7 × 8
    ##   name           birth_date death_date instrum…¹ curre…² songs…³ net_w…⁴ worth…⁵
    ##   <chr>          <date>     <date>     <fct>     <lgl>     <dbl>   <dbl>   <dbl>
    ## 1 Lars Ulrich    1963-12-26 NA         Drums     TRUE        111     3e8  2.70e6
    ## 2 James Hetfield 1963-08-03 NA         Guitar    TRUE        112     3e8  2.68e6
    ## 3 Kirk Hammett   1962-11-18 NA         Guitar    TRUE         56     2e8  3.57e6
    ## 4 Rob Trujillo   1964-10-23 NA         Bass      TRUE         16     2e7  1.25e6
    ## 5 Jason Newsted  1963-03-04 NA         Bass      FALSE         3     4e7  1.33e7
    ## 6 Cliff Burton   1962-02-10 1986-09-27 Bass      FALSE        11     1e6  9.09e4
    ## 7 Dave Mustaine  1961-09-13 NA         Guitar    FALSE         6     2e7  3.33e6
    ## # … with abbreviated variable names ¹​instrument, ²​current_member,
    ## #   ³​songs_written, ⁴​net_worth, ⁵​worth_per_song

### Entering data directly into a tibble

You can enter the data directly as a tibble (rather than creating an empty one and using `dplyr::mutate()`:

``` r
metalli_tib <- tibble::tribble(
  ~name, ~birth_date, ~death_date, ~instrument, ~current_member, ~songs_written, ~net_worth,
  "Lars Ulrich", "1963-12-26", NA, "Drums", TRUE, 111, 300000000,
  "James Hetfield", "1963-08-03", NA, "Guitar", TRUE, 112, 300000000,
  "Kirk Hammett", "1962-11-18", NA, "Guitar", TRUE, 56, 200000000,
  "Rob Trujillo", "1964-10-23", NA, "Bass",  TRUE, 16, 20000000,
  "Jason Newsted", "1963-03-04", NA, "Bass", FALSE, 3, 40000000,
  "Cliff Burton", "1962-02-10", "1986-09-27", "Bass", FALSE, 11, 1000000,
  "Dave Mustaine", "1961-09-13", NA, "Guitar", FALSE, 6, 20000000
  ) |> 
  dplyr::mutate(
    birth_date = lubridate::ymd(birth_date),
    death_date = lubridate::ymd(death_date)
  )
```

### Finding a cell of a data frame or tibble

Three ways to discover which instrument Lars Ulrich ‘plays’:

``` r
metalli_tib[1, 4]
```

    ## # A tibble: 1 × 1
    ##   instrument
    ##   <chr>     
    ## 1 Drums

``` r
metalli_tib[1, "instrument"]
```

    ## # A tibble: 1 × 1
    ##   instrument
    ##   <chr>     
    ## 1 Drums

``` r
metalli_tib[name == "Lars Ulrich", "instrument"]
```

    ## # A tibble: 1 × 1
    ##   instrument
    ##   <chr>     
    ## 1 Drums

### Selecting variables

Using base R

``` r
# These commands return the contents of the variable called 'name'
metalli_tib$name
```

    ## [1] "Lars Ulrich"    "James Hetfield" "Kirk Hammett"   "Rob Trujillo"  
    ## [5] "Jason Newsted"  "Cliff Burton"   "Dave Mustaine"

``` r
metalli_tib[1]
```

    ## # A tibble: 7 × 1
    ##   name          
    ##   <chr>         
    ## 1 Lars Ulrich   
    ## 2 James Hetfield
    ## 3 Kirk Hammett  
    ## 4 Rob Trujillo  
    ## 5 Jason Newsted 
    ## 6 Cliff Burton  
    ## 7 Dave Mustaine

``` r
metalli_tib["name"]
```

    ## # A tibble: 7 × 1
    ##   name          
    ##   <chr>         
    ## 1 Lars Ulrich   
    ## 2 James Hetfield
    ## 3 Kirk Hammett  
    ## 4 Rob Trujillo  
    ## 5 Jason Newsted 
    ## 6 Cliff Burton  
    ## 7 Dave Mustaine

``` r
# Both of these commands return the contents of the variables called 'name' and instrument
metalli_tib[c(1, 4)]
```

    ## # A tibble: 7 × 2
    ##   name           instrument
    ##   <chr>          <chr>     
    ## 1 Lars Ulrich    Drums     
    ## 2 James Hetfield Guitar    
    ## 3 Kirk Hammett   Guitar    
    ## 4 Rob Trujillo   Bass      
    ## 5 Jason Newsted  Bass      
    ## 6 Cliff Burton   Bass      
    ## 7 Dave Mustaine  Guitar

``` r
metalli_tib[c("name", "instrument")]
```

    ## # A tibble: 7 × 2
    ##   name           instrument
    ##   <chr>          <chr>     
    ## 1 Lars Ulrich    Drums     
    ## 2 James Hetfield Guitar    
    ## 3 Kirk Hammett   Guitar    
    ## 4 Rob Trujillo   Bass      
    ## 5 Jason Newsted  Bass      
    ## 6 Cliff Burton   Bass      
    ## 7 Dave Mustaine  Guitar

The tidyverse way

``` r
metalli_tib |> 
  dplyr::select(name, instrument)
```

    ## # A tibble: 7 × 2
    ##   name           instrument
    ##   <chr>          <chr>     
    ## 1 Lars Ulrich    Drums     
    ## 2 James Hetfield Guitar    
    ## 3 Kirk Hammett   Guitar    
    ## 4 Rob Trujillo   Bass      
    ## 5 Jason Newsted  Bass      
    ## 6 Cliff Burton   Bass      
    ## 7 Dave Mustaine  Guitar

You can exclude variables too, try these out:

``` r
metalli_tib |> 
  dplyr::select(-name)
```

    ## # A tibble: 7 × 6
    ##   birth_date death_date instrument current_member songs_written net_worth
    ##   <date>     <date>     <chr>      <lgl>                  <dbl>     <dbl>
    ## 1 1963-12-26 NA         Drums      TRUE                     111 300000000
    ## 2 1963-08-03 NA         Guitar     TRUE                     112 300000000
    ## 3 1962-11-18 NA         Guitar     TRUE                      56 200000000
    ## 4 1964-10-23 NA         Bass       TRUE                      16  20000000
    ## 5 1963-03-04 NA         Bass       FALSE                      3  40000000
    ## 6 1962-02-10 1986-09-27 Bass       FALSE                     11   1000000
    ## 7 1961-09-13 NA         Guitar     FALSE                      6  20000000

``` r
metalli_tib |> 
  dplyr::select(-c(name, instrument))
```

    ## # A tibble: 7 × 5
    ##   birth_date death_date current_member songs_written net_worth
    ##   <date>     <date>     <lgl>                  <dbl>     <dbl>
    ## 1 1963-12-26 NA         TRUE                     111 300000000
    ## 2 1963-08-03 NA         TRUE                     112 300000000
    ## 3 1962-11-18 NA         TRUE                      56 200000000
    ## 4 1964-10-23 NA         TRUE                      16  20000000
    ## 5 1963-03-04 NA         FALSE                      3  40000000
    ## 6 1962-02-10 1986-09-27 FALSE                     11   1000000
    ## 7 1961-09-13 NA         FALSE                      6  20000000

You can save a subsetted tibble to a new object:

``` r
# Save a version of metalli_tib but exclude the variable called name

metalli_anon_tib <- metalli_tib |> 
  dplyr::select(-name)

#View this new object
metalli_anon_tib
```

    ## # A tibble: 7 × 6
    ##   birth_date death_date instrument current_member songs_written net_worth
    ##   <date>     <date>     <chr>      <lgl>                  <dbl>     <dbl>
    ## 1 1963-12-26 NA         Drums      TRUE                     111 300000000
    ## 2 1963-08-03 NA         Guitar     TRUE                     112 300000000
    ## 3 1962-11-18 NA         Guitar     TRUE                      56 200000000
    ## 4 1964-10-23 NA         Bass       TRUE                      16  20000000
    ## 5 1963-03-04 NA         Bass       FALSE                      3  40000000
    ## 6 1962-02-10 1986-09-27 Bass       FALSE                     11   1000000
    ## 7 1961-09-13 NA         Guitar     FALSE                      6  20000000

### Selecting cases (filtering tibbles)

Using base R we can do the following. View only the data for the current members of metallica:

``` r
metalli_tib[current_member == TRUE,]
```

    ## # A tibble: 4 × 7
    ##   name           birth_date death_date instrument current_member songs…¹ net_w…²
    ##   <chr>          <date>     <date>     <chr>      <lgl>            <dbl>   <dbl>
    ## 1 Lars Ulrich    1963-12-26 NA         Drums      TRUE               111     3e8
    ## 2 James Hetfield 1963-08-03 NA         Guitar     TRUE               112     3e8
    ## 3 Kirk Hammett   1962-11-18 NA         Guitar     TRUE                56     2e8
    ## 4 Rob Trujillo   1964-10-23 NA         Bass       TRUE                16     2e7
    ## # … with abbreviated variable names ¹​songs_written, ²​net_worth

View only the instruments played by the current members of metallica:

``` r
metalli_tib[current_member == TRUE, "instrument"]
```

    ## # A tibble: 4 × 1
    ##   instrument
    ##   <chr>     
    ## 1 Drums     
    ## 2 Guitar    
    ## 3 Guitar    
    ## 4 Bass

View only the names, instruments played, and number of songs written by the current members of metallica:

``` r
metalli_tib[current_member == TRUE, c("name", "instrument", "songs_written")]
```

    ## # A tibble: 4 × 3
    ##   name           instrument songs_written
    ##   <chr>          <chr>              <dbl>
    ## 1 Lars Ulrich    Drums                111
    ## 2 James Hetfield Guitar               112
    ## 3 Kirk Hammett   Guitar                56
    ## 4 Rob Trujillo   Bass                  16

``` r
metalli_tib[songs_written > 50,]
```

    ## # A tibble: 3 × 7
    ##   name           birth_date death_date instrument current_member songs…¹ net_w…²
    ##   <chr>          <date>     <date>     <chr>      <lgl>            <dbl>   <dbl>
    ## 1 Lars Ulrich    1963-12-26 NA         Drums      TRUE               111     3e8
    ## 2 James Hetfield 1963-08-03 NA         Guitar     TRUE               112     3e8
    ## 3 Kirk Hammett   1962-11-18 NA         Guitar     TRUE                56     2e8
    ## # … with abbreviated variable names ¹​songs_written, ²​net_worth

Using `dplyr::filter()`

``` r
dplyr::filter(metalli_tib, current_member == TRUE)
```

    ## # A tibble: 4 × 7
    ##   name           birth_date death_date instrument current_member songs…¹ net_w…²
    ##   <chr>          <date>     <date>     <chr>      <lgl>            <dbl>   <dbl>
    ## 1 Lars Ulrich    1963-12-26 NA         Drums      TRUE               111     3e8
    ## 2 James Hetfield 1963-08-03 NA         Guitar     TRUE               112     3e8
    ## 3 Kirk Hammett   1962-11-18 NA         Guitar     TRUE                56     2e8
    ## 4 Rob Trujillo   1964-10-23 NA         Bass       TRUE                16     2e7
    ## # … with abbreviated variable names ¹​songs_written, ²​net_worth

``` r
# Or using a pipe:

metalli_tib |> 
  dplyr::filter(current_member == TRUE)
```

    ## # A tibble: 4 × 7
    ##   name           birth_date death_date instrument current_member songs…¹ net_w…²
    ##   <chr>          <date>     <date>     <chr>      <lgl>            <dbl>   <dbl>
    ## 1 Lars Ulrich    1963-12-26 NA         Drums      TRUE               111     3e8
    ## 2 James Hetfield 1963-08-03 NA         Guitar     TRUE               112     3e8
    ## 3 Kirk Hammett   1962-11-18 NA         Guitar     TRUE                56     2e8
    ## 4 Rob Trujillo   1964-10-23 NA         Bass       TRUE                16     2e7
    ## # … with abbreviated variable names ¹​songs_written, ²​net_worth

Again, we can save the filtered tibble to a new object:

``` r
metallica_current <- metalli_tib |> 
  dplyr::filter(current_member == TRUE)

metallica_current
```

    ## # A tibble: 4 × 7
    ##   name           birth_date death_date instrument current_member songs…¹ net_w…²
    ##   <chr>          <date>     <date>     <chr>      <lgl>            <dbl>   <dbl>
    ## 1 Lars Ulrich    1963-12-26 NA         Drums      TRUE               111     3e8
    ## 2 James Hetfield 1963-08-03 NA         Guitar     TRUE               112     3e8
    ## 3 Kirk Hammett   1962-11-18 NA         Guitar     TRUE                56     2e8
    ## 4 Rob Trujillo   1964-10-23 NA         Bass       TRUE                16     2e7
    ## # … with abbreviated variable names ¹​songs_written, ²​net_worth

Combining conditions:

``` r
metalli_tib |> 
  dplyr::filter(is.na(death_date) & instrument == "Bass guitar")
```

    ## # A tibble: 0 × 7
    ## # … with 7 variables: name <chr>, birth_date <date>, death_date <date>,
    ## #   instrument <chr>, current_member <lgl>, songs_written <dbl>,
    ## #   net_worth <dbl>

If we change `is.na()` to `!is.na()` we get Cliff Burton’s data (the only member who is a bassist and does NOT have a value of ‘NA’ for the variable death_date):

``` r
metalli_tib |> 
  dplyr::filter(!is.na(death_date) & instrument == "Bass guitar")
```

    ## # A tibble: 0 × 7
    ## # … with 7 variables: name <chr>, birth_date <date>, death_date <date>,
    ## #   instrument <chr>, current_member <lgl>, songs_written <dbl>,
    ## #   net_worth <dbl>

We can also use the OR operator (\|) to set conditions for which only one has to be true. For example, to select members who are either bassists OR drummers we’d use:

``` r
metalli_tib |> 
  dplyr::filter(instrument == "Drums" | instrument == "Bass guitar")
```

    ## # A tibble: 1 × 7
    ##   name        birth_date death_date instrument current_member songs_wr…¹ net_w…²
    ##   <chr>       <date>     <date>     <chr>      <lgl>               <dbl>   <dbl>
    ## 1 Lars Ulrich 1963-12-26 NA         Drums      TRUE                  111     3e8
    ## # … with abbreviated variable names ¹​songs_written, ²​net_worth

### Combining selecting cases with selecting variables

This command filters `metalli_tib` according to whether the variable `current_member` is equal to TRUE and whether the variable `instrument` is NOT equal to (`!=`) the phrase “Bass guitar”:

``` r
metalli_worth  <- metalli_tib |> 
  dplyr::filter(current_member == TRUE & instrument != "Bass guitar")

metalli_worth
```

    ## # A tibble: 4 × 7
    ##   name           birth_date death_date instrument current_member songs…¹ net_w…²
    ##   <chr>          <date>     <date>     <chr>      <lgl>            <dbl>   <dbl>
    ## 1 Lars Ulrich    1963-12-26 NA         Drums      TRUE               111     3e8
    ## 2 James Hetfield 1963-08-03 NA         Guitar     TRUE               112     3e8
    ## 3 Kirk Hammett   1962-11-18 NA         Guitar     TRUE                56     2e8
    ## 4 Rob Trujillo   1964-10-23 NA         Bass       TRUE                16     2e7
    ## # … with abbreviated variable names ¹​songs_written, ²​net_worth

Having done this, we could pass the object `net_worth` object that we just created into the `select` function to select the variables `name` and `net_worth`:

``` r
metalli_worth  <- metalli_worth  |> 
  dplyr::select(name, net_worth)

metalli_worth
```

    ## # A tibble: 4 × 2
    ##   name           net_worth
    ##   <chr>              <dbl>
    ## 1 Lars Ulrich    300000000
    ## 2 James Hetfield 300000000
    ## 3 Kirk Hammett   200000000
    ## 4 Rob Trujillo    20000000

Better still, combine the two operations into a single pipe:

``` r
metalli_worth <- metalli_tib |> 
  dplyr::filter(current_member == TRUE & instrument != "Bass guitar") |> 
  dplyr::select(name, net_worth)

metalli_worth
```

    ## # A tibble: 4 × 2
    ##   name           net_worth
    ##   <chr>              <dbl>
    ## 1 Lars Ulrich    300000000
    ## 2 James Hetfield 300000000
    ## 3 Kirk Hammett   200000000
    ## 4 Rob Trujillo    20000000

Doing the same with base R will make your eyes hurt

``` r
metalli_worth <- metalli_tib[current_member == TRUE & instrument != "Bass guitar", c("name", "net_worth")]
metalli_worth
```

    ## # A tibble: 3 × 2
    ##   name           net_worth
    ##   <chr>              <dbl>
    ## 1 Lars Ulrich    300000000
    ## 2 James Hetfield 300000000
    ## 3 Kirk Hammett   200000000

### Exporting data

``` r
readr::write_csv(metalli_tib, "../data/metallica.csv")

# or 

readr::write_csv(metalli_tib, here::here("/data/metallica.csv"))
```

## Using other software to get data in R

``` r
metalli_tib <- readr::read_csv("../data/metallica.csv")

# or 

metalli_tib <- here::here("/data/metallica.csv") |> readr::read_csv()
```

We can specify data types:

``` r
metalli_tib <- readr::read_csv("../data/metallica.csv", col_types = cols(
  name = col_character(),
  birth_date = col_date(),
  death_date = col_date(),
  instrument = col_factor(),
  current_member = col_logical(),
  songs_written = col_double(),
  net_worth = col_double()
  )
)

#OR

metalli_tib <- readr::read_csv("../data/metallica.csv", col_types = "cDDfldd")

# OR

metalli_tib <- readr::read_csv("../data/metallica.csv") |> 
  dplyr::mutate(
    instrument = forcats::as_factor(instrument)
  )

metalli_tib$instrument
```

------------------------------------------------------------------------

## Pieces of great

### Pieces of great 1.5

``` r
husband <- c("1973-06-21", "1970-07-16", "1949-10-08", "1969-05-24")
wife <- c("1984-11-12", "1973-08-02", "1948-11-11", "1983-07-23")
agegap <- husband-wife

husband <- c("1973-06-21", "1970-07-16", "1949-10-08", "1969-05-24") |>
  lubridate::ymd()
wife <- c("1984-11-12", "1973-08-02", "1948-11-11", "1983-07-23") |>
  lubridate::ymd()

agegap <- husband-wife
agegap
```

### Pieces of great 1.8

``` r
# Creates a list
metalli_lst <- list(name, instrument)
metalli_lst
```

    ## [[1]]
    ## [1] "Lars Ulrich"    "James Hetfield" "Kirk Hammett"   "Rob Trujillo"  
    ## [5] "Jason Newsted"  "Cliff Burton"   "Dave Mustaine" 
    ## 
    ## [[2]]
    ## [1] Drums         Proper guitar Proper guitar Bass guitar   Bass guitar  
    ## [6] Bass guitar   Proper guitar
    ## Levels: Proper guitar Bass guitar Drums

``` r
# creates a data frame using cbind
metalli_mtx <- cbind(name, instrument)
metalli_mtx
```

    ##      name             instrument
    ## [1,] "Lars Ulrich"    "3"       
    ## [2,] "James Hetfield" "1"       
    ## [3,] "Kirk Hammett"   "1"       
    ## [4,] "Rob Trujillo"   "2"       
    ## [5,] "Jason Newsted"  "2"       
    ## [6,] "Cliff Burton"   "2"       
    ## [7,] "Dave Mustaine"  "1"

[^1]: Contents of my first footnote.

[^2]: Contents of my second footnote.
