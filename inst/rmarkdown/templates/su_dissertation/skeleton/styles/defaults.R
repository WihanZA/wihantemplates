#####################################
##### ggplot and table defaults #####
#####################################

# Prevents scientific notation of numbers in text
options(scipen = 999)

# Thousands are separated by spaces
# Example `r 1000000` produces 1 000 000
knitr::knit_hooks$set(inline = function(x) {prettyNum(x, big.mark = " ")})

# Defaults for ggplot
theme_set(theme_classic(base_size = 11) +
            theme(panel.grid.major = element_line(color = "grey92", linewidth = 0.5),
                  panel.grid.minor = element_line(color = "grey95", linewidth = 0.25),
                  legend.position = "bottom",
                  axis.title.y = element_text(margin = margin(t = 0, r = 5, b = 0, l = 0)),
                  axis.title.x = element_text(margin = margin(t = 5, r = 0, b = 0, l = 0)),
                  legend.box="vertical",
                  legend.margin = margin(t = 0, 0, 0, 0),
                  legend.text = element_text(size = 9),
                  legend.title = element_text(size = 9),
                  legend.spacing.y = unit(0, "cm"),
                  plot.caption = ggtext::element_markdown(size = 9,
                                                          hjust =  0,
                                                          lineheight = 1.2)))

# Default settings for knitr and kableExtra tables
options(knitr.table.format = "latex")
options(knitr.kable.NA = "")

