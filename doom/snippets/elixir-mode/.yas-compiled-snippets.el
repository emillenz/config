;;; Compiled snippets and support files for `elixir-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'elixir-mode
                     '(("unless" "unless ${1:condition} do\n  $0\nend" "unless" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/unless" nil nil)
                       ("test" "test \"$1\" do\n  $0\nend" "test" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/test" nil nil)
                       ("rcv" "receive do\n  $0\nend" "receive" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/receive" nil nil)
                       ("pry" "require IEx; IEx.pry" "pry" nil
                        ("debug")
                        nil "/home/lenz/.config/doom/snippets/elixir-mode/pry" nil nil)
                       ("mdoc" "@moduledoc \"\"\"\n$0\n\"\"\"" "moduledoc" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/mdoc" nil nil)
                       ("iop" "IO.puts(\"$1 #{inspect $1}\")$0" "iop" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/iop" nil nil)
                       ("io" "IO.puts(\"$1\")$0" "io" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/io" nil nil)
                       ("ife" "if ${1:condition} do\n  $2\nelse\n  $3\nend" "if-else" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/ife" nil nil)
                       ("if" "if ${1:condition} do\n  $0\nend" "if" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/if" nil nil)
                       ("hinfo" "def handle_info($1, ${2:state}) do\n  $0\nend" "hinfo" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/hinfo" nil nil)
                       ("hcast" "def handle_cast($1, ${2:state}) do\n  $0\nend" "hcast" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/hcast" nil nil)
                       ("hcall" "def handle_call($1, _from, ${2:state}) do\n  $0\nend" "hcall" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/hcall" nil nil)
                       ("df" "def $1($2)${3:$$(when (and yas-moving-away-p yas-modified-p) (concat \" when \" yas-text))}, do: $0" "function-one-line" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/function-one-line" nil nil)
                       ("dfun" "def $1($2)${3:$$(when (and yas-moving-away-p yas-modified-p) (concat \" when \" yas-text))} do\n    $0\nend" "function" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/function" nil nil)
                       ("for" "for ${2:x} <- ${1:enum} do\n  $2$0\nend" "for" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/for" nil nil)
                       ("fn" "fn ${1:x} -> $1$0 end" "fn" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/fn" nil nil)
                       ("doc" "@doc \"\"\"\n$0\n\"\"\"" "doc" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/doc" nil nil)
                       ("do" "do\n  $0\nend" "do" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/do" nil nil)
                       ("defp" "defp $1 do\n  $0\nend" "defp" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/defp" nil nil)
                       ("dm" "defmodule ${1:`(concat (capitalize (file-name-nondirectory (directory-file-name (file-name-directory buffer-file-name)))) \".\")`}${2:`(mapconcat 'capitalize (split-string (file-name-base) \"_\") \"\")`} do\n  $0\nend" "defmodule XXX end" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/defmodule_filename" nil nil)
                       ("defmodule" "defmodule $1 do\n  $0\nend" "defmodule" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/defmodule" nil nil)
                       ("defmacrop" "defmacrop $1 do\n  $0\nend" "defmacrop" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/defmacrop" nil nil)
                       ("defmacro" "defmacro $1 do\n  $0\nend" "defmacro" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/defmacro" nil nil)
                       ("def" "def ${1:function}${2:(${3:args})} do\n  $0\nend" "def" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/def" nil nil)
                       ("cond" "cond do\n  $0\nend" "cond" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/cond" nil nil)
                       ("cast" "GenServer.cast(${1:__MODULE__}, $0)" "cast" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/cast" nil nil)
                       ("case" "case $1 do\n  $0\nend" "case" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/case" nil nil)
                       ("call" "GenServer.call(${1:__MODULE__}, $0)" "call" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/call" nil nil)
                       ("after" "after ${1:500} ->\n  $0" "after" nil nil nil "/home/lenz/.config/doom/snippets/elixir-mode/after" nil nil)))


;;; Do not edit! File generated at Thu Apr 25 09:20:47 2024
