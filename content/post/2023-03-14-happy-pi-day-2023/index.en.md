---
title: Happy Pi Day 2023
author: Janae Nicholson
date: '2023-03-14'
slug: happy-pi-day-2023
categories:
  - R
tags:
  - R Markdown
subtitle: "Let’s celebrate Pi day. Here is a nice pie chart for you."
summary: "Let's celebrate Pi day.  Here is a nice pie chart for you."
authors: []
lastmod: '2023-03-14T12:25:18-05:00'
featured: no
image:
  caption: 'Image credit: [**Live Science**](https://www.livescience.com/29197-what-is-pi.html)'
  focal_point: ''
  preview_only: true
projects: []
---





Pi day is celebrated on March 14 every year.  This is because the numerical value of pi is 3.14.  Please enjoy my favorite pie chart made with R.




```r
par(mar = c(0, 1, 0, 1))
pie(
  c(280, 60, 20),
  c('Sky', 'Sunny side of pyramid', 'Shady side of pyramid'),
  col = c('#0292D8', '#F7EA39', '#C4B632'),
  init.angle = -50, border = NA
)
```

<div class="figure">
<img src="{{< blogdown/postref >}}index.en_files/figure-html/pie-1.png" alt="A fancy pie chart." width="672" />
<p class="caption">Figure 1: A fancy pie chart.</p>
</div>
