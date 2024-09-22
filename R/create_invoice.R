#' Create a new document based on the `invoicer` template
#'
#' Create (and optionally edit) a draft of the `invoicer` R Markdown template.
#'
#' @param path File path for invoice `.Rmd` destination
#' @param overwrite TRUE to overwrite an existing file at `path`
#' @param create_dir TRUE to create a new directory for the draft
#' @param edit TRUE to edit the template immediately
#'
#' @return The contents of the `invoicer` template produced at specified `file`
#' @export

create_invoice <- function(path, overwrite = FALSE, create_dir = FALSE, edit = FALSE) {
  if (file.exists(path)) {
    if (overwrite == TRUE) {
      file.remove(path)
    } else {
      stop("File already exists. Set `overwrite = TRUE` to overwrite.")
    }
  }

  rmarkdown::draft(
    file = path,
    template = "invoicer",
    package = "wihantemplates",
    edit = edit,
    create_dir = create_dir
  )
}
