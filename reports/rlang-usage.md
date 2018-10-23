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

    ## # A tibble: 172 x 2
    ##    pkg              n
    ##    <chr>        <int>
    ##  1 DiagrammeR     304
    ##  2 ggstatsplot    175
    ##  3 sparklyr       155
    ##  4 pmatch          94
    ##  5 healthcareai    90
    ##  6 tailr           89
    ##  7 pointblank      72
    ##  8 driftR          69
    ##  9 stability       58
    ## 10 sealr           53
    ## # ... with 162 more rows

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
    ##    fun                n percent
    ##    <chr>          <int> <chr>  
    ##  1 enquo            672 23.5%  
    ##  2 sym              254 8.9%   
    ##  3 quo_name         163 5.7%   
    ##  4 eval_tidy        123 4.3%   
    ##  5 quos             110 3.8%   
    ##  6 get_expr          89 3.1%   
    ##  7 syms              80 2.8%   
    ##  8 expr_text         79 2.8%   
    ##  9 quo               77 2.7%   
    ## 10 dots_list         72 2.5%   
    ## 11 UQ                62 2.2%   
    ## 12 quasiquotation    47 1.6%   
    ## 13 expr              43 1.5%   
    ## 14 enexpr            41 1.4%   
    ## 15 set_names         38 1.3%   
    ## 16 is_null           33 1.2%   
    ## 17 quo_text          28 1.0%   
    ## 18 is_symbol         27 0.9%   
    ## 19 as_function       24 0.8%   
    ## 20 ensym             24 0.8%

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
    ##    fun             n percent
    ##    <chr>       <int> <chr>  
    ##  1 enquo          57 33.1%  
    ##  2 sym            37 21.5%  
    ##  3 quo_name       35 20.3%  
    ##  4 eval_tidy      32 18.6%  
    ##  5 quos           31 18.0%  
    ##  6 syms           31 18.0%  
    ##  7 quo            20 11.6%  
    ##  8 set_names      17 9.9%   
    ##  9 expr           14 8.1%   
    ## 10 as_function    12 7.0%   
    ## 11 f_rhs          12 7.0%   
    ## 12 is_formula     12 7.0%   
    ## 13 is_true        11 6.4%   
    ## 14 expr_text      10 5.8%   
    ## 15 exprs          10 5.8%   
    ## 16 is_null        10 5.8%   
    ## 17 parse_expr     10 5.8%   
    ## 18 abort           9 5.2%   
    ## 19 as_quosure      9 5.2%   
    ## 20 enexpr          9 5.2%

# Imports

The following counts come from reverse dependencies which explicitly
import functions from your package with `importFrom()` or `import()`.
While we don’t see how often they are using each function in this case,
we can see which functions are being imported.

## Reverse dependencies with full imports

56 reverse dependencies have ‘full’ imports, with `import(pkg)` in their
NAMESPACE. It is difficult to determine function usage of these
packages.

    ##  [1] "fabricatr"        "profile"          "tbrf"            
    ##  [4] "tidyr"            "gestalt"          "survivalAnalysis"
    ##  [7] "vdiffr"           "tidyselect"       "purrr"           
    ## [10] "corrr"            "dplyr"            "tidymodels"      
    ## [13] "pkgdown"          "stability"        "CGPfunctions"    
    ## [16] "tsibble"          "modeldb"          "baystability"    
    ## [19] "dbplot"           "NPMOD"            "reprex"          
    ## [22] "VWPre"            "nofrills"         "srvyr"           
    ## [25] "tidytidbits"      "pillar"           "mlflow"          
    ## [28] "quickReg"         "jpndistrict"      "ipumsr"          
    ## [31] "tfestimators"     "dsr"              "SWMPrExtension"  
    ## [34] "carrier"          "naniar"           "hms"             
    ## [37] "embed"            "tibble"           "tidypredict"     
    ## [40] "konfound"         "tfdatasets"       "bayesammi"       
    ## [43] "dbplyr"           "RtutoR"           "dials"           
    ## [46] "RSDA"             "DisImpact"        "recipes"         
    ## [49] "pkgload"          "modelr"           "malariaAtlas"    
    ## [52] "conflicted"       "tidytext"         "bayesplot"       
    ## [55] "sugrrants"        "testthat"

## Reverse dependencies with the most functions imported

``` r
selective_imports %>% count(pkg) %>% arrange(desc(n))
```

    ## # A tibble: 159 x 2
    ##    pkg               n
    ##    <chr>         <int>
    ##  1 DeclareDesign    35
    ##  2 tidybayes        30
    ##  3 fabricatr        15
    ##  4 ggplot2          14
    ##  5 tidyhydat        13
    ##  6 tidygraph        12
    ##  7 recipes          10
    ##  8 DesignLibrary     9
    ##  9 estimatr          9
    ## 10 mosaicCore        9
    ## # ... with 149 more rows

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
    ##    fun              n percent
    ##    <chr>        <int> <chr>  
    ##  1 .data           69 43.4%  
    ##  2 enquo           39 24.5%  
    ##  3 sym             30 18.9%  
    ##  4 quos            26 16.4%  
    ##  5 syms            25 15.7%  
    ##  6 quo_name        19 11.9%  
    ##  7 eval_tidy       18 11.3%  
    ##  8 quo             17 10.7%  
    ##  9 enexpr           8 5.0%   
    ## 10 expr             8 5.0%   
    ## 11 f_rhs            8 5.0%   
    ## 12 quo_text         8 5.0%   
    ## 13 UQ               8 5.0%   
    ## 14 enquos           7 4.4%   
    ## 15 exprs            7 4.4%   
    ## 16 UQS              7 4.4%   
    ## 17 get_expr         5 3.1%   
    ## 18 is_character     5 3.1%   
    ## 19 is_true          5 3.1%   
    ## 20 as_quosure       4 2.5%

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

    ##   [1] "is_dbl_na"               "quo_get_env"            
    ##   [3] "return_to"               "rst_muffle"             
    ##   [5] "new_call"                "is_scoped"              
    ##   [7] "f_env<-"                 "as_box_if"              
    ##   [9] "%|%"                     "lang_head"              
    ##  [11] "list_along"              "lang_tail"              
    ##  [13] "env_bind_fns"            "is_callable"            
    ##  [15] "switch_class"            "new_character_along"    
    ##  [17] "set_chr_encoding"        "is_stack"               
    ##  [19] "chr_along"               "rst_jump"               
    ##  [21] "mut_attrs"               "is_scalar_raw"          
    ##  [23] "f_lhs<-"                 "is_bare_raw"            
    ##  [25] "str_encoding"            "new_data_mask"          
    ##  [27] "as_data_pronoun"         "call_standardise"       
    ##  [29] "squash_raw"              "is_raw"                 
    ##  [31] "rst_maybe_jump"          "int"                    
    ##  [33] "as_overscope"            "new_double"             
    ##  [35] "set_expr"                "rst_abort"              
    ##  [37] "new_integer"             "is_dictionary"          
    ##  [39] "bytes"                   "f_rhs<-"                
    ##  [41] "flatten_raw"             "is_node"                
    ##  [43] "mut_node_cadr"           "as_complex"             
    ##  [45] "locally"                 "chr_encoding"           
    ##  [47] "new_list_along"          "is_formulaish"          
    ##  [49] "cnd_inform"              "pkg_env_name"           
    ##  [51] "mut_node_caar"           "is_call_stack"          
    ##  [53] "as_utf8_string"          "qq_show"                
    ##  [55] "as_quosureish"           "as_data_mask"           
    ##  [57] "env_poke"                "scoped_options"         
    ##  [59] "is_lgl_na"               "new_logical"            
    ##  [61] "set_str_encoding"        "peek_option"            
    ##  [63] "as_environment"          "fn_env<-"               
    ##  [65] "restarting"              "call_inspect"           
    ##  [67] "as_pairlist"             "pkg_env"                
    ##  [69] "new_raw_along"           "coerce_lang"            
    ##  [71] "mut_node_cddr"           "fn_body"                
    ##  [73] "is_cpl_na"               "stack_trim"             
    ##  [75] "as_native_character"     "cpl_len"                
    ##  [77] "inplace"                 "dbl_len"                
    ##  [79] "is_bare_formula"         "na_int"                 
    ##  [81] "mut_node_cdar"           "fn_fmls<-"              
    ##  [83] "error_cnd"               "cnd"                    
    ##  [85] "na_chr"                  "with_env"               
    ##  [87] "squash_dbl"              "!!"                     
    ##  [89] "chr_len"                 "new_complex_along"      
    ##  [91] "as_native_string"        "node"                   
    ##  [93] "scoped_envs"             "int_along"              
    ##  [95] "call_depth"              ":="                     
    ##  [97] "f_name"                  "cpl_along"              
    ##  [99] "is_eval_stack"           "switch_type"            
    ## [101] "overscope_clean"         "bytes_len"              
    ## [103] "new_definition"          "frame_position"         
    ## [105] "cpl"                     "is_scalar_bytes"        
    ## [107] "call_modify"             "expr_label"             
    ## [109] "squash_lgl"              "node_poke_tag"          
    ## [111] "new_double_along"        "empty_env"              
    ## [113] "new_cnd"                 "unbox"                  
    ## [115] "node_poke_cdr"           "mut_node_tag"           
    ## [117] "lgl_len"                 "is_spliced"             
    ## [119] "is_quosureish"           "as_env"                 
    ## [121] "is_frame"                "node_poke_car"          
    ## [123] "new_integer_along"       "squash_int"             
    ## [125] "dbl"                     "new_complex"            
    ## [127] "new_formula"             "is_unary_lang"          
    ## [129] "new_environment"         "with_options"           
    ## [131] "current_frame"           "new_overscope"          
    ## [133] "is_int_na"               "prim_name"              
    ## [135] "with_restarts"           "cnd_message"            
    ## [137] "is_binary_lang"          "peek_options"           
    ## [139] "ns_imports_env"          "inherits_all"           
    ## [141] "is_chr_na"               "rst_exists"             
    ## [143] "env_parents"             "fn_fmls_syms"           
    ## [145] "f_label"                 "is_namespace"           
    ## [147] "int_len"                 "inherits_any"           
    ## [149] "na_cpl"                  "push_options"           
    ## [151] "node_tag"                "message_cnd"            
    ## [153] "string"                  "as_box"                 
    ## [155] "cnd_abort"               "is_node_list"           
    ## [157] "parse_quos"              "node_poke_cdar"         
    ## [159] "ctxt_depth"              "maybe_missing"          
    ## [161] "scoped_env"              "quo_is_lang"            
    ## [163] "lgl_along"               "%@%"                    
    ## [165] "is_box"                  "new_raw"                
    ## [167] "scoped_bindings"         "return_from"            
    ## [169] "fn_fmls_names"           "lgl"                    
    ## [171] "node_poke_cddr"          "env_bind_exprs"         
    ## [173] "is_bare_bytes"           "with_bindings"          
    ## [175] "warning_cnd"             "is_reference"           
    ## [177] "is_primitive_lazy"       "env_parent"             
    ## [179] "mut_node_car"            "squash_cpl"             
    ## [181] "node_caar"               "is_definition"          
    ## [183] "ctxt_frame"              "new_logical_along"      
    ## [185] "is_spliced_bare"         "new_box"                
    ## [187] "mut_node_cdr"            "fn_env"                 
    ## [189] "env_depth"               "catch_cnd"              
    ## [191] "flatten_cpl"             "vec_poke_range"         
    ## [193] "node_poke_caar"          "dbl_along"              
    ## [195] "is_primitive_eager"      "cnd_signal"             
    ## [197] "env_inherits"            "switch_lang"            
    ## [199] "new_node"                "is_copyable"            
    ## [201] "eval_tidy_"              "cnd_error"              
    ## [203] "has_length"              "expr_print"             
    ## [205] "new_character"           "node_poke_cadr"         
    ## [207] "fn_body<-"               "call_frame"             
    ## [209] "list_len"                "node_cdar"              
    ## [211] "call_args_names"         "is_bare_string"         
    ## [213] "env_poke_parent"         "fn_fmls_names<-"        
    ## [215] "new_language"            "as_dictionary"          
    ## [217] "overscope_eval_next"     "chr_unserialise_unicode"
    ## [219] "is_bytes"                "is_bare_env"            
    ## [221] "vec_poke_n"              "duplicate"              
    ## [223] "inherits_only"           "caller_fn"              
    ## [225] "ns_env_name"             "cnd_warning"            
    ## [227] "na_lgl"                  "node_cddr"              
    ## [229] "mut_mbcs_locale"         "lang_fn"                
    ## [231] "env_bind"                "lang_type_of"           
    ## [233] "raw_along"               "rst_list"               
    ## [235] "global_frame"            "as_bytes"               
    ## [237] "env_tail"                "bytes_along"            
    ## [239] "dots_definitions"        "cnd_warn"               
    ## [241] "call_stack"              "!!!"                    
    ## [243] "quo_set_env"             "mut_utf8_locale"        
    ## [245] "is_condition"            "%||%"                   
    ## [247] "exprs_auto_name"         "raw_len"                
    ## [249] "is_expr"
