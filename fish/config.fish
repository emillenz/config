# ---
# title:  fish shell config
# author: emil lenz
# email:  emillenz@protonmail.com
# date:   2024-05-04
# info:
# - favor '--long-flags' over '-f' in order to make the code more readeable and easier to maintain
# ---


# OPTIONS
fish_config theme choose modus_vivendi
set -g fish_cursor_replace_one underscore
set -g fish_cursor_insert line
set -g fish_greeting ''
function fish_mode_prompt # HACK :: disable mode indicator
end

# PATH
set -gx PATH $PATH ~/.config/{bin, emacs/bin} ~/.cargo/bin

# ENV
set -gx EDITOR emacsclient -nw
set -gx VISUAL emacsclient
set -gx BROWSER firefox
set -gx PAGER bat
set -gx MANPAGER bat
set -gx MANWIDTH 100
set -gx FZF_DEFAULT_OPTS --reverse --height 16 --color light --scheme path

# ALIASES :: better defaults
alias e "emacsclient -nw"
alias cat bat
alias rm "rm --recursive --verbose"
alias du "du --human-readeable"
alias mv "mv --verbose"
alias cp "cp --recursive --verbose"
alias yay "yay --noconfirm"
alias irb "irb --readline"
alias echo "echo -e"

# KEYBINDINGS
set -g fish_key_bindings fish_vi_key_bindings
fzf_configure_bindings --directory=\cf --history --git_log --git_status --variables --processes # NOTE :: disable useless (history already inbuilt in fish: /)
bind -M normal U redo
bind -M normal K __fish_man_page
bind -M insert \t accept-autosuggestion
bind -M default \t accept-autosuggestion
bind -M insert \cn complete
bind -M insert \cp up-or-search
bind -M default \cp up-or-search
bind -M default \ce edit_command_buffer
bind -M insert \ce edit_command_buffer
bind -M default V __fish_preview_current_file
