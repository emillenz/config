;;; nushell-mode.el --- Major mode for Nushell scripts  -*- lexical-binding: t; -*-

;; Copyright (C) 2023 Mark Karpov
;; Copyright (C) 2022 Azzam S.A

;; Author: Azzam S.A <vcs@azzamsa.com>
;; Homepage: https://github.com/mrkkrp/nushell-mode
;; Keywords: languages, unix

;; Package-Version: 0.1.0
;; Package-Requires: ((emacs "24.4"))

;; SPDX-License-Identifier: GPL-3.0-or-later

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; A very basic version of major mode for Nushell shell scripts.

;;; Code:

(require 'cl-lib)
(eval-when-compile
  (require 'subr-x))

(defgroup nushell nil
  "Nushell shell support."
  :group 'languages
  :tag "Nushell"
  :prefix "nushell-"
  :link '(url-link :tag "GitHub" "https://github.com/mrkkrp/nushell-mode"))

(defcustom nushell-indent-offset 2
  "Default indentation offset for Nushell."
  :group 'nushell
  :type 'integer
  :safe 'integerp)

(defvar nushell-enable-auto-indent t
  "Controls auto-indent feature.
If the value of this variable is non-nil, whenever a word in
`nushell-auto-indent-trigger-keywords' is typed, it is indented instantly.")

(defconst nushell-builtins
  '("bit-and"
    "bit-or"
    "bit-shl"
    "bit-shr"
    "bit-xor"
    "ends-with"
    "fdiv"
    "mod"
    "not-in"
    "starts-with"
    "xor")
  "Nushell built-ins.")

(defconst nushell-keywords
  '("alias"
    "break"
    "exit"
    "const"
    "continue"
    "def"
    "use"
    "extern"
    "for"
    "hide"
    "if"
    "let"
    "loop"
    "match"
    "module"
    "mut"
    "return"
    "source"
    "source"
    "try"
    "use"
    "while"
    "catch"
    "and"
    "def-env"
    "else"
    "let-env"
    "not"
    "or"
    "do"
    "in")
  "Nushell keywords.

It is difficult to tell whether a certain word should be
considered a built-in or a keyword in Nushell.  We follow the
principle that keywords define structure and organization of
program to certain extent and thus deserve special highlighting
in order to aid reading.  Highlighting every built-in command as
a keyword would result in visual noise.")

(defconst nushell-types
  '("int"
    "float"
    "string"
    "bool"
    "date"
    "duration"
    "filesize"
    "binary"
    "list"
    "record"
    "table"
    "closure"
    "block"
    )
  "Nushell types.")


(defconst nushell-font-lock-keywords
  `(

    ;; Builtins
    (,(regexp-opt nushell-builtins 'symbols) . font-lock-builtin-face)

    ;; Keywords
    (,(regexp-opt nushell-keywords 'symbols) . font-lock-keyword-face)

    ;; Types
    (,(regexp-opt nushell-types 'symbols) . font-lock-type-face)

    ;; constants
    ;; duration
    ("[0-9]+\\(ns\\|us\\|ms\\|sec\\|hr\\|min\\|day\\|wk\\)" . 'font-lock-constant-face)
    ;; bool
    ("\\(true\\|false\\|null\\)" . 'font-lock-constant-face)
    ;; filesizes
    ("[0-0]+\\(b\\|kb\\|mb\\|gb\\|tb\\|pb\\|eb\\|kib\\|mib\\|gib\\|tib\\|pib\\|eib\\)" . 'font-lock-constant-face)

    ;; Variables
    ("\\$[[:word:]_\\.-]+" . font-lock-variable-name-face)

    ;; String interpolation (beginning of string)
    ("\\$" . 'font-lock-string-face)

    ;; Redirections
    ("\\(out\\|err\\|out\\+err\\|err\\+out\\)>" . 'font-lock-warning-face)

    ;; pipes
    ("|" . 'font-lock-warning-face)

    ;; Using system binaries instead of Nushell built-ins
    ("\\(\\^\\)\\(?:[[:word:]_-]+\\)" 1 'font-lock-warning-face)))

(defvar nushell-mode-syntax-table
  (let ((table (make-syntax-table text-mode-syntax-table)))
    (modify-syntax-entry ?\# "<" table)
    (modify-syntax-entry ?\n ">" table)
    (modify-syntax-entry ?\" "\"" table)
    (modify-syntax-entry ?\' "\"'" table)
    (modify-syntax-entry ?\\ "\\" table)
    (modify-syntax-entry ?$ "'" table)
    table)
  "Syntax table for `nushell-mode'.")

;;;###autoload
(define-derived-mode nushell-mode prog-mode "Nushell"
  "Major mode for editing nushell shell files."
  :syntax-table nushell-mode-syntax-table
  (setq-local font-lock-defaults '(nushell-font-lock-keywords))
  (setq-local comment-start "# ")
  (setq-local comment-start-skip "#+[\t ]*"))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.nu\\'" . nushell-mode))

;;;###autoload
(add-to-list 'interpreter-mode-alist '("nu" . nushell-mode))

(provide 'nushell-mode)

;;; nushell-mode.el ends here
