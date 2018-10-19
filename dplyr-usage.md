Query function usage by package dependencies
================

    ## gtar: */R/*: Not found in archive
    ## gtar: Exiting with failure status due to previous errors
    ## gtar: */R/*: Not found in archive
    ## gtar: Exiting with failure status due to previous errors

# Call analysis

The following counts are all from explicit calls to your package, e.g.
`pkg::foo()`.

## Packages with most calls

These are generally the packages which are the heaviest users of your
package.

``` r
calls %>% count(pkg) %>% arrange(desc(n))
```

    ## # A tibble: 700 x 2
    ##    pkg                  n
    ##    <chr>            <int>
    ##  1 landscapemetrics  1603
    ##  2 DiagrammeR        1136
    ##  3 xpose              444
    ##  4 datasus            350
    ##  5 tidyhydat          340
    ##  6 ggstatsplot        256
    ##  7 rubias             251
    ##  8 atlantistools      245
    ##  9 heemod             230
    ## 10 tsibble            205
    ## # ... with 690 more rows

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
    ##    fun            n percent
    ##    <chr>      <int> <chr>  
    ##  1 mutate      2869 14.2%  
    ##  2 filter      2196 10.8%  
    ##  3 select      2067 10.2%  
    ##  4 bind_rows   1648 8.1%   
    ##  5 group_by     924 4.6%   
    ##  6 left_join    684 3.4%   
    ##  7 select_      505 2.5%   
    ##  8 summarise    478 2.4%   
    ##  9 ungroup      461 2.3%   
    ## 10 bind_cols    439 2.2%   
    ## 11 arrange      433 2.1%   
    ## 12 mutate_      385 1.9%   
    ## 13 filter_      368 1.8%   
    ## 14 data_frame   360 1.8%   
    ## 15 group_by_    354 1.7%   
    ## 16 rename       308 1.5%   
    ## 17 pull         270 1.3%   
    ## 18 summarize    261 1.3%   
    ## 19 as_tibble    255 1.3%   
    ## 20 distinct     187 0.9%

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
    ##    fun            n percent
    ##    <chr>      <int> <chr>  
    ##  1 filter       306 6.56%  
    ##  2 mutate       301 6.45%  
    ##  3 select       282 6.04%  
    ##  4 bind_rows    266 5.70%  
    ##  5 group_by     212 4.54%  
    ##  6 left_join    165 3.54%  
    ##  7 arrange      147 3.15%  
    ##  8 ungroup      133 2.85%  
    ##  9 summarise    122 2.61%  
    ## 10 bind_cols    111 2.38%  
    ## 11 select_      109 2.34%  
    ## 12 rename       105 2.25%  
    ## 13 group_by_     96 2.06%  
    ## 14 data_frame    89 1.91%  
    ## 15 distinct      81 1.74%  
    ## 16 inner_join    76 1.63%  
    ## 17 mutate_       76 1.63%  
    ## 18 filter_       73 1.56%  
    ## 19 slice         66 1.41%  
    ## 20 summarize     66 1.41%

# Imports

The following counts come from dependencies which explicitly import
functions from your package with `importFrom()` or `import()`. While we
don’t see how often they are using each function in this case, we can
see which functions are being imported.

## Packages with full imports

247 have ‘full’ imports, with `import(pkg)` in their NAMESPACE. It is
difficult to determine function usage of these packages.

``` r
full_imports
```

    ##   [1] "bupaR"                       "splithalf"                  
    ##   [3] "electoral"                   "caffsim"                    
    ##   [5] "tbrf"                        "robis"                      
    ##   [7] "WRTDStidal"                  "valr"                       
    ##   [9] "Rraven"                      "ggsom"                      
    ##  [11] "CRANsearcher"                "benthos"                    
    ##  [13] "survivalAnalysis"            "refund.shiny"               
    ##  [15] "toxplot"                     "IDE"                        
    ##  [17] "PWFSLSmoke"                  "ezsummary"                  
    ##  [19] "bulletr"                     "xesreadR"                   
    ##  [21] "petrinetR"                   "corrr"                      
    ##  [23] "egor"                        "openair"                    
    ##  [25] "ESTER"                       "evaluator"                  
    ##  [27] "telefit"                     "tbl2xts"                    
    ##  [29] "sourceR"                     "rchess"                     
    ##  [31] "stminsights"                 "SEERaBomb"                  
    ##  [33] "muir"                        "worldmet"                   
    ##  [35] "BETS"                        "dggridR"                    
    ##  [37] "exuber"                      "linkspotter"                
    ##  [39] "ARTool"                      "SanzCircos"                 
    ##  [41] "forestmodel"                 "randomForestExplainer"      
    ##  [43] "ezec"                        "funModeling"                
    ##  [45] "sampler"                     "rollmatch"                  
    ##  [47] "ruler"                       "qicharts2"                  
    ##  [49] "VarBundle"                   "lvnet"                      
    ##  [51] "eechidna"                    "rmdHelpers"                 
    ##  [53] "textmining"                  "Modelcharts"                
    ##  [55] "cricketr"                    "coalitions"                 
    ##  [57] "merTools"                    "reclin"                     
    ##  [59] "stability"                   "ukbtools"                   
    ##  [61] "processcheckR"               "saeSim"                     
    ##  [63] "understandBPMN"              "EFDR"                       
    ##  [65] "flora"                       "colorednoise"               
    ##  [67] "lpirfs"                      "WufooR"                     
    ##  [69] "comperank"                   "SCORPIUS"                   
    ##  [71] "metaviz"                     "ggmuller"                   
    ##  [73] "echor"                       "parsemsf"                   
    ##  [75] "rrr"                         "pivottabler"                
    ##  [77] "broom.mixed"                 "tigris"                     
    ##  [79] "gwdegree"                    "anchoredDistr"              
    ##  [81] "modeldb"                     "norris"                     
    ##  [83] "dbplot"                      "explor"                     
    ##  [85] "breathteststan"              "syllabifyr"                 
    ##  [87] "compareDF"                   "revengc"                    
    ##  [89] "lans2r"                      "gender"                     
    ##  [91] "spotifyr"                    "platetools"                 
    ##  [93] "treeplyr"                    "processmapR"                
    ##  [95] "imdbapi"                     "macleish"                   
    ##  [97] "tidybayes"                   "mnreadR"                    
    ##  [99] "xmrr"                        "adaptalint"                 
    ## [101] "PHEindicatormethods"         "rtypeform"                  
    ## [103] "wfindr"                      "fingertipscharts"           
    ## [105] "VWPre"                       "fingertipsR"                
    ## [107] "tidytidbits"                 "lilikoi"                    
    ## [109] "broom"                       "hydrolinks"                 
    ## [111] "ggfortify"                   "d3Tree"                     
    ## [113] "interplot"                   "xray"                       
    ## [115] "autocogs"                    "manifestoR"                 
    ## [117] "IMP"                         "quickReg"                   
    ## [119] "nonmemica"                   "widyr"                      
    ## [121] "parlitools"                  "sambia"                     
    ## [123] "surveybootstrap"             "nscprepr"                   
    ## [125] "dextergui"                   "sfc"                        
    ## [127] "ubeR"                        "longurl"                    
    ## [129] "jpndistrict"                 "trelliscopejs"              
    ## [131] "didrooRFM"                   "dsr"                        
    ## [133] "dlookr"                      "RSSL"                       
    ## [135] "Plasmidprofiler"             "LendingClub"                
    ## [137] "SWMPrExtension"              "bootnet"                    
    ## [139] "staRdom"                     "finreportr"                 
    ## [141] "DeLorean"                    "rcicr"                      
    ## [143] "ggedit"                      "electionsBR"                
    ## [145] "SimplifyStats"               "RCMIP5"                     
    ## [147] "PogromcyDanych"              "qsub"                       
    ## [149] "afmToolkit"                  "mnis"                       
    ## [151] "genderBR"                    "lookupTable"                
    ## [153] "ledger"                      "ether"                      
    ## [155] "quickpsy"                    "eyetrackingR"               
    ## [157] "ppcSpatial"                  "geotoolsR"                  
    ## [159] "meetupapi"                   "tidycensus"                 
    ## [161] "fastqcr"                     "BatchGetSymbols"            
    ## [163] "gutenbergr"                  "FRK"                        
    ## [165] "turfR"                       "tidystats"                  
    ## [167] "PNADcIBGE"                   "adjustedcranlogs"           
    ## [169] "dynutils"                    "tidypredict"                
    ## [171] "dexterMST"                   "UCSCXenaTools"              
    ## [173] "chunked"                     "imputeTestbench"            
    ## [175] "parSim"                      "scholar"                    
    ## [177] "wrangle"                     "AnglerCreelSurveySimulation"
    ## [179] "yorkr"                       "sorvi"                      
    ## [181] "BrailleR"                    "konfound"                   
    ## [183] "coopProductGame"             "SpaCCr"                     
    ## [185] "mlVAR"                       "graphicalVAR"               
    ## [187] "chromer"                     "gastempt"                   
    ## [189] "dbplyr"                      "neuropsychology"            
    ## [191] "RtutoR"                      "processanimateR"            
    ## [193] "psycho"                      "etl"                        
    ## [195] "edeaR"                       "pRF"                        
    ## [197] "Countr"                      "fbar"                       
    ## [199] "Tmisc"                       "SVMMaj"                     
    ## [201] "DisImpact"                   "comperes"                   
    ## [203] "NOAAWeather"                 "radiant.data"               
    ## [205] "MLZ"                         "keyholder"                  
    ## [207] "goldi"                       "REddyProc"                  
    ## [209] "shinyHeatmaply"              "psychmeta"                  
    ## [211] "feedeR"                      "crawl"                      
    ## [213] "breathtestcore"              "msigdbr"                    
    ## [215] "morse"                       "ahpsurvey"                  
    ## [217] "flatr"                       "rusk"                       
    ## [219] "dexter"                      "proPubBills"                
    ## [221] "idbr"                        "denovolyzeR"                
    ## [223] "phenomap"                    "M2SMF"                      
    ## [225] "StratifiedRF"                "processmonitR"              
    ## [227] "freqweights"                 "tree.bins"                  
    ## [229] "mase"                        "cometExactTest"             
    ## [231] "tidytext"                    "HTSSIP"                     
    ## [233] "rpcdsearch"                  "timelineS"                  
    ## [235] "catcont"                     "baseballDBR"                
    ## [237] "ggraptR"                     "summariser"                 
    ## [239] "healthcareai"                "incgraph"                   
    ## [241] "networkreporting"            "nmfem"                      
    ## [243] "gvcR"                        "OutliersO3"                 
    ## [245] "gitgadget"                   "IAT"                        
    ## [247] "idealstan"

## Pkgs with most functions imported

``` r
selective_imports %>% count(pkg) %>% arrange(desc(n))
```

    ## # A tibble: 398 x 2
    ##    pkg                n
    ##    <chr>          <int>
    ##  1 radiant           62
    ##  2 srvyr             54
    ##  3 statar            46
    ##  4 sugrrants         40
    ##  5 genogeographer    38
    ##  6 DiagrammeR        37
    ##  7 tidygraph         37
    ##  8 tigger            32
    ##  9 sparklyr          30
    ## 10 alakazam          29
    ## # ... with 388 more rows

## Which functions are most often imported?

These are the functions which your dependencies find most useful.

``` r
selective_imports %>%
  count(fun) %>%
  mutate(percent = scales::percent(n / sum(n))) %>%
  arrange(desc(n)) %>%
  head(20)
```

    ## # A tibble: 20 x 3
    ##    fun            n percent
    ##    <chr>      <int> <chr>  
    ##  1 mutate       165 6.05%  
    ##  2 select       157 5.76%  
    ##  3 filter       155 5.68%  
    ##  4 group_by     141 5.17%  
    ##  5 bind_rows    136 4.99%  
    ##  6 arrange       88 3.23%  
    ##  7 summarise     81 2.97%  
    ##  8 left_join     80 2.93%  
    ##  9 ungroup       71 2.60%  
    ## 10 bind_cols     63 2.31%  
    ## 11 rename        58 2.13%  
    ## 12 n             55 2.02%  
    ## 13 select_       53 1.94%  
    ## 14 summarize     45 1.65%  
    ## 15 group_by_     44 1.61%  
    ## 16 inner_join    42 1.54%  
    ## 17 slice         42 1.54%  
    ## 18 full_join     39 1.43%  
    ## 19 mutate_       39 1.43%  
    ## 20 distinct      37 1.36%

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

    ##  [1] "eval_tbls"         "tally_"            "syms"             
    ##  [4] "add_tally_"        "percent_rank"      "rename_vars"      
    ##  [7] "wrap_dbplyr_obj"   "enexprs"           "sym"              
    ## [10] "changes"           "arrange_if"        "compare_tbls"     
    ## [13] "cummean"           "tbl_sum"           "transmute_if"     
    ## [16] "ensym"             "current_vars"      "dr_dplyr"         
    ## [19] "cumany"            "add_count_"        "frame_data"       
    ## [22] "show_query"        "enexpr"            "order_by"         
    ## [25] "enquos"            "location"          "lst_"             
    ## [28] "src_df"            "compare_tbls2"     "tbl_nongroup_vars"
    ## [31] "%>%"               "ensyms"            "expr"             
    ## [34] "eval_tbls2"        "bench_tbls"        "cume_dist"        
    ## [37] "make_tbl"          "ident"
