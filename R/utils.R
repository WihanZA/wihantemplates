#' Compare YAML parameters across two files
#'
#' This function compares specified parameters between the YAML front matter of two files
#' to ensure consistency in metadata. It issues warnings or errors
#' if discrepancies are found in parameters that should be identical across both files.
#'
#' @param file1 Path to the first file
#' @param file2 Path to the second file
#' @param common Character vector of parameter name patterns to compare between files;
#'   the function will perform partial matching (using regex) on these patterns.
#'   If NULL or empty (default), all parameters will be compared.
#' @param throw_error Logical; if TRUE, errors will be thrown instead of warnings when mismatches are found (default: FALSE)
#' @return Invisible NULL (function is used for its side effects)
#' @details
#' The function flattens nested YAML parameters for comparison. Two modes of operation are available:
#'
#' 1. When `common = NULL` (default), all parameters in both files are compared
#' 2. When patterns are provided in `common`, only parameters matching those patterns are compared
#'
#' For pattern matching, the function searches for partial matches using regex. For example,
#' providing `"client"` will match all parameters containing that string, such as `client$value$name`.
#'
#' When differences are found, the function throws an appropriate warning/error.
#'
#' @importFrom fs path_abs file_exists
#' @importFrom rmarkdown yaml_front_matter
#' @importFrom purrr map list_flatten
#' @importFrom tibble as_tibble
#' @importFrom tidyr pivot_longer
#' @importFrom dplyr everything full_join filter mutate
#' @importFrom stringr str_squish
#' @export
#'
compare_params <- function(
  file1,
  file2,
  common = NULL,
  throw_error = FALSE
) {
  # Check if files exist
  if (!file_exists(file1)) {
    stop(sprintf("File not found: %s", file1))
  }

  if (!file_exists(file2)) {
    stop(sprintf("File not found: %s", file2))
  }

  # Set labels for messages if not provided
  file1_label <- basename(file1)
  file2_label <- basename(file2)

  # Read YAML headers
  yaml1 <- yaml_front_matter(file1)
  yaml2 <- yaml_front_matter(file2)

  # Extract params if they exist
  if (!"params" %in% names(yaml1)) {
    stop("No `params` present in ", file1)
  }
  if (!"params" %in% names(yaml2)) {
    stop("No `params` present in ", file2)
  }

  params1 <- yaml1$params
  params2 <- yaml2$params

  # Flatten params until entirely unnested
  # e.g. client_value_name
  params1_flat <- list_flatten(params1)
  params2_flat <- list_flatten(params2)

  while (!identical(params1_flat, list_flatten(params1_flat))) {
    params1_flat <- list_flatten(params1_flat)
  }

  while (!identical(params2_flat, list_flatten(params2_flat))) {
    params2_flat <- list_flatten(params2_flat)
  }

  # Create tibbles from param lists
  params1_df <- as_tibble(params1_flat)
  params2_df <- as_tibble(params2_flat)

  # Tidy tables
  params1_df <- params1_df %>%
    pivot_longer(
      cols = everything(),
      names_to = "param",
      values_to = "file1"
    )

  params2_df <- params2_df %>%
    pivot_longer(
      cols = everything(),
      names_to = "param",
      values_to = "file2"
    )

  # create comparison df
  compare_df <- full_join(
    params1_df,
    params2_df,
    by = "param"
  )

  # unless common is void
  # create filter string and filter params to compare
  if (!is.null(common) && length(common) != 0) {
    common_filter <- common %>%
      str_squish() %>%
      paste0(collapse = "|")

    # don't need exact match
    # combination of partial match and
    # throw_error = FALSE is sufficient
    compare_df <- compare_df %>%
      filter(grepl(common_filter, param, ignore.case = TRUE))

    if (nrow(compare_df) == 0) {
      warning("No YAML params with partial matches to `common_params`")
      invisible(NULL)
    }
  }

  # perform comparison
  compare_df <- compare_df %>%
    mutate(match = (file1 == file2))

  # if all scrutinised params match
  if (all(compare_df$match)) {
    invisible(NULL)
  }

  # if any without match
  mismatched <- compare_df %>%
    filter(!match) %>%
    mutate(param = gsub("_", "$", param)) %>%
    mutate(diff = paste0(param, ": ", file1, " != ", file2)) %>%
    pull(diff) %>%
    paste0("* ", ., collapse = "\n")

  msg_heading <- paste("compare_params():", file1_label, "vs.", file2_label)
  msg_border <- paste0(rep("-", nchar(msg_heading)), collapse = "")

  msg <- c(
    "",
    msg_border,
    msg_heading,
    msg_border,
    "Mismatched YAML parameters:",
    mismatched,
    ""
  ) %>%
    paste0(collapse = "\n")

  # Message function (either warning or error)
  if (throw_error) {
    msg <- paste(
      msg,
      "Set `common` or `throw_error = FALSE` to negate this error.",
      sep = "\n"
    )
    stop(msg, call. = FALSE)
  } else {
    warning(msg, call. = FALSE)
  }
}

#' Escape problematic characters to allow compilation in LaTeX
#'
#' This function escapes special LaTeX characters in a string to ensure proper rendering.
#' Copied from `knitr` because it is unexported and CRAN rejects.
#'
#' @param x a character string to escape
#' @param newlines boolean
#' @param spaces boolean
#'
#' @return String with escaped characters
#'
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
