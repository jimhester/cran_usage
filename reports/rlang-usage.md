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

    ## # A tibble: 171 x 2
    ##    pkg              n
    ##    <chr>        <int>
    ##  1 DiagrammeR     271
    ##  2 ggstatsplot    175
    ##  3 sparklyr       156
    ##  4 healthcareai    90
    ##  5 tailr           89
    ##  6 pointblank      72
    ##  7 driftR          69
    ##  8 pmatch          69
    ##  9 stability       58
    ## 10 sealr           53
    ## # ... with 161 more rows

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
    ##    fun                n percent
    ##    <chr>          <int> <chr>  
    ##  1 enquo            661 23.6%  
    ##  2 sym              252 9.0%   
    ##  3 quo_name         146 5.2%   
    ##  4 eval_tidy        123 4.4%   
    ##  5 quos             107 3.8%   
    ##  6 get_expr          89 3.2%   
    ##  7 expr_text         79 2.8%   
    ##  8 syms              79 2.8%   
    ##  9 quo               77 2.8%   
    ## 10 dots_list         72 2.6%   
    ## 11 UQ                62 2.2%   
    ## 12 quasiquotation    47 1.7%   
    ## 13 set_names         37 1.3%   
    ## 14 expr              35 1.3%   
    ## 15 enexpr            33 1.2%   
    ## 16 is_null           30 1.1%   
    ## 17 quo_text          28 1.0%   
    ## 18 is_symbol         25 0.9%   
    ## 19 as_function       24 0.9%   
    ## 20 ensym             24 0.9%

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
    ##    fun                n percent
    ##    <chr>          <int> <chr>  
    ##  1 enquo             58 7.56%  
    ##  2 sym               36 4.69%  
    ##  3 quo_name          33 4.30%  
    ##  4 eval_tidy         32 4.17%  
    ##  5 quos              31 4.04%  
    ##  6 syms              31 4.04%  
    ##  7 quo               21 2.74%  
    ##  8 set_names         15 1.96%  
    ##  9 expr              14 1.83%  
    ## 10 f_rhs             12 1.56%  
    ## 11 as_function       11 1.43%  
    ## 12 as_quosure        11 1.43%  
    ## 13 is_formula        11 1.43%  
    ## 14 is_true           11 1.43%  
    ## 15 expr_text         10 1.30%  
    ## 16 exprs             10 1.30%  
    ## 17 is_null           10 1.30%  
    ## 18 parse_expr        10 1.30%  
    ## 19 abort              9 1.17%  
    ## 20 quasiquotation     9 1.17%

# Imports

The following counts come from dependencies which explicitly import
functions from your package with `importFrom()` or `import()`. While we
don’t see how often they are using each function in this case, we can
see which functions are being imported.

## Packages with full imports

57 have ‘full’ imports, with `import(pkg)` in their NAMESPACE. It is
difficult to determine function usage of these packages.

``` r
full_imports
```

    ##  [1] "fabricatr"        "profile"          "tbrf"            
    ##  [4] "tidyr"            "gestalt"          "survivalAnalysis"
    ##  [7] "vdiffr"           "tidyselect"       "purrr"           
    ## [10] "corrr"            "dplyr"            "tidymodels"      
    ## [13] "pkgdown"          "stability"        "CGPfunctions"    
    ## [16] "tsibble"          "modeldb"          "baystability"    
    ## [19] "dbplot"           "NPMOD"            "reprex"          
    ## [22] "sugrrants"        "VWPre"            "nofrills"        
    ## [25] "srvyr"            "tidytidbits"      "pillar"          
    ## [28] "mlflow"           "quickReg"         "jpndistrict"     
    ## [31] "ipumsr"           "tfestimators"     "dsr"             
    ## [34] "SWMPrExtension"   "carrier"          "naniar"          
    ## [37] "hms"              "embed"            "tibble"          
    ## [40] "tidypredict"      "konfound"         "tfdatasets"      
    ## [43] "bayesammi"        "dbplyr"           "RtutoR"          
    ## [46] "dials"            "RSDA"             "DisImpact"       
    ## [49] "recipes"          "pkgload"          "modelr"          
    ## [52] "malariaAtlas"     "conflicted"       "tidytext"        
    ## [55] "bayesplot"        "sugrrants"        "testthat"

## Pkgs with most functions imported

``` r
selective_imports %>% count(pkg) %>% arrange(desc(n))
```

    ## # A tibble: 158 x 2
    ##    pkg               n
    ##    <chr>         <int>
    ##  1 DeclareDesign    35
    ##  2 fabricatr        15
    ##  3 tidybayes        15
    ##  4 ggplot2          14
    ##  5 tidyhydat        13
    ##  6 tidygraph        12
    ##  7 recipes          10
    ##  8 DesignLibrary     9
    ##  9 estimatr          9
    ## 10 mosaicCore        9
    ## # ... with 148 more rows

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
    ##    fun              n percent
    ##    <chr>        <int> <chr>  
    ##  1 .data           68 15.4%  
    ##  2 enquo           38 8.6%   
    ##  3 sym             29 6.6%   
    ##  4 quos            25 5.7%   
    ##  5 syms            24 5.4%   
    ##  6 quo_name        18 4.1%   
    ##  7 eval_tidy       17 3.8%   
    ##  8 quo             17 3.8%   
    ##  9 enexpr           8 1.8%   
    ## 10 expr             8 1.8%   
    ## 11 f_rhs            8 1.8%   
    ## 12 quo_text         8 1.8%   
    ## 13 UQ               8 1.8%   
    ## 14 exprs            7 1.6%   
    ## 15 UQS              7 1.6%   
    ## 16 enquos           6 1.4%   
    ## 17 get_expr         5 1.1%   
    ## 18 is_character     5 1.1%   
    ## 19 expr_text        4 0.9%   
    ## 20 is_lang          4 0.9%

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

    ##   [1] "is_dbl_na"               "as_quosures"            
    ##   [3] "quo_get_env"             "return_to"              
    ##   [5] "env_binding_are_lazy"    "new_call"               
    ##   [7] "is_scoped"               "f_env<-"                
    ##   [9] "as_box_if"               "%|%"                    
    ##  [11] "lang_head"               "list_along"             
    ##  [13] "lang_tail"               "env_bind_fns"           
    ##  [15] "is_callable"             "is_lambda"              
    ##  [17] "switch_class"            "new_character_along"    
    ##  [19] "env_bind_active"         "set_chr_encoding"       
    ##  [21] "is_stack"                "chr_along"              
    ##  [23] "rst_jump"                "env_name"               
    ##  [25] "env_length"              "cnd_muffle"             
    ##  [27] "mut_attrs"               "is_zap"                 
    ##  [29] "is_scalar_raw"           "f_lhs<-"                
    ##  [31] "signal"                  "str_encoding"           
    ##  [33] "is_bare_raw"             "new_data_mask"          
    ##  [35] "as_data_pronoun"         "exec"                   
    ##  [37] "squash_raw"              "call_standardise"       
    ##  [39] "is_raw"                  "rst_maybe_jump"         
    ##  [41] "int"                     "as_overscope"           
    ##  [43] "new_double"              "set_expr"               
    ##  [45] "search_env"              "rst_abort"              
    ##  [47] "new_integer"             "%@%<-"                  
    ##  [49] "is_dictionary"           "bytes"                  
    ##  [51] "last_error"              "f_rhs<-"                
    ##  [53] "flatten_raw"             "is_node"                
    ##  [55] "mut_node_cadr"           "as_complex"             
    ##  [57] "locally"                 "chr_encoding"           
    ##  [59] "new_list_along"          "is_formulaish"          
    ##  [61] "pkg_env_name"            "mut_node_caar"          
    ##  [63] "is_call_stack"           "as_utf8_string"         
    ##  [65] "qq_show"                 "as_quosureish"          
    ##  [67] "as_data_mask"            "zap"                    
    ##  [69] "env_label"               "env_poke"               
    ##  [71] "scoped_options"          "is_lgl_na"              
    ##  [73] "new_logical"             "set_str_encoding"       
    ##  [75] "peek_option"             "as_environment"         
    ##  [77] "fn_env<-"                "restarting"             
    ##  [79] "call_inspect"            "as_pairlist"            
    ##  [81] "pkg_env"                 "env_bind_lazy"          
    ##  [83] "new_raw_along"           "coerce_lang"            
    ##  [85] "mut_node_cddr"           "fn_body"                
    ##  [87] "is_cpl_na"               "search_envs"            
    ##  [89] "is_environment"          "stack_trim"             
    ##  [91] "as_native_character"     "cpl_len"                
    ##  [93] "dbl_len"                 "is_bare_formula"        
    ##  [95] "na_int"                  "mut_node_cdar"          
    ##  [97] "call_print_type"         "fn_fmls<-"              
    ##  [99] "with_env"                "error_cnd"              
    ## [101] "cnd"                     "na_chr"                 
    ## [103] "cnd_type"                "env_lock"               
    ## [105] "squash_dbl"              "!!"                     
    ## [107] "chr_len"                 "new_complex_along"      
    ## [109] "as_native_string"        "node"                   
    ## [111] "scoped_envs"             "int_along"              
    ## [113] "call_depth"              ":="                     
    ## [115] "f_name"                  "cpl_along"              
    ## [117] "is_eval_stack"           "switch_type"            
    ## [119] "overscope_clean"         "bytes_len"              
    ## [121] "new_definition"          "frame_position"         
    ## [123] "cpl"                     "is_scalar_bytes"        
    ## [125] "call_modify"             "interrupt"              
    ## [127] "expr_label"              "squash_lgl"             
    ## [129] "env_binding_are_locked"  "new_quosures"           
    ## [131] "node_poke_tag"           "trace_back"             
    ## [133] "new_double_along"        "unbox"                  
    ## [135] "empty_env"               "node_poke_cdr"          
    ## [137] "mut_node_tag"            "lgl_len"                
    ## [139] "is_spliced"              "is_quosureish"          
    ## [141] "as_env"                  "is_frame"               
    ## [143] "node_poke_car"           "new_integer_along"      
    ## [145] "squash_int"              "dbl"                    
    ## [147] "new_complex"             "env_binding_unlock"     
    ## [149] "new_formula"             "is_unary_lang"          
    ## [151] "new_environment"         "with_options"           
    ## [153] "current_frame"           "new_overscope"          
    ## [155] "is_int_na"               "prim_name"              
    ## [157] "with_restarts"           "is_binary_lang"         
    ## [159] "peek_options"            "ns_imports_env"         
    ## [161] "inherits_all"            "is_chr_na"              
    ## [163] "rst_exists"              "env_parents"            
    ## [165] "fn_fmls_syms"            "f_label"                
    ## [167] "env_is_locked"           "is_namespace"           
    ## [169] "int_len"                 "inherits_any"           
    ## [171] "na_cpl"                  "push_options"           
    ## [173] "node_tag"                "current_env"            
    ## [175] "message_cnd"             "string"                 
    ## [177] "as_box"                  "is_node_list"           
    ## [179] "parse_quos"              "node_poke_cdar"         
    ## [181] "ctxt_depth"              "maybe_missing"          
    ## [183] "current_fn"              "scoped_env"             
    ## [185] "quo_is_lang"             "lgl_along"              
    ## [187] "%@%"                     "is_box"                 
    ## [189] "new_raw"                 "scoped_bindings"        
    ## [191] "return_from"             "fn_fmls_names"          
    ## [193] "lgl"                     "node_poke_cddr"         
    ## [195] "env_bind_exprs"          "is_bare_bytes"          
    ## [197] "env_binding_lock"        "with_bindings"          
    ## [199] "warning_cnd"             "is_reference"           
    ## [201] "is_primitive_lazy"       "env_parent"             
    ## [203] "mut_node_car"            "squash_cpl"             
    ## [205] "node_caar"               "is_definition"          
    ## [207] "env_print"               "ctxt_frame"             
    ## [209] "rep_named"               "new_logical_along"      
    ## [211] "is_spliced_bare"         "env_binding_are_active" 
    ## [213] "new_box"                 "mut_node_cdr"           
    ## [215] "fn_env"                  "env_depth"              
    ## [217] "catch_cnd"               "flatten_cpl"            
    ## [219] "vec_poke_range"          "node_poke_caar"         
    ## [221] "dbl_along"               "is_primitive_eager"     
    ## [223] "cnd_signal"              "env_inherits"           
    ## [225] "switch_lang"             "new_node"               
    ## [227] "is_copyable"             "eval_tidy_"             
    ## [229] "has_length"              "expr_print"             
    ## [231] "new_character"           "node_poke_cadr"         
    ## [233] "fn_body<-"               "is_attached"            
    ## [235] "call_frame"              "env_unlock"             
    ## [237] "list_len"                "node_cdar"              
    ## [239] "call_args_names"         "is_bare_string"         
    ## [241] "env_poke_parent"         "fn_fmls_names<-"        
    ## [243] "new_language"            "as_dictionary"          
    ## [245] "overscope_eval_next"     "chr_unserialise_unicode"
    ## [247] "is_bytes"                "is_bare_env"            
    ## [249] "vec_poke_n"              "duplicate"              
    ## [251] "inherits_only"           "caller_fn"              
    ## [253] "ns_env_name"             "na_lgl"                 
    ## [255] "node_cddr"               "mut_mbcs_locale"        
    ## [257] "lang_fn"                 "env_bind"               
    ## [259] "lang_type_of"            "is_bare_environment"    
    ## [261] "raw_along"               "rst_list"               
    ## [263] "global_frame"            "as_bytes"               
    ## [265] "env_tail"                "bytes_along"            
    ## [267] "dots_definitions"        "calling"                
    ## [269] "call_stack"              "!!!"                    
    ## [271] "quo_set_env"             "mut_utf8_locale"        
    ## [273] "is_condition"            "%||%"                   
    ## [275] "exprs_auto_name"         "raw_len"                
    ## [277] "is_expr"
