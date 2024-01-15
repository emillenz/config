# -----
# title:	Nushell Config
# author: Emil Lenz
# email:	emillenz@protonmail.com
# date:	  Wednesday, 23 April, 2023
# info:	  Nushell conifg with safer defaults, and efficient custom keybindings.
# -----

# NOTE: When programming in nushell non-interactively, use the full command-names and long style options in order to make the code scaleable and readeable.

source solarized-light.nu

alias exe = chmod +x
alias ip = ip -color=auto
alias yay = yay --noconfirm

alias rm = rm --recursive --verbose --force --trash
alias cp = cp --recursive --verbose --progress
alias mv = mv --verbose --force

alias bat = bat --theme='Solarized (light)'
alias fzf = fzf --reverse --height=30 --color=light --scheme=path

alias e = emacsclient --tty
alias g = emacsclient --tty --eval "(magit-status)"
alias d = emacsclient --tty --eval "(dired-jump)"

$env.PATH = ($env.PATH | append ["~/.config/bin", "~/.cargo/bin", "~/.config/emacs/bin"] | uniq)
$env.EDITOR = "emacsclient --tty --alternate-editor=nvim"
$env.VISUAL = "emacsclient --reuse-frame --alternate-editor=nvim"
$env.BROWSER = "firefox"
$env.MANPAGER = "bat --plain --language=man --theme='Solarized (light)'"
$env.PAGER = "bat --theme='Solarized (light)'"

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

  color_config: (solarized_light)
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
      PWD: [ {|before, after| ls | get name } ] # replace with source code to run if the PWD environment is different since the last repl input
    }
    # viewing in vertical orinentation with transpose
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
    }}

    {
    name: history_menu
    only_buffer_difference: true
    marker: "> "
    type: {layout: list, page_size: 100}
    style: {
      text: blue
      selected_text: blue_reverse
      description_text: yellow
    }}

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
    }}
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
    }}

    {
    name: completion_previous
    modifier: shift
    keycode: backtab
    mode: [emacs vi_normal vi_insert]
    event: {send: menuprevious}
    }

    {
    name: help_menu
    modifier: control
    keycode: char_h
    mode: [emacs vi_normal vi_insert]
    event: {send: menu name: help_menu}
    }

    {
    name: history_menu
    modifier: control
    keycode: char_r
    mode: [emacs vi_normal vi_insert]
    event: {send: menu name: history_menu}
    }

    {
    name: insert_file
    modifier: control
    keycode: char_f
    mode: [emacs, vi_normal, vi_insert]
    event: [
      {edit: InsertString, value: "(fd --type=file | fzf --preview='bat --force-colorization {}' | str trim)"},
      {send: enter}
    ]
    }

    {
    name: help
    modifier: shift
    keycode: char_h
    mode: vi_normal
    event: [
      {edit: MoveToLineEnd}
      {edit: InsertString, value: " --help | bat --language=man"}
      {send: Enter}
    ]
    }

    {
    name: documentation
    modifier: shift
    keycode: char_k
    mode: vi_normal
    event: [
      {edit: MoveToLineStart}
      {edit: InsertString, value: " man "}
      {send: Enter}
    ]
    }

    {
    name: home_dir
    modifier: control_shift
    keycode: char_p
    mode: [emacs, vi_normal, vi_insert]
    event: {send: executehostcommand, cmd: "cd ~"}
    }

    {
    name: prev_dir
    modifier: control
    keycode: char_p
    mode: [emacs, vi_normal, vi_insert]
    event: {send: executehostcommand, cmd: "cd .."}
    }

    {
    name: goto_dir
    modifier: control
    keycode: char_g
    mode: [emacs, vi_normal, vi_insert]
    event: {send: executehostcommand, cmd: "cd (fd --type=directory | fzf --preview='^ls --color=always {}' | str trim)"}
    }

    {
    name: open_editor
    modifier: control
    keycode: char_e
    mode: [emacs vi_normal vi_insert]
    event: [
      {send: openeditor}
      {send: Enter}
    ]
    }

    {
    name: listcontents
    modifier: control
    keycode: char_v
    mode: [emacs, vi_normal, vi_insert]
    event: {send: executehostcommand, cmd: " ls"}
    }

    {
      name: redo_change
      modifier: shift
      keycode: char_u
      mode: vi_normal
      event: {edit: redo}
    }

    {
      name: clear
      modifier: none
      keycode: char_z
      mode: vi_normal
      event: [
        {send: clearscreen}
      ]
    }

  ]
}
