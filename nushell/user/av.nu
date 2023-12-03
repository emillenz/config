# -----
# title:  Archive
# author: Emil Lenz
# email:  emillenz@protonmail.com
# date:   Tuesday, 19 September, 2023
# info:   Shortcut to archive files, use this instead of deleting them when you
#         created this content / might still use it in the future.
# -----
export def --env main [file: string] {
  let dest = ("~/Archive" | path join ($file | path expand | path relative-to ~) | path expand)
  if not ($dest | path dirname | path exists) {
    mkdir ($dest | path dirname)
  }
  mv ($file | path expand) $dest
  print $"Moved: ($file) -> ($dest)"

}
