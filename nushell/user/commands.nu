# ---
# title:  nushell custom commands and aliases
# author: emil lenz
# email:  emillenz@protonmail.com
# date:   2024-03-05
# ---

alias ip = ip -color=auto
alias yay = yay --noconfirm
alias rm = rm --recursive --verbose --trash --interactive-once
alias fzf = fzf --reverse --height=15 --color=dark --scheme=path # os-consistent completion (rofi, emacs, fzf ..)

alias e = emacsclient -nw
alias g = emacsclient -nw --eval "(magit-status)"
alias d = emacsclient -nw --eval "(dired-jump)"

# mv :: automatically create missing destination dir's.
export def mv [from: path, to: path] {
  if not ($to | path exists) {
    mkdir --verbose ($to | path dirname)
  }
  ^mv --verbose $from $to
}

# cp :: automatically create missing destination dir's.
export def cp [from: path, to: path] {
  if not ($to | path exists) {
    mkdir --verbose ($to | path dirname)
  }
  ^cp --verbose --progress --interactive $from $to
}
