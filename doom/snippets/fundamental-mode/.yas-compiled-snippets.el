;;; Compiled snippets and support files for `fundamental-mode'
;;; contents of the .yas-setup.el support file:
;;;
;; -*- no-byte-compile: t; -*-
(require 'doom-snippets-lib);;; Snippet definitions:
;;;
(yas-define-snippets 'fundamental-mode
                     '(("time" "`(current-time-string)`" "(current time)" nil nil nil "/home/lenz/.config/doom/snippets/fundamental-mode/time" nil "time")
                       ("mode" "`comment-start`-*- mode: ${1:mode} -*-`comment-end`" "mode"
                        (=
                         (line-number-at-pos)
                         1)
                        nil nil "/home/lenz/.config/doom/snippets/fundamental-mode/mode" nil "mode")
                       ("elvar" "`comment-start`-*- ${1:var}: ${2:value} -*-`comment-end`" "var" nil nil nil "/home/lenz/.config/doom/snippets/fundamental-mode/localvar" nil "elvar")
                       ("header" "${1:`(or comment-start \"?\")`} ---\n$1 title:  ${2:`(replace-regexp-in-string \"[-_.]\" \" \" (file-name-base (or buffer-file-name \"title\")))`}\n$1 author: `user-full-name`\n$1 email:  `user-mail-address`\n$1 date:   `(format-time-string \"%F\")`\n$1 info:   ${3:short description of file/document}\n$1 ---\n$0\n" "header" nil nil nil "/home/lenz/.config/doom/snippets/fundamental-mode/header" nil "header")
                       ("email" "`user-mail-address`\n" "(user's email)" nil nil nil "/home/lenz/.config/doom/snippets/fundamental-mode/email" nil "email")
                       ("#!" "#!/usr/bin/env ${1:bash}\n\n$0\n" "bang"
                        (bolp)
                        nil nil "/home/lenz/.config/doom/snippets/fundamental-mode/bang" nil "#!")))


;;; Do not edit! File generated at Thu Feb 22 15:51:43 2024
