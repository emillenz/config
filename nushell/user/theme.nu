# -----
# title:  Nushell themes commands
# author: Emil Lenz
# email:  emillenz@protonmail.com
# date:   Wednesday, 13 December, 2023
# info:   Carefully selected themes.
# -----

export def solarized_dark []  {
  return {
    separator: "#93a1a1"
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: "#859900" attr: "b" }
    empty: "#268bd2"
    bool: {|| if $in { "#2aa198" } else { "light_gray" } }
    int: "#93a1a1"
    filesize: {|e|
      if $e == 0b {
        "#93a1a1"
      } else if $e < 1mb {
        "#2aa198"
      } else {{ fg: "#268bd2" }}
    }
    duration: "#93a1a1"
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
      } else { "#93a1a1" }
    }

    range:    "#93a1a1"
    float:    "#93a1a1"
    string:   "#93a1a1"
    nothing:  "#93a1a1"
    binary:   "#93a1a1"
    cellpath: "#93a1a1"
    record:   "#93a1a1"
    list:     "#93a1a1"
    block:    "#93a1a1"
    hints:    "#93a1a1"
    row_index:   { fg: "#859900" attr: "b" }
    search_result: { fg: "#dc322f" bg: "#93a1a1" }

    background: "#002b36"
    foreground: "#93a1a1"
    cursor:     "#268bd2"

    shape_bool:          "#2aa198"
    shape_custom:        "#859900"
    shape_directory:     "#2aa198"
    shape_external:      "#2aa198"
    shape_filepath:      "#2aa198"
    shape_literal:       "#268bd2"
    shape_match_pattern: "#859900"
    shape_nothing:       "#2aa198"
    shape_operator:      "#b58900"
    shape_string:        "#859900"
    shape_variable:      "#6c71c4"
    shape_matching_brackets:    { attr: "u" }
    shape_datetime:             { fg: "#2aa198" attr: "b" }
    shape_and:                  { fg: "#6c71c4" attr: "b" }
    shape_binary:               { fg: "#6c71c4" attr: "b" }
    shape_block:                { fg: "#268bd2" attr: "b" }
    shape_externalarg:          { fg: "#859900" attr: "b" }
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
    shape_garbage:              { fg: "#FFFFFF" bg: "#FF0000" attr: "b" }
  }
}

export def solarized_light [] {
  return {
    separator: "#586e75"
    leading_trailing_space_bg: { attr: "n" }
    header: { fg: "#859900" attr: "b" }
    empty: "#268bd2"
    bool: {|| if $in { "#2aa198" } else { "light_gray" } }
    int: "#586e75"
    filesize: {|e|
      if $e == 0b {
        "#586e75"
      } else if $e < 1mb {
        "#2aa198"
      } else {{ fg: "#268bd2" }}
    }
    duration: "#586e75"
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

    range:    "#586e75"
    float:    "#586e75"
    string:   "#586e75"
    nothing:  "#586e75"
    binary:   "#586e75"
    cellpath: "#586e75"
    record:   "#586e75"
    list:     "#586e75"
    block:    "#586e75"
    hints:    "dark_gray"
    row_index:     { fg: "#859900" attr: "b" }
    search_result: { fg: "#dc322f" bg: "#586e75" }

    background: " #F2E6CE"
    foreground: " #586e75"
    cursor:   "   #268bd2"

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
