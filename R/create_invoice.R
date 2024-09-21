#' Create a new document based on the `invoicer` template
#'
#' Create (and optionally edit) a draft of the `invoicer` R Markdown template.
#'
#' @param reference Invoice reference number
#' @param create_dir TRUE to create a new directory for the draft
#' @param edit TRUE to edit the template immediately
#'
#' @return The contents of the `invoicer` template produced at specified `file`
#' @export

create_invoice <- function(reference = "Invoice.Rmd", create_dir = FALSE, edit = FALSE) {
  file <- paste(reference, "Invoice.Rmd")

  rmarkdown::draft(
    file = file,
    template = "invoicer",
    package = "wihantemplates",
    edit = edit,
    create_dir = create_dir
  )
}
