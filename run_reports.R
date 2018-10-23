render_report <- function(package) {
  out <- rmarkdown::render(
    "cran_usage.Rmd",
    params = list(
      package = package
    ),
    clean = TRUE
  )
  output_file <- paste0("reports/", package, "-usage.md")

  file.copy(out, output_file, overwrite = TRUE)
  unlink(out)

  invisible(output_file)
}
