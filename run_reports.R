render_report <- function(package) {
  rmarkdown::render(
    "cran_usage.Rmd",
    params = list(
      package = package
    ),
    output_file = paste0("reports/", package, "-usage.md")
  )
}
