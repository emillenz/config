# -----
# title:  Solarized Light Colorscheme
# author: Emil Lenz
# email:  emillenz@protonmail.com
# date:   2023-12-13
# -----

export def solarized_light [] {
  return {
    separator: "#556b72"
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: "#859900" attr: "b" }
    empty: "#268bd2"
    bool: {|| if $in { "#2aa198" } else { "light_gray" } }
    int: "#556b72"
    filesize: {|e|
      if $e == 0b {
        "#556b72"
      } else if $e < 1mb {
        "#2aa198"
      } else {{ fg: "#268bd2" }}
    }
    duration: "#556b72"
    date: {|| (date now) - $in |
      if $in < 1hr {
        { fg: "#dc322f" attr: "b" }
      } else if $in < 6hr {
        "#dc322f"
      } else if $in < 1day {
        "#b58900"
      } else if $in < 3day {
        "#859900"
      } else if $in < 1wk {
        { fg: "#859900" attr: "b" }
      } else if $in < 6wk {
        "#2aa198"
      } else if $in < 52wk {
        "#268bd2"
      } else { "dark_gray" }
    }

    range:    "#556b72"
    float:    "#556b72"
    string:   "#556b72"
    nothing:  "#556b72"
    binary:   "#556b72"
    cellpath: "#556b72"
    record:   "#556b72"
    list:     "#556b72"
    block:    "#556b72"
    hints:    "dark_gray"
    row_index:     { fg: "#859900" attr: "b" }
    search_result: { fg: "#dc322f" bg: "#556b72" }

    background: "#F1E9D2"
    foreground: "#556b72"
    cursor:     "#268bd2"

    shape_bool:          "#2aa198"
    shape_custom:        "#859900"
    shape_directory:     "#2aa198"
    shape_external:      "#2aa198"
    shape_filepath:      "#2aa198"
    shape_match_pattern: "#859900"
    shape_nothing:       "#2aa198"
    shape_operator:      "#b58900"
    shape_literal:       "#268bd2"
    shape_string:        "#859900"
    shape_variable:      "#6c71c4"
    shape_matching_brackets:    { attr: "u" }
    shape_flag:                 { fg: "#268bd2" attr: "b" }
    shape_float:                { fg: "#6c71c4" attr: "b" }
    shape_globpattern:          { fg: "#2aa198" attr: "b" }
    shape_int:                  { fg: "#6c71c4" attr: "b" }
    shape_internalcall:         { fg: "#2aa198" attr: "b" }
    shape_list:                 { fg: "#2aa198" attr: "b" }
    shape_or:                   { fg: "#6c71c4" attr: "b" }
    shape_pipe:                 { fg: "#6c71c4" attr: "b" }
    shape_range:                { fg: "#b58900" attr: "b" }
    shape_record:               { fg: "#2aa198" attr: "b" }
    shape_redirection:          { fg: "#6c71c4" attr: "b" }
    shape_signature:            { fg: "#859900" attr: "b" }
    shape_string_interpolation: { fg: "#2aa198" attr: "b" }
    shape_table:                { fg: "#268bd2" attr: "b" }
    shape_datetime:             { fg: "#2aa198" attr: "b" }
    shape_externalarg:          { fg: "#859900" attr: "b" }
    shape_and:                  { fg: "#6c71c4" attr: "b" }
    shape_binary:               { fg: "#6c71c4" attr: "b" }
    shape_block:                { fg: "#268bd2" attr: "b" }
    shape_garbage:              { fg: "#FFFFFF" bg: "#FF0000" attr: "b" }
  }
}
