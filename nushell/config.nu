# -----
# title:	Nushell Config
# author: Emil Lenz
# email:	emillenz@protonmail.com
# date:	 Wednesday, 23 April, 2023
# info:	 Nushell conifg with safer defaults, and efficient custom keybindings.
# -----

use md.nu
use av.nu
use extract.nu
use solarized_light.nu
use solarized_dark.nu

alias exe = chmod +x
alias ip = ip -color=auto
alias yay = yay --noconfirm

alias rm = rm -rvft
alias cp = cp -rvp
alias mv = mv -vf

alias bat = bat --theme "Solarized (dark)"
alias cat = bat
alias fzf = fzf --reverse --height=30 --color=dark --scheme=path
alias gg = lazygit

$env.PATH = (
  $env.PATH |
  append [
    "~/.config/bin",
    "~/.cargo/bin",
    "~/go/bin",
    "~/.config/carapace/bin",
    "~/.config/emacs/bin",
  ] |
  uniq
)

alias e = emacsclient --tty
alias g = emacsclient --tty --eval "(magit-status)"
alias x = emacsclient --tty --eval "(dired-jump)"
$env.EDITOR = "emacsclient --tty --no-wait"
$env.VISUAL = "emacsclient --reuse-frame --no-wait"
$env.BROWSER = "firefox"
$env.MANPAGER = "bat --theme 'Solarized (dark)' --language man"
$env.PAGER = "bat --theme 'Solarized (dark)'"

let carapace_completer = {|spans|
  carapace $spans.0 nushell $spans | from json
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
      truncating_suffix: "..."
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
      completer: $carapace_completer
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

  color_config: (solarized_dark)
  use_grid_icons: false
  footer_mode: "25" # always, never, number_of_rows, auto
  float_precision: 2
  use_ansi_coloring: true
  edit_mode: vi
  shell_integration: true
  render_right_prompt_on_last_line: false
  bracketed_paste: true

  hooks: {
    pre_prompt: [ {|| null} ] # replace with source code to run before the prompt is shown
    pre_execution: [ {|| null} ]
    env_change: {
      PWD: [ {|before, after| null} ] # replace with source code to run if the PWD environment is different since the last repl input
    }
    # viewing in vertical orinentation with transpose
    display_output: {|| if (term size).columns >= 100 {table -e} else {table -e}}
    command_not_found: {|| null} # replace with source code to return an error message when a command is not found
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
    name: history_menu
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
    marker: "> "
    type: {
      layout: description
      columns: 4
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
    mode: [emacs vi_normal vi_insert]
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
    mode: [emacs vi_normal vi_insert]
    event: {send: menuprevious}
    }

    {
    name: history_menu
    modifier: alt
    keycode: char_r
    mode: [emacs vi_normal vi_insert]
    event: {send: menu name: history_menu}
    }

    {
    name: next_page
    modifier: control
    keycode: char_u
    mode: [emacs vi_normal vi_insert]
    event: {send: menupagenext}
    }

    {
    name: previous_page
    modifier: control
    keycode: char_d
    mode: [emacs vi_normal vi_insert]
    event: {send: menupageprevious}
    }

    {
    name: insert_file
    modifier: alt
    keycode: char_f
    mode: [emacs, vi_normal, vi_insert]
    event: [
      {edit: InsertString, value: "(fd -tf | fzf --preview='bat --theme Solarized (dark) {}' | str trim)"},
      {send: enter}
    ]
    }

    {
    name: change_dir
    modifier: alt_shift
    keycode: char_f
    mode: [emacs, vi_normal, vi_insert]
    event: [
    {send: executehostcommand, cmd: "cd (fd -td --hidden | fzf --preview='ls {}' | str trim)"}
    ]
    }

    {
    name: quick_help
    modifier: alt
    keycode: char_h
    mode: [emacs, vi_normal, vi_insert]
    event: [
      {edit: MoveToLineEnd}
      {edit: InsertString, value: " --help | bat --language man"}
      {send: Enter}
    ]
    }

    {
    name: long_help
    modifier: alt_shift
    keycode: char_h
    mode: [emacs, vi_normal, vi_insert]
    event: [
      {edit: MoveToLineStart}
      {edit: InsertString, value: "man "}
      {send: Enter}
    ]
    }

    {
    name: prev_dir
    modifier: alt
    keycode: char_p
    mode: [emacs, vi_normal, vi_insert]
    event: {send: executehostcommand, cmd: "cd .."}
    }

    {
    name: home_dir
    modifier: alt_shift
    keycode: char_p
    mode: [emacs, vi_normal, vi_insert]
    event: {send: executehostcommand, cmd: "cd ~"}
    }

    {
    name: open_editor
    modifier: alt_shift
    keycode: char_e
    mode: [emacs vi_normal vi_insert]
    event: [
      {send: OpenEditor}
      {send: Enter}
    ]
    }

    {
    name: listcontents
    modifier: alt
    keycode: char_l
    mode: [emacs, vi_normal, vi_insert]
    event: {send: executehostcommand, cmd: " ls"}
    }

  ]
}
