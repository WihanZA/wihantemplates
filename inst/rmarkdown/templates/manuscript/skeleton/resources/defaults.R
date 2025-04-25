# prevent scientific notation of numbers in text ----
options(scipen = 999)

# inline code number formatting ----
knitr::knit_hooks$set(inline = function(x) {
  prettyNum(x, big.mark = " ")
})

# ggplot default theme ----
plot_theme <- theme_classic(base_size = 11) +
  theme(
    panel.grid.major = element_line(
      color = "grey90",
      linewidth = 0.1
    ),
    panel.grid.minor = element_line(
      color = "grey95",
      linewidth = 0.1
    ),
    axis.title.y = element_text(
      size = rel(0.8),
      margin = margin(t = 0, r = 5, b = 0, l = 0, unit = "pt")
    ),
    axis.title.x = element_text(
      size = rel(0.8),
      margin = margin(t = 5, r = 0, b = 0, l = 0, unit = "pt")
    ),
    legend.position = "bottom",
    legend.box = "vertical",
    legend.margin = margin(t = 0, 0, 0, 0, unit = "pt"),
    legend.text = element_text(size = rel(0.8)),
    legend.title = element_text(size = rel(0.8)),
    legend.spacing.y = unit(0, "cm"),
    plot.caption = ggtext::element_markdown(
      size = rel(0.7),
      hjust = 0,
      lineheight = 1.2
    ),
    strip.text = element_text(
      margin = margin(t = 5, b = 5, unit = "pt")
    )
  )

theme_set(plot_theme)

# ggplot geoms defaults ----
update_geom_defaults(
  "point",
  list(size = 1.5, alpha = 0.8)
)

update_geom_defaults(
  "line",
  list(linewidth = 0.5, alpha = 0.5)
)

# default settings for knitr and kableExtra tables ----
options(knitr.table.format = "latex")
options(knitr.kable.NA = "")
