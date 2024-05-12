# ---
# title:  fish shell config
# author: emil lenz
# email:  emillenz@protonmail.com
# date:   2024-05-04
# ---

# NOTE: in scripts always use '--long-flags' in order to make the code more readeable and easier to
# maintain.

# OPTIONS
set -g fish_cursor_default block
set -g fish_cursor_replace_one underscore
set -g fish_cursor_insert line
set -g fish_cursor_visual block
set -g fish_key_bindings fish_vi_key_bindings
set -g fish_greeting ''
fish_config theme choose modus_vivendi
function fish_mode_prompt # HACK :: no mode indidcator
end

# PATH
set -gx PATH $PATH ~/.config/{bin, emacs/bin} ~/.cargo/bin

# ENV
set -gx EDITOR emacsclient -nw
set -gx VISUAL emacsclient -nw
set -gx BROWSER firefox
set -gx PAGER bat
set -gx MANPAGER bat
set -gx MANWIDTH 100
set -gx FZF_DEFAULT_OPTS --reverse --height 16 --color light --scheme path # os-consistent completion (rofi, emacs, fzf ..)

# aliases for saner defaults / shortcuts
alias e="emacsclient -nw"
alias cat="bat"
alias rm="rm --recursive --verbose --interactive=once"
alias yay="yay --noconfirm"

# KEYBINDINGS
fzf_configure_bindings --history=\cr --directory=\cf --git_log= --git_status= --variables= --processes= # NOTE :: disable unused
bind -M normal U redo
bind -M normal K __fish_man_page
bind -M insert \t accept-autosuggestion
bind -M insert -k nul complete # HACK ::
bind -M insert \ck up-or-search
bind -M default \ee edit_command_buffer
bind -M default \ep __fish_paginate
bind -M default \el __fish_list_current_token
bind -M default \ev __fish_preview_current_file
