# ---
# title:  fish shell config
# author: emil lenz
# email:  emillenz@protonmail.com
# date:   2024-05-04
# info:
# - favor '--long-flags' over '-f', '--flag=value' over '--flag value' in order to make the code more unambiguous, readeable, easier to maintain.
# - tipp :: for prototyping commands, move from the terminal to a emacs buffer (with shebang) then use that buffer to prototype the command until the output is satisfactory (using eval-buffer/expressinon).
# ---

# OPTIONS
set -g fish_cursor_replace_one underscore
set -g fish_cursor_insert line
set -g fish_greeting ''
fish_config theme choose modus_vivendi
function fish_mode_prompt # HACK :: disable (indicate mode by cursor state)
end

# PATH
set -gx PATH $PATH ~/.config/{bin, emacs/bin} ~/.cargo/bin

# PROGRAMS
set -gx EDITOR emacsclient
set -gx VISUAL emacsclient -nw
set -gx BROWSER firefox

# PAGER
alias cat bat
set -gx PAGER bat --paging=always
set -gx MANPAGER bat --paging=always
set -gx MANWIDTH 100

# ALIASES :: better defaults
# - use vim bindings always (enforce readline in REPL's)
# - use extended-regexp
alias rm "rm --recursive --verbose"
alias du "du --human-readable"
alias mv "mv --verbose"
alias cp "cp --recursive --verbose"
alias yay "yay --noconfirm"
alias echo "echo -e"
alias curl "curl --silent"
alias sed "sed --regexp-extended"
alias jshell "rlwrap --always-readline jshell"
alias irb "irb --readline"
# alias grep rg
# alias find fd

# FZF
fzf_configure_bindings --directory=\cf --history --git_log --git_status --variables --processes # NOTE :: disable useless (history already inbuilt in fish: /)
set -gx FZF_DEFAULT_OPTS --reverse --height=16 --color light --scheme path

# VIM
set -g fish_key_bindings fish_vi_key_bindings
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
function editor --description "open editor with args, if nil open in current directory"
    if test -z "$argv"
        $VISUAL -nw (pwd)
    else
        $VISUAL -nw $argv
    end
end
alias e editor
