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

    ## # A tibble: 9 x 2
    ##   pkg              n
    ##   <chr>        <int>
    ## 1 devtools        62
    ## 2 testthis        28
    ## 3 DataPackageR    20
    ## 4 rstantools      11
    ## 5 piggyback        7
    ## 6 exampletestr     5
    ## 7 codemetar        3
    ## 8 fakemake         1
    ## 9 prodigenr        1

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

    ## # A tibble: 20 x 3
    ##    fun                     n percent
    ##    <chr>               <int> <chr>  
    ##  1 proj_get               36 26.1%  
    ##  2 use_directory          17 12.3%  
    ##  3 create_package         10 7.2%   
    ##  4 proj_set                6 4.3%   
    ##  5 use_build_ignore        6 4.3%   
    ##  6 use_testthat            5 3.6%   
    ##  7 use_git                 3 2.2%   
    ##  8 use_git_hook            3 2.2%   
    ##  9 use_git_ignore          3 2.2%   
    ## 10 use_test                3 2.2%   
    ## 11 use_appveyor            2 1.4%   
    ## 12 use_code_of_conduct     2 1.4%   
    ## 13 use_coverage            2 1.4%   
    ## 14 use_cran_badge          2 1.4%   
    ## 15 use_cran_comments       2 1.4%   
    ## 16 use_data                2 1.4%   
    ## 17 use_data_raw            2 1.4%   
    ## 18 use_dev_version         2 1.4%   
    ## 19 use_github              2 1.4%   
    ## 20 use_github_links        2 1.4%

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

    ## # A tibble: 20 x 3
    ##    fun                     n percent
    ##    <chr>               <int> <chr>  
    ##  1 proj_get                5 55.6%  
    ##  2 use_directory           5 55.6%  
    ##  3 create_package          4 44.4%  
    ##  4 use_build_ignore        4 44.4%  
    ##  5 proj_set                3 33.3%  
    ##  6 use_testthat            3 33.3%  
    ##  7 use_git                 2 22.2%  
    ##  8 use_git_hook            2 22.2%  
    ##  9 use_git_ignore          2 22.2%  
    ## 10 use_test                2 22.2%  
    ## 11 edit_r_profile          1 11.1%  
    ## 12 use_appveyor            1 11.1%  
    ## 13 use_code_of_conduct     1 11.1%  
    ## 14 use_coverage            1 11.1%  
    ## 15 use_cran_badge          1 11.1%  
    ## 16 use_cran_comments       1 11.1%  
    ## 17 use_data                1 11.1%  
    ## 18 use_data_raw            1 11.1%  
    ## 19 use_description         1 11.1%  
    ## 20 use_dev_version         1 11.1%

# Imports

The following counts come from reverse dependencies which explicitly
import functions from your package with `importFrom()` or `import()`.
While we don’t see how often they are using each function in this case,
we can see which functions are being imported.

## Reverse dependencies with full imports

2 reverse dependencies have ‘full’ imports, with `import(pkg)` in their
NAMESPACE. It is difficult to determine function usage of these
packages.

    ## [1] "prodigenr"         "uCAREChemSuiteCLI"

## Reverse dependencies with the most functions imported

``` r
selective_imports %>% count(pkg) %>% arrange(desc(n))
```

    ## # A tibble: 3 x 2
    ##   pkg              n
    ##   <chr>        <int>
    ## 1 DataPackageR     7
    ## 2 piggyback        2
    ## 3 devtools         1

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

    ## # A tibble: 9 x 3
    ##   fun                  n percent
    ##   <chr>            <int> <chr>  
    ## 1 proj_get             2 66.7%  
    ## 2 create_package       1 33.3%  
    ## 3 proj_set             1 33.3%  
    ## 4 use_build_ignore     1 33.3%  
    ## 5 use_data_raw         1 33.3%  
    ## 6 use_directory        1 33.3%  
    ## 7 use_git_ignore       1 33.3%  
    ## 8 use_rstudio          1 33.3%  
    ## 9 use_testthat         1 33.3%

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

    ##  [1] "browse_cran"              "use_git_config"          
    ##  [3] "with_project"             "create_from_github"      
    ##  [5] "edit_r_environ"           "use_lifecycle_badge"     
    ##  [7] "local_project"            "use_blank_slate"         
    ##  [9] "browse_github_pat"        "use_apl2_license"        
    ## [11] "use_tidy_github"          "use_logo"                
    ## [13] "use_dev_package"          "use_tidy_thanks"         
    ## [15] "use_tidy_support"         "tidy_labels"             
    ## [17] "use_tidy_versions"        "write_union"             
    ## [19] "use_roxygen_md"           "browse_github"           
    ## [21] "edit_git_config"          "use_description_defaults"
    ## [23] "edit_r_makevars"          "use_github_labels"       
    ## [25] "use_tidy_description"     "use_binder_badge"        
    ## [27] "use_cc0_license"          "write_over"              
    ## [29] "use_template"             "create_project"          
    ## [31] "browse_github_issues"     "use_bioc_badge"          
    ## [33] "edit_file"                "use_tidy_contributing"   
    ## [35] "edit_rstudio_snippets"    "browse_github_pulls"     
    ## [37] "use_tibble"               "use_version"             
    ## [39] "use_tidy_issue_template"  "use_depsy_badge"         
    ## [41] "use_usethis"              "edit_git_ignore"         
    ## [43] "use_tidy_ci"              "use_badge"               
    ## [45] "use_r"                    "browse_travis"           
    ## [47] "use_rmarkdown_template"   "proj_sitrep"             
    ## [49] "use_tidy_coc"             "use_tidy_eval"           
    ## [51] "use_spell_check"          "use_tidy_style"          
    ## [53] "proj_path"                "use_pkgdown"             
    ## [55] "use_namespace"            "use_pipe"                
    ## [57] "use_course"
