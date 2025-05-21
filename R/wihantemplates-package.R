#' wihantemplates
#'
#' @description An R package providing professional templates for creating
#' documents in R Markdown. This package is designed for common document
#' creation tasks in academic and professional settings. For questions,
#' issues, or contributions, please visit the project repository at
#' [GitHub](https://github.com/WihanZA/wihantemplates/issues).
#'
#' @section Templates:
#' - `dissertation`: Create professional dissertations and theses conforming
#'   to Stellenbosch University requirements. Built on the
#'   [`stellenbosch-2`](https://ctan.org/pkg/stellenbosch-2) LaTeX package
#'   by [Daniel Els](mailto:dnjels@sun.ac.za).
#'
#' - `invoice`: Generate professional invoices with client information,
#'   timesheet integration, automatic calculations, and payment details.
#'
#' - `manuscript`: Produce academic manuscripts with formatting for sections,
#'   equations, tables, figures, citations, cross-references, footnotes,
#'   and acronyms.
#'
#' @keywords internal
"_PACKAGE"

## usethis namespace: start
#' @importFrom dplyr everything
#' @importFrom dplyr filter
#' @importFrom dplyr full_join
#' @importFrom dplyr mutate
#' @importFrom fs file_exists
#' @importFrom fs path_abs
#' @importFrom purrr list_flatten
#' @importFrom purrr map
#' @importFrom rmarkdown yaml_front_matter
#' @importFrom stringr str_squish
#' @importFrom tibble as_tibble
#' @importFrom tidyr pivot_longer
## usethis namespace: end
NULL
