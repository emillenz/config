# -----
# title:  nushell config
# author: emil lenz
# email:  emillenz@protonmail.com
# date:	  wednesday, 23 april, 2023
# info:	  nushell conifg with safer defaults, and efficient custom keybindings.
# -----

# NOTE: when programming in nushell non-interactively, ALWAYS use '--long-flags' in order to make the code more readeable and easier to maintain in the future.

# theme ::
source modus_theme.nu
source commands.nu
use utils.nu *

$env.PATH = ($env.PATH | append ["~/.config/bin", "~/.cargo/bin", "~/.config/emacs/bin"] | uniq)
$env.EDITOR = "emacsclient" # HACK :: cannot use --tty flag with nushell
$env.VISUAL = "emacsclient --reuse-frame"
$env.BROWSER = "firefox"
$env.MANPAGER = "bat"
$env.PAGER = "bat "

let fish_completer = {|spans|
  fish --command $'complete "--do-complete=($spans | str join " ")"'
  | $"value(char tab)description(char newline)" + $in
  | from tsv --flexible --no-infer
}
$env.config = {
  show_banner: false
  ls: {
    use_ls_colors: true
    clickable_links: true
  }
  rm: {always_trash: true}
  table: {
    mode: rounded
    index_mode: always
    show_empty: false
    trim: {
      methodology: wrapping
      wrapping_try_keep_words: true
      truncating_suffix: "…"
    }
  }

  explore: {
    help_banner: true
    exit_esc: true
    command_bar_text: '#C4C9C6'
    # command_bar: {fg: '#C4C9C6' bg: '#223311' }
    status_bar_background: {fg: '#1D1F21', bg: '#C4C9C6' }
    # status_bar_text: {fg: '#C4C9C6' bg: '#223311' }
    highlight: {bg: 'yellow', fg: 'black' }
    status: {
      # warn: {bg: 'yellow', fg: 'blue'}
      # error: {bg: 'yellow', fg: 'blue'}
      # info: {bg: 'yellow', fg: 'blue'}
    }

    try: {
      # border_color: 'red'
      # highlighted_color: 'blue'
      # reactive: false
    }

    table: {
      split_line: '#404040'
      cursor: true
      line_index: true
      line_shift: true
      line_head_top: true
      line_head_bottom: true
      show_head: true
      show_index : true
      # selected_cell: {fg: 'white', bg: '#777777'}
      # selected_row: {fg: 'yellow', bg: '#C1C2A3'}
      # selected_column: blue
      # padding_column_right: 2
      # padding_column_left: 2
      # padding_index_left: 2
      # padding_index_right: 1
    }

    config: {
      # cursor_color: {bg: 'yellow', fg: 'black' }
      # border_color: white
      # list_color: green
    }
  }

  history: {
    max_size: 10000
    sync_on_enter: true
    file_format: "plaintext"
  }

  completions: {
    case_sensitive: false
    quick: true
    partial: true
    algorithm: "fuzzy"
    external: {
      enable: true
      max_results: 30
      completer: $fish_completer
    }
  }

  filesize: {
    metric: true
    format: "auto"
  }

  cursor_shape: {
    emacs: block
    vi_insert: line
    vi_normal: block
  }

  color_config: $modus_theme
  use_grid_icons: false
  footer_mode: "25"
  float_precision: 2
  use_ansi_coloring: true
  edit_mode: vi
  shell_integration: true
  render_right_prompt_on_last_line: false
  bracketed_paste: true

  hooks: {
    pre_prompt: [ {|| null} ]
    pre_execution: [ {|| null} ]
    env_change: {
      PWD: [ {|before, after| ls | get name } ]
    }
    display_output: {|| if (term size).columns >= 100 {table -e} else {table -e}}
    command_not_found: {||}
  }

  menus: [
    {
      name: completion_menu
      only_buffer_difference: false
      marker: "> "
      type: {
        layout: columnar
        columns: 1
        col_width: 20
        col_padding: 2
      }
      style: {
        text: blue
        selected_text: blue_reverse
        description_text: blue
      }
    }

    {
      name: recent_cmds_menu
      only_buffer_difference: true
      marker: "> "
      type: {layout: list, page_size: 100}
      style: {
        text: blue
        selected_text: blue_reverse
        description_text: yellow
      }
    }

    {
      name: help_menu
      only_buffer_difference: true
      marker: "? "
      type: {
        layout: description
        columns: 1
        col_width: 20
        col_padding: 2
        selection_rows: 4
        description_rows: 10
      }
      style: {
        text: blue
        selected_text: blue_reverse
        description_text: yellow
      }
    }
  ]

  keybindings: [
    {
      name: completion_menu
      modifier: none
      keycode: tab
      mode: [vi_normal vi_insert]
      event: {
        until: [
          {send: menu name: completion_menu}
          {send: menunext}
        ]
      }
    }

    {
      name: completion_previous
      modifier: shift
      keycode: backtab
      mode: [vi_normal vi_insert]
      event: {send: menuprevious}
    }

    {
      name: complete_hint
      modifier: control
      keycode: char_a
      mode: [vi_normal vi_insert]
      event: {send: HistoryHintComplete}
    }

    # {
    #   name: help_menu
    #   modifier: control
    #   keycode: char_h
    #   mode: [vi_normal vi_insert]
    #   event: {send: menu name: help_menu}
    # }

    {
      name: recent_cmds_menu
      modifier: control
      keycode: char_r
      mode: [vi_normal vi_insert]
      event: {send: menu name: recent_cmds_menu}
    }

    {
      name: insert_file_root
      modifier: shift_control
      keycode: char_f
      mode: [emacs, vi_normal, vi_insert]
      event: [
        {send: executehostcommand, cmd: "tmux send-keys $\"(fd --type=file . ~ | fzf --preview='bat {}')\""},
        {send: Enter}
      ]
    }

    {
      name: help
      modifier: control
      keycode: char_h
      mode: [vi_normal vi_insert]
      event: [
        { edit: movetolineend }
        { edit: insertstring, value: " --help | bat -lhelp" } # note :: using shortflag because shows up in history => less clutter
        { send: enter }
      ]
    }

    {
      name: womanpage
      modifier: control
      keycode: char_w
      mode: [vi_normal vi_insert]
      event: [
        { edit: movetolinestart }
        { edit: insertstring, value: "man " }
        { send: enter }
      ]
    }

    {
      name: insert_dir
      modifier: control
      keycode: char_g
      mode: [emacs, vi_normal, vi_insert]
      event: {
        send: executehostcommand,
        cmd: "tmux send-keys $\"(fd --type=directory | fzf --preview='^ls --color {}')\"" # NOTE :: terrible hack, but atm there is no other way to eval an expression at runtim and then insert the result
      }
    }

    {
      name: insert_dir_root
      modifier: shift_control
      keycode: char_g
      mode: [emacs, vi_normal, vi_insert]
      event: {
        send: executehostcommand,
        cmd: "tmux send-keys $\"(fd --type=directory . ~ | fzf --preview='^ls --color {}')\"" # NOTE :: terrible hack, but atm there is no other way to eval an expression at runtim and then insert the result
      }
    }

    {
      name: open_editor
      modifier: control
      keycode: char_e
      mode: [vi_normal vi_insert]
      event: [
        {send: openeditor}
        {send: Enter}
      ]
    }

    {
      name: redo_change
      modifier: shift
      keycode: char_u
      mode: vi_normal
      event: {edit: redo}
    }
  ]
}
