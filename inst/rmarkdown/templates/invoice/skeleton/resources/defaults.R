# perform metadata silimarity check across invoice and quote
wihantemplates::compare_params(
  # inherited from setup code chunk
  file1 = active_file,
  file2 = if (
    grepl(
      pattern = "invoice",
      x = basename(active_file)
    )
  ) {
    file.path(
      dirname(active_file),
      gsub("invoice", "quote", basename(active_file))
    )
  } else {
    file.path(
      dirname(active_file),
      gsub("quote", "invoice", basename(active_file))
    )
  },
  common = c("client", "project", "author"),
  throw_error = FALSE
)

# flextable defaults ----
set_flextable_defaults(
  font.family = "Arial",
  font.size = 10,
  font.color = "black",
  text.align = "left",
  padding = 5,
  border.color = "#666666",
  border.width = 0.75,
  background.color = "transparent",
  line_spacing = 1,
  table.layout = "fixed",
  decimal.mark = ".",
  big.mark = " ",
  digits = 1,
  pct_digits = 1,
  na_str = "",
  nan_str = "",
  fmt_date = "%Y-%m-%d",
  fmt_datetime = "%Y-%m-%d %H:%M:%S",
  table_align = "center",
  split = NULL,
  float = "none",
  tabcolsep = NULL,
  arraystretch = 1.5,
  fonts_ignore = TRUE,
  theme_fun = function(x) {
    theme_booktabs(x, bold_header = TRUE)
  }
)

# consistent currency formatter ----
# for both Rate and Subtotal in tables
currency_formatter <- scales::label_currency(
  prefix = "R",
  big.mark = " ",
  decimal = ".",
  accuracy = 0.01 # Ensures consistent decimal display
)
