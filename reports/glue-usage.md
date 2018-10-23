Query function usage by reverse dependencies
================

# Call analysis

The following counts are all from explicit calls to your package, e.g.
`pkg::foo()`.

## Reverse dependencies with most calls

These are generally the reverse dependencies which are the heaviest
users of your package.

``` r
calls %>% count(pkg) %>% arrange(desc(n))
```

    ## # A tibble: 59 x 2
    ##    pkg            n
    ##    <chr>      <int>
    ##  1 febr          88
    ##  2 RInno         67
    ##  3 sealr         60
    ##  4 DiagrammeR    32
    ##  5 postal        30
    ##  6 walmartAPI    26
    ##  7 driftR        23
    ##  8 mosaic        18
    ##  9 riingo        18
    ## 10 humanize      17
    ## # ... with 49 more rows

## Functions most called

There are the functions from your package reverse dependencies are using
most frequently.

``` r
calls %>% 
  count(fun) %>% 
  mutate(percent = scales::percent(n / sum(n))) %>%
  arrange(desc(n)) %>% 
  head(20)
```

    ## # A tibble: 8 x 3
    ##   fun               n percent
    ##   <chr>         <int> <chr>  
    ## 1 glue            531 90.8%  
    ## 2 glue_collapse    21 3.6%   
    ## 3 collapse         16 2.7%   
    ## 4 glue_data        10 1.7%   
    ## 5 double_quote      4 0.7%   
    ## 6 backtick          1 0.2%   
    ## 7 glue_sql          1 0.2%   
    ## 8 single_quote      1 0.2%

## How many reverse dependencies use each function

This helps determine how broad function usage is across packages.

``` r
calls %>%
  select(pkg, fun) %>%
  unique() %>%
  count(fun) %>%
  mutate(percent = scales::percent(n / length(unique(calls$pkg)))) %>%
  arrange(desc(n)) %>%
  head(20)
```

    ## # A tibble: 8 x 3
    ##   fun               n percent
    ##   <chr>         <int> <chr>  
    ## 1 glue             55 93.2%  
    ## 2 glue_collapse     9 15.3%  
    ## 3 glue_data         5 8.5%   
    ## 4 collapse          3 5.1%   
    ## 5 backtick          1 1.7%   
    ## 6 double_quote      1 1.7%   
    ## 7 glue_sql          1 1.7%   
    ## 8 single_quote      1 1.7%

# Imports

The following counts come from reverse dependencies which explicitly
import functions from your package with `importFrom()` or `import()`.
While we don’t see how often they are using each function in this case,
we can see which functions are being imported.

## Reverse dependencies with full imports

2 reverse dependencies have ‘full’ imports, with `import(pkg)` in their
NAMESPACE. It is difficult to determine function usage of these
packages.

    ## [1] "configr" "togglr"

## Reverse dependencies with the most functions imported

``` r
selective_imports %>% count(pkg) %>% arrange(desc(n))
```

    ## # A tibble: 36 x 2
    ##    pkg             n
    ##    <chr>       <int>
    ##  1 radiant         3
    ##  2 dials           2
    ##  3 fiery           2
    ##  4 googledrive     2
    ##  5 rtypeform       2
    ##  6 textclean       2
    ##  7 biolink         1
    ##  8 bjscrapeR       1
    ##  9 blastula        1
    ## 10 blorr           1
    ## # ... with 26 more rows

## Which functions are most often imported?

These are generally the functions which your reverse dependencies find
most useful.

``` r
selective_imports %>%
  count(fun) %>%
  mutate(percent = scales::percent(n / length(unique(selective_imports$pkg)))) %>%
  arrange(desc(n)) %>%
  head(20)
```

    ## # A tibble: 4 x 3
    ##   fun               n percent
    ##   <chr>         <int> <chr>  
    ## 1 glue             34 94.4%  
    ## 2 glue_collapse     4 11.1%  
    ## 3 glue_data         4 11.1%  
    ## 4 glue_sql          1 2.8%

## Which functions are never used by reverse dependencies?

These are the functions no reverse dependency is using either by calls
or importing. These functions either need better documentation /
publicity, are meant for interactive use rather than in packages, or do
not provide a useful function and should be considered for removal.

``` r
exports <- getNamespaceExports(pkg)

exports[
  !exports %in% c(calls$fun, selective_imports$fun)
]
```

    ## [1] "trim"                 "as_glue"              "glue_col"            
    ## [4] "glue_data_sql"        "identity_transformer" "glue_data_col"
