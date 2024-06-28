# ---
# title:  fish shell config
# author: emil lenz
# email:  emillenz@protonmail.com
# date:   2024-05-04
# info:
# - favor '--long-flags' over '-f' in order to make the code more readeable and easier to maintain
# - tipp :: for prototyping commands, move from the terminal to a emacs buffer (with shebang) then use that buffer to prototype the command until the output is satisfactory (using eval-buffer/expressinon)
# ---

# OPTIONS
set -g fish_cursor_replace_one underscore
set -g fish_cursor_insert line
set -g fish_key_bindings fish_vi_key_bindings
set -g fish_greeting ''
fish_config theme choose modus_vivendi
function fish_mode_prompt # HACK :: disable (indicate mode by cursor state)
end

# PATH
set -gx PATH $PATH ~/.config/{bin, emacs/bin} ~/.cargo/bin

# ENV
set -gx EDITOR emacsclient
set -gx VISUAL emacsclient -nw
set -gx BROWSER firefox
set -gx PAGER bat
set -gx MANPAGER bat
set -gx MANWIDTH 100
set -gx FZF_DEFAULT_OPTS --reverse --height 16 --color light --scheme path

# ALIASES :: better defaults
alias e editor
alias cat bat
alias rm "rm --recursive --verbose"
alias du "du --human-readable"
alias mv "mv --verbose"
alias cp "cp --recursive --verbose"
alias yay "yay --noconfirm"
alias irb "irb --readline"
alias echo "echo -e"
alias curl "curl --silent"
alias sed "sed --regexp-extended"

# KEYBINDINGS
fzf_configure_bindings --directory=\cf --history --git_log --git_status --variables --processes # NOTE :: disable useless (history already inbuilt in fish: /)
bind -M normal K __fish_man_page
bind -M insert \t accept-autosuggestion
bind -M default \t accept-autosuggestion
bind -M insert \cn complete
bind -M insert \cp up-or-search
bind -M default \cp up-or-search
bind -M default \ce edit_command_buffer # NOTE :: uses $VISUAL
bind -M insert \ce edit_command_buffer
bind -M default V __fish_preview_current_file

# FUNCTIONS
function editor --description "open editor with arguements or current dir"
    if test -z "$argv"
        $VISUAL -nw (pwd)
    else
        $VISUAL -nw $argv
    end
end
