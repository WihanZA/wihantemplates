
# wihantemplates

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

An R package comprising–hopefully, one day–a suite of templates for the
creation documents in **R Markdown** which I’ve come to use on a regular
basis. The package is still in its experimental stage and I’ll be
working out the kinks. The best way to contribute to its development and
address its inevitable problems is by logging a new issue
[here](https://github.com/WihanZA/wihantemplates/issues). For now, the
package includes only
[`su_dissertation`](https://github.com/WihanZA/wihantemplates?tab=readme-ov-file#su_dissertation),
a template for creating theses and dissertations for students at
Stellenbosch University.

## Getting Started

You can install the development version from this Github repository via
the [`remotes`](https://github.com/r-lib/remotes#readme) package in R.

``` r
# install.packages("remotes")
remotes::install_github("WihanZA/wihantemplates")
library(wihantemplates)
```

You should ensure that certain essential packages are installed and
loaded in R. Since all templates produce PDFs, you’ll need a TeX
distribution installed on your machine. I recommend using the
lightweight TeX installation [TinyTeX](https://yihui.org/tinytex/).
Follow the steps below to have both the
[`tinytex`](https://github.com/rstudio/tinytex) package and distribution
in place. The [`rmarkdown`](https://github.com/rstudio/rmarkdown)
package is also included here for good measure.

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

To ensure that all necessary LaTeX packages and dependencies are
available, especially those not included in the TinyTeX distribution by
default, you can use
[`tinytex::parse_install`](https://yihui.org/tinytex/r/#compile-latex-documents).
This reads the `.log` file from a failed compilation, identifies the
missing packages and styles, and installs them.

``` r
tinytex::parse_install("dissertation.log")
```

Once the package has been installed, go to
`File > New File > R Markdown > From Template` in RStudio to select your
desired template. My templates are those denoted with `{wihantemplates}`
alongside templates’ names. Choose a name (“example”) and location for
the new directory containing the template, select `OK`, and you’ll be up
and running.

## `su_dissertation`

### Stellenbosch University Dissertation Template

All the necessary materials for honours, master’s and doctoral students
using R Markdown to produce dissertations and theses conforming to the
requirements of Stellenbosch University. The template heavily relies on
the excellent suite of LaTeX packages,
[`stellenbosch-2`](https://ctan.org/pkg/stellenbosch-2), created and
maintained by [Daniel Els](mailto:dnjels@sun.ac.za). You can find a
complete example
[here](https://github.com/WihanZA/wihantemplates/blob/master/examples/su_dissertation.pdf).
The template is initially populated with helpful content covering
various aspects of dissertation writing.

[<img src="thumbnails/su_dissertation-1-2-3-9.png" style="width: 100.0%" />](thumbnails/su_dissertation-1-2-3-9.png)
[<img src="thumbnails/su_dissertation-10-18-19-22.png" style="width: 100.0%" />](thumbnails/su_dissertation-10-18-19-22.png)

#### Template Directory

``` latex
[example]
├── cache
├── code
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
├── [example].Rmd
```

- **`[example].Rmd`**: Your starting point and main interface for
  creating the dissertation.

- **`styles/template.tex`**: The LaTeX backend of the template, adapted
  from the `stb-thesis` LaTeX class.

- **`styles/defaults.R`**: R code constituting the default settings for
  number printing, table output, and `ggplot` theme settings.

- **`cache`** and **`figures`**: Automatically created when knitting
  `[example].Rmd`. The paths for `cache` and `figures` are set in the
  `setup` code chunk of `[example].Rmd`.

- **`matter`**: A subdirectory containing files called into the
  `[example].Rmd` file, including `abstract.Rmd`,
  `acknowledgements.Rmd`, and `nomenclature.Rmd`. Although these are
  `.Rmd` files, they primarily consist of LaTeX code. You’ll find that
  they’re easy to use given the self-explanatory examples provided in
  the template. `appendix.Rmd` follows the same syntax as your
  `[example].Rmd` file.

- **`matter/mybib.bib`**: The BibTeX file containing bibliography
  entries referenced in the `[example].Rmd` file.

#### YAML Fields

The YAML header at top of `[example].Rmd` configures the output of your
dissertation, defining both metadata and formatting settings. YAML
fields are used in accordance with the setup in `template.tex` settings
to render a PDF. The following is a cursory overview of some YAML
fields.

``` yaml
output:
  pdf_document:
    template: styles/template.tex
    keep_tex: FALSE
    latex_engine: pdflatex
    citation_package: natbib
    pandoc_args: --top-level-division=chapter
```

This configuration sets the output format to `pdf_document`, using a
LaTeX template from `styles/template.tex`. The `keep_tex` option, when
set to TRUE, saves the intermediate `.tex` file–useful when doing LaTeX
debugging. The document is compiled using the `pdflatex` engine, and
bibliographies are managed by
[`natbib`](https://za.mirrors.cicku.me/ctan/macros/latex/contrib/natbib/natbib.pdf).
The `pandoc_args` parameter structures the document into chapters,
suitable for theses and dissertations. **Warning:** It’s best not to
modify this part of the YAML. Changes to `latex_engine`,
`citation_package`, or `pandoc_args` will break the template. Beginners
should avoid modifying `template.tex` unless they are comfortable with
TeX.

``` yaml
thesistype: PhD
author: "Johnny Elvis Bravo"
authorshort: "J. E. Bravo"
title: "My Dissertation"
titel: "My Proefskrif"
degree: "Doctor of Philosophy in Economics"
graad: "Doktor in die Wysbegeerte in Ekonomie"
degreeshort: "PhD (Economics)"
graadshort: "PhD (Ekonomie)"
department: "Department of Economics"
departement: "Departement van Ekonomie"
faculty: "Faculty of Economic and Management Sciences"
fakulteit: "Fakulteit Ekonomiese en Bestuurswetenskappe"
supervisor:
  - "Prof. F. Flintstone"
  # - "Prof. G. Jetson"
cosupervisor:
  - "Prof. H. Simpson"
year: 2025
month: 04
sponsor: "The financial assistance of the National Research Foundation (NRF) towards this research is hereby acknowledged. Opinions expressed and conclusions arrived at, are those of the author and are not necessarily to be attributed to the NRF."
```

This part of the YAML specifies important metadata used to populate the
dissertation’s front page and abstracts.

- `thesistype` can be either `masters-a` for an assignment master’s
  degree, `masters-t` for a thesis master’s degree, or `PhD` for a PhD
  dissertation, affecting the description of the document on the front
  page and the document type listed in abstracts.
- YAML fields denoted with `-short` are always used to populate
  abstracts.
- Master’s and PhD documents at Stellenbosch University are governed by
  certain bilingual requirements. Afrikaans metadata fields are used to
  populate the Afrikaans abstract or “uittreksel”.
- Entries in `supervisor` and `cosupervisor` appear on the front page,
  however can be deleted or commented out (with `#`).
- Sponsorships, if any, are acknowledged in the `sponsor` field, but can
  also be prevented from appearing on the front page by deleting or
  commenting away the field.

``` yaml
abstract: matter/abstract.Rmd
acknowledgements: matter/acknowledgements.Rmd
nomenclature: matter/nomenclature.Rmd
bibliography: matter/mybib.bib
```

File paths for key document sections are specified to ensure proper
integration. These paths direct to the corresponding `.Rmd` or `.bib`
files, ensuring that the abstract, acknowledgements, nomenclature, and
bibliography are correctly incorporated into the final document.
Although, all parts are formally required by the conventions of
Stellenbosch University, only the `bibliography` field is required to
successfully generate this document. Other fields are optional, hence
can be deleted or commented out.

Happy writing!
