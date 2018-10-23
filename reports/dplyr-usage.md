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

    ## # A tibble: 703 x 2
    ##    pkg                  n
    ##    <chr>            <int>
    ##  1 landscapemetrics  1601
    ##  2 DiagrammeR        1153
    ##  3 xpose              444
    ##  4 tidyhydat          352
    ##  5 datasus            350
    ##  6 ggstatsplot        256
    ##  7 rubias             251
    ##  8 atlantistools      239
    ##  9 heemod             223
    ## 10 biomartr           198
    ## # ... with 693 more rows

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
    ##    fun            n percent
    ##    <chr>      <int> <chr>  
    ##  1 mutate      2883 14.1%  
    ##  2 filter      2209 10.8%  
    ##  3 select      2070 10.1%  
    ##  4 bind_rows   1655 8.1%   
    ##  5 group_by     931 4.6%   
    ##  6 left_join    692 3.4%   
    ##  7 select_      505 2.5%   
    ##  8 summarise    489 2.4%   
    ##  9 ungroup      468 2.3%   
    ## 10 bind_cols    456 2.2%   
    ## 11 arrange      435 2.1%   
    ## 12 mutate_      385 1.9%   
    ## 13 data_frame   370 1.8%   
    ## 14 filter_      368 1.8%   
    ## 15 group_by_    354 1.7%   
    ## 16 rename       313 1.5%   
    ## 17 pull         275 1.3%   
    ## 18 as_tibble    264 1.3%   
    ## 19 summarize    263 1.3%   
    ## 20 distinct     188 0.9%

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
    ##    fun            n percent
    ##    <chr>      <int> <chr>  
    ##  1 filter       306 43.5%  
    ##  2 mutate       303 43.1%  
    ##  3 select       287 40.8%  
    ##  4 bind_rows    266 37.8%  
    ##  5 group_by     214 30.4%  
    ##  6 left_join    166 23.6%  
    ##  7 arrange      149 21.2%  
    ##  8 ungroup      135 19.2%  
    ##  9 summarise    123 17.5%  
    ## 10 bind_cols    111 15.8%  
    ## 11 select_      109 15.5%  
    ## 12 rename       107 15.2%  
    ## 13 group_by_     95 13.5%  
    ## 14 data_frame    89 12.7%  
    ## 15 distinct      82 11.7%  
    ## 16 inner_join    77 11.0%  
    ## 17 mutate_       75 10.7%  
    ## 18 filter_       72 10.2%  
    ## 19 summarize     69 9.8%   
    ## 20 slice         66 9.4%

# Imports

The following counts come from reverse dependencies which explicitly
import functions from your package with `importFrom()` or `import()`.
While we don’t see how often they are using each function in this case,
we can see which functions are being imported.

## Reverse dependencies with full imports

249 reverse dependencies have ‘full’ imports, with `import(pkg)` in
their NAMESPACE. It is difficult to determine function usage of these
packages.

    ##   [1] "bupaR"                       "splithalf"                  
    ##   [3] "electoral"                   "caffsim"                    
    ##   [5] "tbrf"                        "robis"                      
    ##   [7] "WRTDStidal"                  "valr"                       
    ##   [9] "Rraven"                      "ggsom"                      
    ##  [11] "benthos"                     "CRANsearcher"               
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
    ##  [79] "anchoredDistr"               "gwdegree"                   
    ##  [81] "modeldb"                     "norris"                     
    ##  [83] "dbplot"                      "explor"                     
    ##  [85] "breathteststan"              "syllabifyr"                 
    ##  [87] "compareDF"                   "revengc"                    
    ##  [89] "lans2r"                      "gender"                     
    ##  [91] "spotifyr"                    "platetools"                 
    ##  [93] "treeplyr"                    "processmapR"                
    ##  [95] "imdbapi"                     "tidybayes"                  
    ##  [97] "macleish"                    "mnreadR"                    
    ##  [99] "xmrr"                        "adaptalint"                 
    ## [101] "PHEindicatormethods"         "rtypeform"                  
    ## [103] "wfindr"                      "fingertipscharts"           
    ## [105] "VWPre"                       "fingertipsR"                
    ## [107] "tidytidbits"                 "tidybayes"                  
    ## [109] "lilikoi"                     "broom"                      
    ## [111] "hydrolinks"                  "ggfortify"                  
    ## [113] "d3Tree"                      "interplot"                  
    ## [115] "xray"                        "autocogs"                   
    ## [117] "manifestoR"                  "IMP"                        
    ## [119] "quickReg"                    "nonmemica"                  
    ## [121] "widyr"                       "sambia"                     
    ## [123] "parlitools"                  "surveybootstrap"            
    ## [125] "nscprepr"                    "sfc"                        
    ## [127] "dextergui"                   "ubeR"                       
    ## [129] "longurl"                     "jpndistrict"                
    ## [131] "trelliscopejs"               "didrooRFM"                  
    ## [133] "dsr"                         "RSSL"                       
    ## [135] "dlookr"                      "Plasmidprofiler"            
    ## [137] "LendingClub"                 "SWMPrExtension"             
    ## [139] "bootnet"                     "staRdom"                    
    ## [141] "finreportr"                  "DeLorean"                   
    ## [143] "rcicr"                       "ggedit"                     
    ## [145] "electionsBR"                 "SimplifyStats"              
    ## [147] "RCMIP5"                      "PogromcyDanych"             
    ## [149] "qsub"                        "afmToolkit"                 
    ## [151] "mnis"                        "genderBR"                   
    ## [153] "lookupTable"                 "ledger"                     
    ## [155] "ether"                       "quickpsy"                   
    ## [157] "eyetrackingR"                "ppcSpatial"                 
    ## [159] "geotoolsR"                   "meetupapi"                  
    ## [161] "tidycensus"                  "fastqcr"                    
    ## [163] "BatchGetSymbols"             "gutenbergr"                 
    ## [165] "FRK"                         "turfR"                      
    ## [167] "tidystats"                   "PNADcIBGE"                  
    ## [169] "adjustedcranlogs"            "dynutils"                   
    ## [171] "tidypredict"                 "dexterMST"                  
    ## [173] "UCSCXenaTools"               "chunked"                    
    ## [175] "imputeTestbench"             "parSim"                     
    ## [177] "scholar"                     "wrangle"                    
    ## [179] "AnglerCreelSurveySimulation" "yorkr"                      
    ## [181] "sorvi"                       "BrailleR"                   
    ## [183] "konfound"                    "coopProductGame"            
    ## [185] "SpaCCr"                      "mlVAR"                      
    ## [187] "graphicalVAR"                "chromer"                    
    ## [189] "gastempt"                    "dbplyr"                     
    ## [191] "neuropsychology"             "RtutoR"                     
    ## [193] "processanimateR"             "psycho"                     
    ## [195] "etl"                         "edeaR"                      
    ## [197] "pRF"                         "Countr"                     
    ## [199] "fbar"                        "Tmisc"                      
    ## [201] "SVMMaj"                      "DisImpact"                  
    ## [203] "comperes"                    "NOAAWeather"                
    ## [205] "radiant.data"                "MLZ"                        
    ## [207] "keyholder"                   "broom.mixed"                
    ## [209] "goldi"                       "REddyProc"                  
    ## [211] "shinyHeatmaply"              "psychmeta"                  
    ## [213] "feedeR"                      "breathtestcore"             
    ## [215] "crawl"                       "msigdbr"                    
    ## [217] "morse"                       "ahpsurvey"                  
    ## [219] "flatr"                       "rusk"                       
    ## [221] "dexter"                      "proPubBills"                
    ## [223] "idbr"                        "denovolyzeR"                
    ## [225] "phenomap"                    "M2SMF"                      
    ## [227] "StratifiedRF"                "processmonitR"              
    ## [229] "freqweights"                 "tree.bins"                  
    ## [231] "mase"                        "cometExactTest"             
    ## [233] "tidytext"                    "HTSSIP"                     
    ## [235] "rpcdsearch"                  "timelineS"                  
    ## [237] "catcont"                     "baseballDBR"                
    ## [239] "ggraptR"                     "summariser"                 
    ## [241] "healthcareai"                "incgraph"                   
    ## [243] "networkreporting"            "nmfem"                      
    ## [245] "gvcR"                        "OutliersO3"                 
    ## [247] "gitgadget"                   "IAT"                        
    ## [249] "idealstan"

## Reverse dependencies with the most functions imported

``` r
selective_imports %>% count(pkg) %>% arrange(desc(n))
```

    ## # A tibble: 401 x 2
    ##    pkg                n
    ##    <chr>          <int>
    ##  1 radiant           62
    ##  2 srvyr             54
    ##  3 statar            46
    ##  4 genogeographer    38
    ##  5 tidybayes         38
    ##  6 DiagrammeR        37
    ##  7 tidygraph         37
    ##  8 reReg             32
    ##  9 tigger            32
    ## 10 sparklyr          30
    ## # ... with 391 more rows

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

    ## # A tibble: 20 x 3
    ##    fun            n percent
    ##    <chr>      <int> <chr>  
    ##  1 mutate       167 41.6%  
    ##  2 select       160 39.9%  
    ##  3 filter       156 38.9%  
    ##  4 group_by     145 36.2%  
    ##  5 bind_rows    140 34.9%  
    ##  6 arrange       88 21.9%  
    ##  7 left_join     82 20.4%  
    ##  8 summarise     82 20.4%  
    ##  9 ungroup       71 17.7%  
    ## 10 bind_cols     66 16.5%  
    ## 11 rename        60 15.0%  
    ## 12 n             56 14.0%  
    ## 13 select_       53 13.2%  
    ## 14 summarize     47 11.7%  
    ## 15 group_by_     44 11.0%  
    ## 16 inner_join    43 10.7%  
    ## 17 slice         43 10.7%  
    ## 18 full_join     42 10.5%  
    ## 19 mutate_       39 9.7%   
    ## 20 funs          38 9.5%

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
