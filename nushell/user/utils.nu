# ---
# title:  nushell utility commands
# author: emil lenz
# email:  emillenz@protonmail.com
# date:   2024-03-05
# info:
#   -
# ---

# async :: launch async bash command
export def async [cmd: string, --output (-o)] {
  let out = (match $output {
    true => "",
    false => " &>/dev/null",
  })
  $"($cmd)($out) &" | bash
}
