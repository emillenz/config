;;; Compiled snippets and support files for `org-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'org-mode
                     '(("width" "#+attr_html: :width ${1:500px}" "#+attr_html: :width ..." nil nil
                        nil "/home/lenz/.config/doom/snippets/org-mode/width" nil nil)
                       ("verse" "#+begin_verse\n`%`$0\n#+end_verse" "verse" nil nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/verse" nil "verse")
                       ("todo" "TODO ${1:task description}" "TODO item" nil nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/todo" nil "todo")
                       ("trigger-key" "" "" t nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/src-" nil nil)
                       ("src" "#+begin_src $1\n`%`$0\n#+end_src" "#+begin_src" nil nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/src" nil "src")
                       ("quote" "#+begin_quote\n`%`$0\n#+end_quote" "quote block" nil nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/quote" nil "quote")
                       ("name" "#+name: $0\n" "name" nil nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/name" nil "name")
                       ("matrix"
                        "\\left \\(\n\\begin{array}{${1:ccc}}\n${2:v1 & v2} \\\\\n`%`$0\n\\end{array}\n\\right \\)"
                        "matrix" nil nil nil "/home/lenz/.config/doom/snippets/org-mode/matrix" nil
                        "matrix")
                       ("org-literature-template"
                        "#+title:    ${1:`(capitalize (replace-regexp-in-string \"[-_.]\" \" \" (file-name-sans-extension (file-name-nondirectory buffer-file-name))))`}\n#+author:   `user-full-name`\n#+email:    `user-mail-address`\n#+date:     `(format-time-string \"%A %d %B, %Y\")`\n#+info:     Personal collection of notes, thoughts and highlights.\n#+property: title $1\n#+property: author ${2:Author}\n#+property: year ${3:Year of publication}\n#+property: genres ${4:Genres (tags)}\n#+property: type ${5:Type}\n#+property: length ${6:Pages/Minutes}\n\n* Highlights\n$0\n* Literature Notes\n\n* Transient Notes\n\n* Summary\n"
                        "org-literature-template" nil nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/literature-template" nil
                        "org-literature-template")
                       ("jupyter"
                        "#+begin_src jupyter-${1:$$(yas-choose-value '(\"python\" \"julia\" \"R\"))}${2: :session $3}${4: :async yes}\n`%`$0\n#+end_src\n"
                        "#+begin_src jupyter-..." nil nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/jupyter" nil "jupyter")
                       ("srci" "src_${1:language}[${2:header}]{${0:body}}\n" "Inline Source" t nil
                        nil "/home/lenz/.config/doom/snippets/org-mode/inline_source" nil "srci")
                       ("inl" "src_${1:language}${2:[${3::exports code}]}{${4:code}}" "inline code"
                        nil nil nil "/home/lenz/.config/doom/snippets/org-mode/inline" nil "inl")
                       ("img"
                        "#+attr_html: :alt $2 :align ${3:left} :class img\n[[${1:src}]${4:[${5:title}]}]\n`%`$0"
                        "img" nil nil nil "/home/lenz/.config/doom/snippets/org-mode/img" nil "img")
                       ("org-file-header"
                        "#+title:    `(capitalize (replace-regexp-in-string \"[-_.]\" \" \" (file-name-sans-extension (file-name-nondirectory buffer-file-name))))`\n#+author:   `user-full-name`\n#+email:    `user-mail-address`\n#+date:     `(format-time-string \"%A %d %B, %Y\")`\n#+info:     ${1:Short description of document.}\n\n$0\n"
                        "org-file-header" nil nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/header" nil "org-file-header")
                       ("fig"
                        "#+caption: ${1:caption}\n#+attr_latex: ${2:scale=0.75}\n#+name: fig-${3:label}\n"
                        "figure" nil nil nil "/home/lenz/.config/doom/snippets/org-mode/figure" nil
                        "fig")
                       ("export" "#+begin_export ${1:type}\n`%`$0\n#+end_export" "export" nil nil
                        nil "/home/lenz/.config/doom/snippets/org-mode/export" nil "export")
                       ("ex" "#+begin_example\n`%`$0\n#+end_example\n" "example" nil nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/example" nil "ex")
                       ("entry"
                        "#+begin_html\n---\nlayout: ${1:default}\ntitle: ${2:title}\n---\n#+end_html\n`%`$0"
                        "entry" nil nil nil "/home/lenz/.config/doom/snippets/org-mode/entry" nil
                        "entry")
                       ("elisp" "#+begin_src emacs-lisp :tangle yes\n`%`$0\n#+end_src" "elisp" nil
                        nil nil "/home/lenz/.config/doom/snippets/org-mode/elisp" nil "elisp")
                       ("dot"
                        "#+begin_src dot :file ${1:file}.${2:svg} :results file graphics\n`%`$0\n#+end_src"
                        "dot" nil nil nil "/home/lenz/.config/doom/snippets/org-mode/dot" nil "dot")
                       ("org-daily-journal"
                        "#+title:    Daily Journal: `(format-time-string \"%Y-%m-%d\")`\n#+author:   `user-full-name`\n#+email:    `user-mail-address`\n#+date:     `(format-time-string \"%A, %e %B, %Y\")`\n\n* start of day\n** goals\n- $0\n-\n-\n\n** schedule\n*** [ ]\n\n* end of day\n** gratitude\n-\n-\n-\n\n** reflection / review\n-\n-\n-"
                        "org-daily-journal" nil nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/daily-journal-template" nil
                        "org-daily-journal")
                       ("【【" "[[$0]]\n" "chinese【" nil nil
                        ((yas-wrap-around-region (ignore-errors (fcitx--deactivate)))
                         (yas-after-exit-snippet-hook (lambda nil (ignore-errors (fcitx--activate)))))
                        "/home/lenz/.config/doom/snippets/org-mode/chinese_link" nil "chinese_link")
                       ("￥￥" "\\$$1\\$ $0\n" "Chinese$" nil nil
                        ((yas-wrap-around-region (ignore-errors (fcitx--deactivate)))
                         (yas-after-exit-snippet-hook (lambda nil (ignore-errors (fcitx--activate)))))
                        "/home/lenz/.config/doom/snippets/org-mode/chinese_dollar" nil
                        "chinese_dollar")
                       ("blog"
                        "#+startup: showall indent\n#+startup: hidestars\n#+begin_html\n---\nlayout: default\ntitle: ${1:title}\nexcerpt: ${2:excerpt}\n---\n$0"
                        "blog" nil nil nil "/home/lenz/.config/doom/snippets/org-mode/blog" nil
                        "blog")
                       ("<v" (progn (doom-snippets-expand :uuid "verse")) "#+begin_verse block" nil
                        nil nil "/home/lenz/.config/doom/snippets/org-mode/begin_verse" nil nil)
                       ("src"
                        "#+begin_src ${1:`(or (save-excursion\n    (beginning-of-line)\n    (when (re-search-backward \"^[ \\t]*#\\\\+begin_src\" nil t)\n      (org-element-property :language (org-element-context)))) \"?\")`}\n`%`$0\n#+end_src\n"
                        "#+begin_src" nil nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/begin_src" nil "src")
                       ("<q" (progn (doom-snippets-expand :uuid "quote")) "#+begin_quote block" nil
                        nil nil "/home/lenz/.config/doom/snippets/org-mode/begin_quote" nil "<q")
                       ("<l" "#+begin_export latex\n`%`$0\n#+end_export\n"
                        "#+begin_export latex block" nil nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/begin_export_latex" nil "<l")
                       ("<h" "#+begin_export html\n`%`$0\n#+end_export\n"
                        "#+begin_export html block" nil nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/begin_export_html" nil "<h")
                       ("<a" "#+begin_export ascii\n`%`$0\n#+end_export\n" "#+begin_export ascii"
                        nil nil nil "/home/lenz/.config/doom/snippets/org-mode/begin_export_ascii"
                        nil "<a")
                       ("<E" (progn (doom-snippets-expand :uuid "export"))
                        "#+begin_export ... block" nil nil nil
                        "/home/lenz/.config/doom/snippets/org-mode/begin_export" nil nil)
                       ("<e" "#+begin_example\n`%`$0\n#+end_example\n" "#+begin_example block" nil
                        nil nil "/home/lenz/.config/doom/snippets/org-mode/begin_example" nil "<e")
                       ("<c" "#+begin_comment\n`%`$0\n#+end_comment\n" "#+begin_comment block" nil
                        nil nil "/home/lenz/.config/doom/snippets/org-mode/begin_comment" nil "<c")
                       ("<C" "#+begin_center\n`%`$0\n#+end_center\n" "#+begin_center block" nil nil
                        nil "/home/lenz/.config/doom/snippets/org-mode/begin_center" nil "<C")
                       ("begin" "#+begin_${1:type} ${2:options}\n`%`$0\n#+end_$1" "begin" nil nil
                        nil "/home/lenz/.config/doom/snippets/org-mode/begin" nil "begin")))


;;; Do not edit! File generated at Wed Dec 27 03:16:54 2023
