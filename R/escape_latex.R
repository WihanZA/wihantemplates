#' Escape problematic characters to allow compilation in LaTeX
#'
#' This function escapes special LaTeX characters in a string to ensure proper rendering.
#' Copied from `knitr` because it is unexported and CRAN rejects :::
#'
#' @param x a character string to escape
#' @param newlines boolean
#' @param spaces boolean
#' @examples
#' escape_latex("100% sure!")
#' @export

escape_latex <- function(x, newlines = FALSE, spaces = FALSE) {
  x <- gsub("\\\\", "\\\\textbackslash", x)
  x <- gsub("([#$%&_{}])", "\\\\\\1", x)
  x <- gsub("\\\\textbackslash", "\\\\textbackslash{}", x)
  x <- gsub("~", "\\\\textasciitilde{}", x)
  x <- gsub("\\^", "\\\\textasciicircum{}", x)
  if (newlines) {
    x <- gsub("(?<!\n)\n(?!\n)", "\\\\\\\\", x, perl <- TRUE)
  }
  if (spaces) {
    x <- gsub("(?<<- ) ", "\\\\ ", x, perl <- TRUE)
  }
  x
}
