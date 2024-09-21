#' Create a new document based on the `invoicer` template
#'
#' Create (and optionally edit) a draft of the `invoicer` R Markdown template.
#'
#' @param path File path for invoice `.Rmd` destination
#' @param create_dir TRUE to create a new directory for the draft
#' @param edit TRUE to edit the template immediately
#'
#' @return The contents of the `invoicer` template produced at specified `file`
#' @export

create_invoice <- function(path, create_dir = FALSE, edit = FALSE) {
  rmarkdown::draft(
    file = path,
    template = "invoicer",
    package = "wihantemplates",
    edit = edit,
    create_dir = create_dir
  )
}
