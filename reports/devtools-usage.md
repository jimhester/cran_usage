Query function usage by package dependencies
================

# Call analysis

The following counts are all from explicit calls to your package, e.g.
`pkg::foo()`.

## Packages with most calls

These are generally the packages which are the heaviest users of your
package.

``` r
calls %>% count(pkg) %>% arrange(desc(n))
```

    ## # A tibble: 81 x 2
    ##    pkg                n
    ##    <chr>          <int>
    ##  1 adapr             21
    ##  2 workflowr         16
    ##  3 testthis          15
    ##  4 RSuite            14
    ##  5 testthat          14
    ##  6 RxODE             13
    ##  7 pkgmaker          12
    ##  8 packagedocs       11
    ##  9 exampletestr      10
    ## 10 understandBPMN    10
    ## # ... with 71 more rows

## Functions most called

There are the functions from your package dependencies are using most
frequently.

``` r
calls %>% 
  count(fun) %>% 
  mutate(percent = scales::percent(n / sum(n))) %>%
  arrange(desc(n)) %>% 
  head(20)
```

    ## # A tibble: 20 x 3
    ##    fun                 n percent
    ##    <chr>           <int> <chr>  
    ##  1 install_github     54 17.7%  
    ##  2 document           30 9.8%   
    ##  3 load_all           23 7.5%   
    ##  4 test               19 6.2%   
    ##  5 as.package         17 5.6%   
    ##  6 package_file       17 5.6%   
    ##  7 use_data           15 4.9%   
    ##  8 session_info       12 3.9%   
    ##  9 install            10 3.3%   
    ## 10 clean_source        9 3.0%   
    ## 11 check               7 2.3%   
    ## 12 use_package         7 2.3%   
    ## 13 build               6 2.0%   
    ## 14 create              6 2.0%   
    ## 15 install_version     6 2.0%   
    ## 16 inst                5 1.6%   
    ## 17 github_pat          4 1.3%   
    ## 18 install_bioc        4 1.3%   
    ## 19 install_deps        3 1.0%   
    ## 20 loaded_packages     3 1.0%

## How many packages use each function

This helps determine how broad function usage is across packages.

``` r
calls %>%
  select(pkg, fun) %>%
  unique() %>%
  count(fun) %>%
  mutate(percent = scales::percent(n / sum(n))) %>%
  arrange(desc(n)) %>%
  head(20)
```

    ## # A tibble: 20 x 3
    ##    fun                 n percent
    ##    <chr>           <int> <chr>  
    ##  1 install_github     29 17.5%  
    ##  2 document           13 7.8%   
    ##  3 load_all           12 7.2%   
    ##  4 as.package          9 5.4%   
    ##  5 test                9 5.4%   
    ##  6 install             7 4.2%   
    ##  7 use_data            7 4.2%   
    ##  8 check               6 3.6%   
    ##  9 session_info        6 3.6%   
    ## 10 build               5 3.0%   
    ## 11 create              4 2.4%   
    ## 12 install_version     4 2.4%   
    ## 13 package_file        4 2.4%   
    ## 14 github_pat          3 1.8%   
    ## 15 build_vignettes     2 1.2%   
    ## 16 build_win           2 1.2%   
    ## 17 github_pull         2 1.2%   
    ## 18 inst                2 1.2%   
    ## 19 install_deps        2 1.2%   
    ## 20 loaded_packages     2 1.2%

# Imports

The following counts come from dependencies which explicitly import
functions from your package with `importFrom()` or `import()`. While we
don’t see how often they are using each function in this case, we can
see which functions are being imported.

## Packages with full imports

10 have ‘full’ imports, with `import(pkg)` in their NAMESPACE. It is
difficult to determine function usage of these
    packages.

``` r
full_imports
```

    ##  [1] "uavRmp"              "Orcs"                "wru"                
    ##  [4] "RSuite"              "understandBPMN"      "Ricetl"             
    ##  [7] "reproducible"        "soilcarbon"          "populationPDXdesign"
    ## [10] "creditr"

## Pkgs with most functions imported

``` r
selective_imports %>% count(pkg) %>% arrange(desc(n))
```

    ## # A tibble: 24 x 2
    ##    pkg                     n
    ##    <chr>               <int>
    ##  1 DataPackageR            4
    ##  2 bisectr                 3
    ##  3 dynutils                2
    ##  4 easypackages            2
    ##  5 githubinstall           2
    ##  6 microsamplingDesign     2
    ##  7 msgtools                2
    ##  8 packagedocs             2
    ##  9 rbundler                2
    ## 10 teachingApps            2
    ## # ... with 14 more rows

## Which functions are most often imported?

These are the functions which your dependencies find most useful.

``` r
selective_imports %>%
  count(fun) %>%
  mutate(percent = scales::percent(n / sum(n))) %>%
  arrange(desc(n)) %>%
  head(20)
```

    ## # A tibble: 19 x 3
    ##    fun                   n percent
    ##    <chr>             <int> <chr>  
    ##  1 install_github       12 32.4%  
    ##  2 as.package            4 10.8%  
    ##  3 install               2 5.4%   
    ##  4 install_cran          2 5.4%   
    ##  5 load_all              2 5.4%   
    ##  6 parse_deps            2 5.4%   
    ##  7 build                 1 2.7%   
    ##  8 build_vignettes       1 2.7%   
    ##  9 create                1 2.7%   
    ## 10 dev_mode              1 2.7%   
    ## 11 dev_package_deps      1 2.7%   
    ## 12 document              1 2.7%   
    ## 13 github_pull           1 2.7%   
    ## 14 install_bitbucket     1 2.7%   
    ## 15 install_url           1 2.7%   
    ## 16 package_file          1 2.7%   
    ## 17 reload                1 2.7%   
    ## 18 session_info          1 2.7%   
    ## 19 use_cran_badge        1 2.7%

## Which functions are never used by dependencies?

These are the functions no dependency is using either by calls or
importing. These functions either need better documentation / publicity,
are meant for interactive use rather than in packages, or do not provide
a useful function and should be considered for removal.

``` r
exports <- getNamespaceExports(pkg)

exports[
  !exports %in% c(calls$fun, selective_imports$fun)
]
```

    ##  [1] "install_local"               "revdep_check_save_summary"  
    ##  [3] "revdep"                      "clean_vignettes"            
    ##  [5] "check_man"                   "revdep_email"               
    ##  [7] "dr_devtools"                 "revdep_check_resume"        
    ##  [9] "build_site"                  "use_mit_license"            
    ## [11] "use_testthat"                "bash"                       
    ## [13] "build_manual"                "use_rcpp"                   
    ## [15] "use_coverage"                "clean_dll"                  
    ## [17] "build_readme"                "use_package_doc"            
    ## [19] "install_git"                 "use_cran_comments"          
    ## [21] "test_file"                   "use_readme_rmd"             
    ## [23] "install_svn"                 "check_failures"             
    ## [25] "use_github_links"            "use_revdep"                 
    ## [27] "update_packages"             "with_debug"                 
    ## [29] "package_info"                "check_cran"                 
    ## [31] "uninstall"                   "create_description"         
    ## [33] "revdep_check_print_problems" "use_readme_md"              
    ## [35] "use_gpl3_license"            "show_news"                  
    ## [37] "install_dev"                 "dr_github"                  
    ## [39] "dev_packages"                "use_git"                    
    ## [41] "wd"                          "missing_s3"                 
    ## [43] "has_devel"                   "use_test"                   
    ## [45] "release_checks"              "use_dev_version"            
    ## [47] "install_dev_deps"            "test_coverage"              
    ## [49] "devtest"                     "use_appveyor"               
    ## [51] "use_git_hook"                "revdep_check_reset"         
    ## [53] "use_news_md"                 "setup"                      
    ## [55] "test_coverage_file"          "use_rstudio"                
    ## [57] "check_dep_version"           "submit_cran"                
    ## [59] "install_gitlab"              "check_win_oldrelease"       
    ## [61] "unload"                      "revdep_maintainers"         
    ## [63] "has_tests"                   "system_output"              
    ## [65] "system_check"                "lint"                       
    ## [67] "revdep_check"                "source_gist"                
    ## [69] "check_win_release"
