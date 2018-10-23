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

    ## # A tibble: 80 x 2
    ##    pkg                n
    ##    <chr>          <int>
    ##  1 testthat          25
    ##  2 adapr             21
    ##  3 testthis          15
    ##  4 RSuite            14
    ##  5 RxODE             13
    ##  6 pkgmaker          12
    ##  7 packagedocs       11
    ##  8 exampletestr      10
    ##  9 understandBPMN    10
    ## 10 installr           9
    ## # ... with 70 more rows

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
    ##    fun                 n percent
    ##    <chr>           <int> <chr>  
    ##  1 install_github     53 17.7%  
    ##  2 document           31 10.4%  
    ##  3 load_all           23 7.7%   
    ##  4 test               19 6.4%   
    ##  5 as.package         17 5.7%   
    ##  6 package_file       17 5.7%   
    ##  7 use_data           15 5.0%   
    ##  8 session_info       12 4.0%   
    ##  9 install            10 3.3%   
    ## 10 clean_source        9 3.0%   
    ## 11 check               7 2.3%   
    ## 12 use_package         7 2.3%   
    ## 13 build               6 2.0%   
    ## 14 create              6 2.0%   
    ## 15 install_version     6 2.0%   
    ## 16 inst                5 1.7%   
    ## 17 github_pat          4 1.3%   
    ## 18 install_bioc        4 1.3%   
    ## 19 install_deps        3 1.0%   
    ## 20 loaded_packages     3 1.0%

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
    ##    fun                 n percent
    ##    <chr>           <int> <chr>  
    ##  1 install_github     27 33.8%  
    ##  2 document           13 16.2%  
    ##  3 load_all           12 15.0%  
    ##  4 as.package          9 11.2%  
    ##  5 test                9 11.2%  
    ##  6 use_data            7 8.7%   
    ##  7 check               6 7.5%   
    ##  8 install             6 7.5%   
    ##  9 session_info        6 7.5%   
    ## 10 build               5 6.2%   
    ## 11 create              4 5.0%   
    ## 12 install_version     4 5.0%   
    ## 13 package_file        4 5.0%   
    ## 14 github_pat          3 3.8%   
    ## 15 build_vignettes     2 2.5%   
    ## 16 build_win           2 2.5%   
    ## 17 inst                2 2.5%   
    ## 18 install_deps        2 2.5%   
    ## 19 loaded_packages     2 2.5%   
    ## 20 release             2 2.5%

# Imports

The following counts come from reverse dependencies which explicitly
import functions from your package with `importFrom()` or `import()`.
While we don’t see how often they are using each function in this case,
we can see which functions are being imported.

## Reverse dependencies with full imports

10 reverse dependencies have ‘full’ imports, with `import(pkg)` in their
NAMESPACE. It is difficult to determine function usage of these
packages.

    ##  [1] "uavRmp"              "Orcs"                "wru"                
    ##  [4] "RSuite"              "understandBPMN"      "Ricetl"             
    ##  [7] "reproducible"        "soilcarbon"          "populationPDXdesign"
    ## [10] "creditr"

## Reverse dependencies with the most functions imported

``` r
selective_imports %>% count(pkg) %>% arrange(desc(n))
```

    ## # A tibble: 23 x 2
    ##    pkg                     n
    ##    <chr>               <int>
    ##  1 DataPackageR            4
    ##  2 bisectr                 3
    ##  3 dynutils                2
    ##  4 easypackages            2
    ##  5 githubinstall           2
    ##  6 microsamplingDesign     2
    ##  7 packagedocs             2
    ##  8 rbundler                2
    ##  9 teachingApps            2
    ## 10 BioInstaller            1
    ## # ... with 13 more rows

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

    ## # A tibble: 18 x 3
    ##    fun                   n percent
    ##    <chr>             <int> <chr>  
    ##  1 install_github       12 52.2%  
    ##  2 as.package            3 13.0%  
    ##  3 install               2 8.7%   
    ##  4 install_cran          2 8.7%   
    ##  5 load_all              2 8.7%   
    ##  6 parse_deps            2 8.7%   
    ##  7 build                 1 4.3%   
    ##  8 build_vignettes       1 4.3%   
    ##  9 dev_mode              1 4.3%   
    ## 10 dev_package_deps      1 4.3%   
    ## 11 document              1 4.3%   
    ## 12 github_pull           1 4.3%   
    ## 13 install_bitbucket     1 4.3%   
    ## 14 install_url           1 4.3%   
    ## 15 package_file          1 4.3%   
    ## 16 reload                1 4.3%   
    ## 17 session_info          1 4.3%   
    ## 18 use_cran_badge        1 4.3%

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
    ## [53] "use_news_md"                 "github_release"             
    ## [55] "setup"                       "test_coverage_file"         
    ## [57] "use_rstudio"                 "check_dep_version"          
    ## [59] "submit_cran"                 "install_gitlab"             
    ## [61] "check_win_oldrelease"        "unload"                     
    ## [63] "revdep_maintainers"          "has_tests"                  
    ## [65] "system_output"               "system_check"               
    ## [67] "lint"                        "revdep_check"               
    ## [69] "source_gist"                 "check_win_release"
