---
title: Introduction-to-plotting-in-R
author: Janae Nicholson
date: '2021-03-21'
slug: introduction-to-plotting-in-r
categories:
  - R
tags:
  - ggplot2
  - plotting
subtitle: 'An Introduction to `qplot()` in the `ggplot2` package '
summary: 'This blog post shows how to do simple plots in R using the `qplot()` function in the `ggplot2` package.'
authors: []
lastmod: '2021-03-21T20:35:19-05:00'
featured: no
image:
  caption: ''
  focal_point: ''
  preview_only: no
projects: ["plotting-in-R"]
---

The ggplot2 package is an advanced graphics package that implements the grammar of graphics. There are two main functions in the package.  The first is `qplot()`.  This function is for making a quick plot.  It tends to guess as to what you want and may not give you exactly what you want.  The function `ggplot()` gives greater control of the plot at the cost of having to specify every detail.


See [docs.ggplot2.org/current/](docs.ggplot2.org/current/) for more details.

Let's start by loading the packages `ggplot` and `RColorBrewer`.  We will begin with the diamonds data set available in the `ggplot2` package.


```r
library(ggplot2)
library(RColorBrewer)  #Color palettes for plotting
str(diamonds)
```

```
## tibble [53,940 × 10] (S3: tbl_df/tbl/data.frame)
##  $ carat  : num [1:53940] 0.23 0.21 0.23 0.29 0.31 0.24 0.24 0.26 0.22 0.23 ...
##  $ cut    : Ord.factor w/ 5 levels "Fair"<"Good"<..: 5 4 2 4 2 3 3 3 1 3 ...
##  $ color  : Ord.factor w/ 7 levels "D"<"E"<"F"<"G"<..: 2 2 2 6 7 7 6 5 2 5 ...
##  $ clarity: Ord.factor w/ 8 levels "I1"<"SI2"<"SI1"<..: 2 3 5 4 2 6 7 3 4 5 ...
##  $ depth  : num [1:53940] 61.5 59.8 56.9 62.4 63.3 62.8 62.3 61.9 65.1 59.4 ...
##  $ table  : num [1:53940] 55 61 65 58 58 57 57 55 61 61 ...
##  $ price  : int [1:53940] 326 326 327 334 335 336 336 337 337 338 ...
##  $ x      : num [1:53940] 3.95 3.89 4.05 4.2 4.34 3.94 3.95 4.07 3.87 4 ...
##  $ y      : num [1:53940] 3.98 3.84 4.07 4.23 4.35 3.96 3.98 4.11 3.78 4.05 ...
##  $ z      : num [1:53940] 2.43 2.31 2.31 2.63 2.75 2.48 2.47 2.53 2.49 2.39 ...
```

Notice that our data set has 53,940 rows and 10 columns.  There are numeric columns such as carat, an integer column of price, and ordered factors such as cut which are categorical.  

## A Quick Bar Chart

```r
qplot(cut, data=diamonds, fill=cut, 
      main="Bar Chart of Diamond Cut")
```

```
## Warning: `qplot()` was deprecated in ggplot2 3.4.0.
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/barchart-1.png" width="672" />

## A Stacked Bar Chart

```r
qplot(cut, data=diamonds, fill=clarity, geom="bar", 
      main="Bar Chart of Diamond Cut and Clarity")
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/stacked-1.png" width="672" />

## A Histogram 
Note fill sets the color inside the bar, colour sets the boundary color.  By default 30 bins are used and you get a message if you don't set the bin width.


```r
qplot(price, data=diamonds, geom="histogram", 
      main="Histogram of Diamond Prices", 
      fill=I("cornflowerblue"), colour = I("black"))
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/hist1-1.png" width="672" />

## A Density Plot

```r
qplot(price, data=diamonds, geom="density", fill=cut, 
      main="Density of Price by Cut")
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-1-1.png" width="672" />

## A Density Plot with the Colors Changed
The `ggplot2` package works with the `RColorBrewer` to provide additional palettes for plotting.


```r
qplot(price, data=diamonds, geom="density", fill=color, 
      main="Density of Price by Color") +
  scale_fill_brewer(palette="Spectral")
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-2-1.png" width="672" />

## A Box Plot

```r
qplot(cut, price, data=diamonds, geom="boxplot", fill=cut, 
      main="Price by Cut")
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-3-1.png" width="672" />

## Take a Sample
The number of rows in the full data set is 53,940.  If you try to do a scatter plot of this many data points most of the points will be hidden.  Let's take a sample to make the plot look better.  Remember always set a seed when doing something random.


```r
set.seed(12345)
dsamp <- diamonds[sample(nrow(diamonds), 1000), ]
```

## A Scatter Plot

```r
(q1 <- qplot(carat, price, data=dsamp, colour=clarity, 
             main="Carat vs Price for Sample of Diamonds"))
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-4-1.png" width="672" />

## Refine the Plot
Notice that I saved the `ggplot` object.  This allows me to change some of the layers in the plot and refine the final output as I go.

```r
q1 + scale_colour_brewer()
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-5-1.png" width="672" />

Now try specifying the color palette.

```r
q1 + scale_colour_brewer(palette="Paired")
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-6-1.png" width="672" />

## Plot Linear Regressions
We can add linear regressions to the scatter plot. Here I regress carat on price for each clarity.

```r
qplot(carat, price, data=dsamp, geom=c("point", "smooth"),
      colour=clarity,
      main="Regression of Price on Carat for each Clarity")
```

```
## `geom_smooth()` using method = 'loess' and formula = 'y ~ x'
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-7-1.png" width="672" />

## Multiple Plots on the Page

```r
qplot(carat, price, data=dsamp, colour=clarity, facets=~cut)
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-8-1.png" width="672" />

# Time series Plots
Plotting of time series is common in statistics and comes up many times when discussing plotting.  Here are some examples using some familiar R data sets.

Using the airquality R data set look at ozone over time.  First I need to create a date to plot over.

```r
air <- airquality
air$NewDate <- as.Date(paste(air$Month,air$Day,"1973", sep="/"), "%m/%d/%Y")
qplot(NewDate, Ozone, data=subset(air, !is.na(Ozone)), geom="line", 
      main="Ozone over Time")
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-9-1.png" width="672" />

Another example using economics data in ggplot2 package

```r
qplot(date, unemploy, data=economics, geom="path", 
      main="Unemployment over Time", ylab="Unemployment (Thousands)")
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-10-1.png" width="672" />

The above plots used R data frames with a date and measurement variable.  It is also possible to plot R time series objects.

```r
str(AirPassengers)
```

```
##  Time-Series [1:144] from 1949 to 1961: 112 118 132 129 121 135 148 148 136 119 ...
```

```r
qplot(time(AirPassengers), AirPassengers, geom="line", main="Monthly International Airline Passengers")
```

```
## Don't know how to automatically pick scale for object of type <ts>. Defaulting
## to continuous.
## Don't know how to automatically pick scale for object of type <ts>. Defaulting
## to continuous.
```

<img src="{{< blogdown/postref >}}index.en_files/figure-html/unnamed-chunk-11-1.png" width="672" />
