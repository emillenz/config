# -----
# title:  Modus Colortheme for Nushell
# author: Emil Lenz
# email:  emillenz@protonmail.com
# date:   2024-01-26
# -----

const modus_theme = {
        background: "#000000"
        foreground: "#ffffff"
        cursor:     "#ffffff"

        # OUTPUT
        separator:                  "#ffffff"
        header:                     {fg: "#00bcff" attr: "b"}
        row_index:                  {fg: "#00bcff" attr: "b"}

        search_result:              {fg: "#2f447f" bg: "#ffffff"}

        # NOTE :: differentiate numbers from types; string -> white default
        int:                        "#f78fe7"
        float:                      "#f78fe7"

        empty:                      "#6ae4b9"
        bool:                       "#6ae4b9"
        filesize:                   "#6ae4b9"
        duration:                   "#6ae4b9"
        nothing:                    "#6ae4b9"
        cellpath:                   "#6ae4b9"
        date:                       "#6ae4b9"
        range:                      "#6ae4b9"

        string:                     "#ffffff"
        binary:                     "#ffffff"
        record:                     "#ffffff"
        list:                       "#ffffff"
        block:                      "#ffffff"

        # SYNTAX
        hints:                      "#989898"
        shape_garbage:              {fg: "#ffffff" bg: "#ff5f59"}
        shape_external:             {fg: "#feacd0" attr: "b"}
        shape_internalcall:         {fg: "#feacd0" attr: "b"}
        shape_custom:               {fg: "#feacd0" attr: "b"}
        shape_variable:             "#00d3d0"

        shape_externalarg:          "#b6a0ff"
        shape_flag:                 "#b6a0ff"

        shape_directory:            "#6ae4b9"
        shape_filepath:             "#6ae4b9"
        shape_datetime:             "#6ae4b9"
        shape_binary:               "#6ae4b9"
        shape_nothing:              "#6ae4b9"
        shape_bool:                 "#6ae4b9"
        shape_float:                "#f78fe7"
        shape_int:                  "#f78fe7"
        shape_literal:              "#79a8ff"
        shape_string:               "#79a8ff"
        shape_string_interpolation: "#79a8ff"
        shape_signature:            "#79a8ff"

        shape_block:                "#2fafff"
        shape_matching_brackets:    "#2fafff"
        shape_list:                 "#2fafff"
        shape_range:                "#2fafff"
        shape_record:               "#2fafff"
        shape_table:                "#2fafff"

        shape_operator:             "#b6a0ff"
        shape_globpattern:          "#b6a0ff"
        shape_match_pattern:        "#b6a0ff"
        shape_or:                   "#b6a0ff"
        shape_pipe:                 "#b6a0ff"
        shape_and:                  "#b6a0ff"
        shape_redirection:          "#b6a0ff"
}
