
# wihantemplates

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

`wihantemplates` is an R package comprising–hopefully one day–a suite of
templates for the creation of **R Markdown** documents, and in turn,
PDFs which I have come to use on a regular basis. The package is still
in its experimental stage, so please be patient while I work out the
kinks. The best way to contribute to its development and address the
problems which will inevitably arise is by logging a new issue
[here](https://github.com/WihanZA/wihantemplates/issues).

Certainly! Here’s the refined version:

## Getting Started

You can install the development version of `wihantemplates` from Github
via the [`remotes`](https://github.com/r-lib/remotes#readme) package.

``` r
# install.packages("remotes")
remotes::install_github("WihanZA/wihantemplates")
```

Ensure that you have the essential R packages installed and loaded.
Since all templates rely on [TinyTeX](https://yihui.org/tinytex/)’s
custom $\LaTeX$ distribution, you must have both the `tinytex` package
and distribution installed on your machine. The
[`rmarkdown`](https://rmarkdown.rstudio.com/lesson-1.html) package is
also included here for good measure.

``` r
if (!requireNamespace("tinytex", quietly = TRUE)) {
  install.packages("tinytex")
}
if (!requireNamespace("rmarkdown", quietly = TRUE)) {
  install.packages("rmarkdown")
}

library(tinytex)
library(rmarkdown)

if (!tinytex::is_tinytex() || is.null(tinytex::tinytex_root())) {
  tinytex::install_tinytex()
}
```

To ensure that all necessary $\LaTeX$ packages and dependencies are
available, especially those not included in the TinyTeX distribution by
default, you can use `tinytex::parse_install()`. This reads the log file
from a failed compilation, `dissertation.log`, identifies the missing
packages and styles, and installs them.

``` r
tinytex::parse_install("dissertation.log")
```

## Usage

Once the package has been installed, it is quite simple to use a
particular template. In RStudio, go to
`File > New File > R Markdown > From Template` and select your desired
template from the list. My templates are those denoted with
`{wihantemplates}` alongside templates’ names. For now, the package
includes only the `su_dissertation` template.

## `su_dissertation`

### Stellenbosch University Dissertation Template

All the necessary materials for doctoral and master’s students using R
Markdown to produce dissertations and theses conforming to the
requirements of Stellenbosch University. The template heavily relies on
the excellent suite of $\LaTeX$ packages,
[`stellenbosch-2`](https://ctan.org/pkg/stellenbosch-2), created and
maintained by [Daniel Els](mailto:dnjels@sun.ac.za).

#### Template directory

``` latex
template
├── cache
├── code
├── data
├── figures
├── matter
│   ├── abstract.Rmd
│   ├── acknowledgements.Rmd
│   ├── appendix.Rmd
│   ├── mybib.bib
│   └── nomenclature.Rmd
├── styles
│   ├── defaults.R
│   └── template.tex
├── su_dissertation.pdf
├── su_dissertation.Rmd
└── su_dissertation.tex
```

#### Spacing

Given the particular setup of the template’s document class and
packages, the following $\LaTeX$ parameters produce skips, indents and
separations of the sizes presented in the table below. The relevant
parts of the template’s setup is as follows:

``` latex
\documentclass[12pt,...]{stb-thesis}
\usepackage[a4paper, left=1in, right=1in, top=1in, bottom=1.25in]{geometry} \usepackage{setspace}
\usepackage[skip,parfill]{parskip} 
\setstretch{1.1}
```

*Point sizes of selected* $\LaTeX$ *parameters and units given the
template’s default settings.*

| Parameter       | `\normalfont (Body)`          | `\chapter (#)` | `\section (##)` | `\subsection (###)` |
|:----------------|:------------------------------|:---------------|:----------------|:--------------------|
| `1em`           | 12pt                          | 24.88pt        | 17.28pt         | 14.4pt              |
| `1ex`           | 6.43pt                        | 13.34pt        | 9.26pt          | 7.72pt              |
| `\baselineskip` | 15.95pt                       |                |                 |                     |
| `\bigskip`      | 12.0pt plus 4.0pt minus 4.0pt |                |                 |                     |
| `\topskip`      | 12.0pt                        |                |                 |                     |
| `\parskip`      | 7.25pt plus 2.0pt             |                |                 |                     |
| `\medskip`      | 6.0pt plus 2.0pt minus 2.0pt  |                |                 |                     |
| `\smallskip`    | 3.0pt plus 1.0pt minus 1.0pt  |                |                 |                     |
| `\lineskip`     | 1.0pt                         |                |                 |                     |
| `\parindent`    | 0.0pt                         |                |                 |                     |
| `\partopsep`    | 0.0pt                         |                |                 |                     |
