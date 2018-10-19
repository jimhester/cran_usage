[cran_usage.Rmd](cran_usage.Rmd) is a parameterized RMarkdown report which tabulates data on
function usage of a package's CRAN dependencies. It utilizes a local CRAN
mirror and searches within the package tarballs for the data. On my machine the
CRAN mirror currently takes ~ 6.7 Gb of space.

This information could be useful for package authors to determine how people are
using their package on CRAN.

Some example reports:

- [devtools](reports/devtools-usage.md)
- [dplyr](reports/dplyr-usage.md)
- [glue](reports/glue-usage.md)
- [rlang](reports/rlang-usage.md)
- [usethis](reports/usethis-usage.md)
