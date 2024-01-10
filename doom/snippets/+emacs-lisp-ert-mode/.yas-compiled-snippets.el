;;; Compiled snippets and support files for `+emacs-lisp-ert-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets '+emacs-lisp-ert-mode
                     '(("deftest"
                        "(ert-deftest $1 ()`(doom-snippets-format \"%n%s\")`$0)"
                        "ert-deftest" nil nil nil
                        "/home/lenz/.config/doom/snippets/+emacs-lisp-ert-mode/ert-deftest"
                        nil "deftest")
                       ("deft"
                        (progn (doom-snippets-expand :uuid "ert-deftest"))
                        "ert-deftest" nil nil nil
                        "/home/lenz/.config/doom/snippets/+emacs-lisp-ert-mode/deft"
                        nil "deft")))


;;; Do not edit! File generated at Mon Jan  8 21:54:43 2024
