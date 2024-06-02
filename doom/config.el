;; [[file:config.org::*user][user:1]]
(setq user-full-name "emil lenz"
      user-mail-address "emillenz@protonmail.com")
;; user:1 ends here

;; [[file:config.org::*misc][misc:1]]
(add-hook! '(prog-mode-hook conf-mode-hook) #'rainbow-delimiters-mode)
;; misc:1 ends here

;; [[file:config.org::*modus-theme][modus-theme:1]]
(use-package! modus-themes
  :config
  (setq modus-themes-mixed-fonts t
        modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-org-blocks 'gray-background

        modus-themes-common-palette-overrides
        `((fg-region unspecified) ;; NOTE :: don't override syntax highlighting in region
          (fg-heading-1 fg-heading-0)))

  (custom-set-faces!
    `(org-list-dt :inherit modus-themes-heading-1)
    `(org-block-begin-line :foreground ,(modus-themes-get-color-value 'prose-metadata))
    `(org-quote :slant italic))

  (setq doom-theme 'modus-operandi))
;; modus-theme:1 ends here

;; [[file:config.org::*font][font:1]]
(setq doom-font                (font-spec :family "Iosevka Comfy" :size 14)
      doom-variable-pitch-font (font-spec :family "Iosevka Comfy" :size 14)
      doom-serif-font          (font-spec :family "Iosevka Comfy" :size 14)
      doom-big-font            (font-spec :family "Iosevka Comfy" :size 28))

(custom-set-faces!
  '(font-lock-keyword-face :slant normal :weight bold)
  '(font-lock-type-face    :slant normal)
  '(font-lock-comment-face :slant italic)
  '(font-lock-string-face  :slant italic))
;; font:1 ends here

;; [[file:config.org::*modeline][modeline:1]]
(setq display-battery-mode nil
      display-time-mode nil
      +modeline-height 10
      +modeline-bar-width nil) ;; visual clutter => off
;; modeline:1 ends here

;; [[file:config.org::*window layout & behavior][window layout & behavior:1]]
(setq evil-vsplit-window-right t
      evil-split-window-below t
      even-window-sizes 'width-only
      window-combination-resize t
      split-height-threshold nil
      split-width-threshold 0)

(after! org
  (setq org-src-window-setup 'current-window
        org-agenda-window-setup 'current-window))

(defvar z-popup-windows-rx "^\\*")
(add-to-list 'display-buffer-alist
             `(,z-popup-windows-rx display-buffer-reuse-mode-window))
;; window layout & behavior:1 ends here

;; [[file:config.org::*window layout & behavior][window layout & behavior:2]]
(add-hook! '(text-mode-hook
             ;; prog-mode-hook
             dired-mode-hook
             conf-mode-hook
             Info-mode-hook
             org-agenda-mode-hook
             magit-mode-hook)
           #'visual-fill-column-mode)

(global-display-fill-column-indicator-mode 0)

(setq-default visual-fill-column-enable-sensible-window-split t
              visual-fill-column-center-text t
              visual-fill-column-width 100
              fill-column 100)
;; window layout & behavior:2 ends here

;; [[file:config.org::*misc options][misc options:1]]
(setq initial-scratch-message ""
      delete-by-moving-to-trash t
      truncate-string-ellipsis "…"
      auto-save-default t
      confirm-kill-emacs nil
      hscroll-margin 0
      scroll-margin 0
      enable-recursive-minibuffers nil
      display-line-numbers-type 'visual
      shell-command-prompt-show-cwd t
      async-shell-command-width 100
      shell-file-name "/usr/bin/fish")

(save-place-mode 1)
(+global-word-wrap-mode 1)
(global-subword-mode 1)
;; misc options:1 ends here

;; [[file:config.org::*leader (\[\[kbd:SPC\]\[SPC\]\], \[\[kbd:,\]\[,\]\])][leader ([[kbd:SPC][SPC]], [[kbd:,][,]]):1]]
(setq doom-localleader-key ",")

(map! :leader
      (:prefix "s"
               "k" #'devdocs-lookup
               "g" #'occur)
      (:prefix "c"
               "r" #'lsp-rename
               (:prefix "'"
                        "t" #'org-babel-tangle
                        "T" #'org-babel-detangle))
      (:prefix "t"
               "c" #'global-visual-fill-column-mode))
;; leader ([[kbd:SPC][SPC]], [[kbd:,][,]]):1 ends here

;; [[file:config.org::*global navigation scheme][global navigation scheme:1]]
(map! :map 'override
      :nm "C-w" #'next-window-any-frame
      :nm "C-q" #'kill-buffer-and-window
      :nm "C-b" #'evil-switch-to-windows-last-buffer
      :nm "C-s" #'basic-save-buffer  ;; statisticall most frequently called command -> first layer binding (ergonomic & standard)
      :nm "C-e" #'find-file
      :nm "C-f" #'projectile-find-file
      :nm "C-g" #'consult-buffer
      :nm "C-1" #'harpoon-go-to-1
      :nm "C-2" #'harpoon-go-to-2
      :nm "C-3" #'harpoon-go-to-3
      :nm "C-4" #'harpoon-go-to-4)

(map! :leader "j" #'harpoon-quick-menu-hydra)
;; global navigation scheme:1 ends here

;; [[file:config.org::*vim editing][vim editing:1]]
(map! :after evil
      :n    "C-j" #'newline-and-indent ;; useful inverse of 'J'
      :n    "C-l" #'recenter-top-bottom ;; consistent with shell
      :nmvo "j"   #'evil-next-visual-line
      :nmvo "k"   #'evil-previous-visual-line
      :nmvo "^"   #'evil-first-non-blank-of-visual-line
      :nmvo "$"   #'evil-end-of-visual-line
      :nmv  "Q"   #'evil-execute-last-recorded-macro ;; quickly recall recorded macro            (used 80% of the time since we just have a single macro, recorded with 'qq')
      :nm   "U"   #'evil-redo ;; more mnemonic & sensible undo
      :nmv  "&"   #'evil-ex-repeat ;; more extensible than normal '&'
      :nmv  "("   #'backward-sexp ;; more useful than navigation by sentences
      :nmv  ")"   #'forward-sexp
      :nmv  "+"   #'evil-numbers/inc-at-pt ;; more sensible than C-x/C-a
      :nmv  "-"   #'evil-numbers/dec-at-pt
      :nmv  "g+"  #'evil-numbers/inc-at-pt-incremental
      :nmv  "g-"  #'evil-numbers/dec-at-pt-incremental
      :nmv  "g/"  #'+default/search-buffer) ;; more powerful '/' => preview matches interactively (better than vim's: C-g/C-t in search-mode)
;; vim editing:1 ends here

;; [[file:config.org::*vim editing][vim editing:2]]
(defadvice! z-update-evil-search-reg ()
  "Update evil search register after jumping to a line with
  `+default/search-buffer' to be able to jump to next/prev matches.
This is sensible default behaviour, and integrates it into evil."
  :after #'+default/search-buffer
  (let ((str (string-replace
              " " ".*"
              (car consult--line-history))))
    (push str evil-ex-search-history)
    (setq evil-ex-search-pattern (list str t t))))
;; vim editing:2 ends here

;; [[file:config.org::*Alignment][Alignment:1]]
(map! :nmv "g<" #'evil-lion-left
      :nmv "g>" #'evil-lion-right)
;; Alignment:1 ends here

;; [[file:config.org::*org (keybindings)][org (keybindings):1]]
(map! :localleader :map org-mode-map :after org
      "\\" #'org-latex-preview
      ","  #'org-ctrl-c-ctrl-c
      "-"  (cmd! (let ((current-prefix-arg '(16)))
                   (call-interactively #'org-toggle-checkbox)))
      "["  (cmd! (let ((current-prefix-arg '(4)))
                   (call-interactively #'org-toggle-checkbox)))
      "z"  #'org-add-note)
;; org (keybindings):1 ends here

;; [[file:config.org::*dired (keybindings)][dired (keybindings):1]]
(map! :map dired-mode-map :after dired
      :nm "h" #'dired-up-directory
      :nm "l" #'dired-open-file
      :nm "f" #'dired-goto-file
      :nm "c" #'dired-do-copy
      :nm "r" #'dired-do-rename
      :nm "R" #'dired-do-redisplay
      :nm "d" #'dired-do-delete
      :nm "x" #'dired-do-chmod
      :nm "s" #'dired-sort-toggle-or-edit
      :nm "o" #'dired-open-xdg
      :nm "p" #'dired-do-print
      :nm "y" #'dired-copy-filename-as-kill
      :nm "z" #'dired-do-compress
      :nm "." #'dired-omit-mode
      :nm "+" #'dired-create-empty-file) ;; create directories / files using find-file.

(map! :map dired-mode-map :localleader :after dired
      :nm "a" #'z-dired-archive)
;; dired (keybindings):1 ends here

;; [[file:config.org::*verilog (bindings)][verilog (bindings):1]]
(map! :after verilog-mode :map verilog-mode-map :localleader
      "cf" #'verilog-indent-buffer) ;; code:format
;; verilog (bindings):1 ends here

;; [[file:config.org::*editor][editor:1]]
(evil-surround-mode 1)

(after! evil
  (setq evil-want-fine-undo nil
        evil-ex-substitute-global t
        evil-want-C-i-jump t
        evil-want-C-h-delete t
        evil-want-minibuffer t
        evil-org-use-additional-insert nil
        evil-snipe-scope 'visible))

;; HACK :: make 'C-h' work like shell bindings everywhere
(define-key key-translation-map (kbd "C-h") (kbd "DEL"))
;; editor:1 ends here

;; [[file:config.org::*jumplist][jumplist:1]]
(dolist (cmd '(flycheck-next-error
               flycheck-previous-error
               +lookup/definition
               +lookup/references
               +lookup/implementations
               +default/search-buffer
               consult-imenu))
  (evil-add-command-properties cmd :jump t))

(dolist (cmd '(evil-backward-section-begin
               evil-forward-section-begin
               evil-jump-item
               evil-backward-paragraph
               evil-forward-paragraph
               evil-forward-section-end))
  (evil-remove-command-properties cmd :jump))
;; jumplist:1 ends here

;; [[file:config.org::*completion][completion:1]]
(vertico-flat-mode 1)

(after! company
  (setq company-minimum-prefix-length 0 ;; hide until activated
        consult-async-min-input 0
        company-tooltip-limit 16
        company-idle-delay nil
        company-tooltip-idle-delay 0.1
        company-show-quick-access t
        company-global-modes '(not
                               help-mode
                               eshell-mode
                               org-mode
                               vterm-mode)))

(map! :after minibuffer :map minibuffer-local-map ;; consistency with vim bindings
      :i "C-n" #'next-line-or-history-element
      :i "C-p" #'previous-line-or-history-element)

(map! :after company :map company-mode-map
      :i "C-n" #'company-complete)

(map! :map vertico-map
      :im "C-w" #'vertico-directory-delete-word ;; smarter C-w
      :im "C-d" #'consult-dir
      :im "C-f" #'consult-dir-jump-file)
;; completion:1 ends here

;; [[file:config.org::*snippets][snippets:1]]
(setq yas-triggers-in-field t)
;; snippets:1 ends here

;; [[file:config.org::*file templates][file templates:1]]
(set-file-templates!
 '(org-mode :trigger "header")
 '(prog-mode :trigger "header"))
;; file templates:1 ends here

;; [[file:config.org::*dired][dired:1]]
(after! dired
  (add-hook! 'dired-mode-hook #'dired-hide-details-mode) ;; less clutter (enable manually if needed)

    (setq dired-omit-files
        (rx (or (seq bol (? ".") "#")
                (seq bol "." (not (any ".")))
                (seq "~" eol)
                (seq bol "CVS" eol))))

  ;; NOTE:: this is the elegant & extensible way to do regex.
  (setq dired-open-extensions '(("mkv"  . "mpv")
                                ("mp4"  . "mpv")
                                ("mp3"  . "mpv")
                                ("gif"  . "nsxiv")
                                ("jpeg" . "nsxiv")
                                ("jpg"  . "nsxiv")
                                ("png"  . "nsxiv")
                                ("docx" . "libreoffice")
                                ("odt"  . "libreoffice")
                                ("odf"  . "libreoffice")
                                ("epub" . "zathura")
                                ("pdf"  . "zathura"))
        dired-recursive-copies 'always
        dired-recursive-deletes 'top
        global-auto-revert-non-file-buffers t
        dired-no-confirm '(uncompress move copy)))
;; dired:1 ends here

;; [[file:config.org::*Archive file][Archive file:1]]
(defvar z-archive-dir "~/Archive/"
  "User's archive directory.")

(defun z-dired-archive ()
  (interactive)
  (let ((files (dired-get-marked-files nil nil)))
    (dolist (f files)
      (let* ((dest (file-name-concat
                    z-archive-dir
                    (file-relative-name f "~/")))
             (dir (file-name-directory dest)))
        (unless (file-exists-p dir)
          (make-directory dir t))
        (rename-file f dest 1)))
    (revert-buffer)))
;; Archive file:1 ends here

;; [[file:config.org::*indentation][indentation:1]]
(advice-add #'doom-highlight-non-default-indentation-h :override #'ignore)

(defvar z-indent-width 8)

(setq-default standard-indent z-indent-width
              evil-shift-width z-indent-width
              tab-width z-indent-width
              fill-column 100
              tab-always-indent t
              tab-width z-indent-width
              org-indent-indentation-per-level z-indent-width
              evil-indent-convert-tabs t
              indent-tabs-mode nil)

(setq-hook! '(c-mode-hook java-mode-hook)
  c-basic-offset z-indent-width)

(setq-hook! 'ruby-mode-hook
  evil-shift-width z-indent-width
  ruby-indent-level z-indent-width)

(setq-hook! 'rustic-mode-hook
  rustic-indent z-indent-width
  rustic-indent-offset z-indent-width)

(setq-hook! 'verilog-mode-hook
  verilog-case-indent z-indent-width
  verilog-cexp-indent z-indent-width
  verilog-indent-level z-indent-width
  verilog-indent-level-behavioral z-indent-width
  verilog-indent-level-declaration z-indent-width
  verilog-indent-level-module z-indent-width)
;; indentation:1 ends here

;; [[file:config.org::*org][org:1]]
(after! org
;; org:1 ends here

;; [[file:config.org::*options][options:1]]
(add-hook! 'org-mode-hook '(visual-line-mode
                            org-fragtog-mode
                            rainbow-mode
                            laas-mode
                            +org-pretty-mode
                            org-appear-mode))

(setq org-directory "~/Documents/org/"
      org-archive-location "~/Archive/org/%s::" ;; NOTE :: archive based on file path
      org-use-property-inheritance t
      org-reverse-note-order t
      org-startup-with-latex-preview t
      org-startup-with-inline-images t
      org-startup-indented t
      org-startup-numerated t
      org-startup-align-all-tables t
      org-list-allow-alphabetical t
      org-tags-column 0
      org-fold-catch-invisible-edits 'smart
      org-export-headline-levels 5
      org-refile-use-outline-path 'full-file-path
      org-refile-allow-creating-parent-nodes 'confirm
      org-use-sub-superscripts '{}
      org-export-with-sub-superscripts '{}
      org-fontify-quote-and-verse-blocks t
      org-fontify-whole-block-delimiter-line t
      doom-themes-org-fontify-special-tags t
      org-ellipsis "…"
      org-num-max-level 3
      org-hide-leading-stars t
      org-appear-autoemphasis t
      org-appear-autosubmarkers t
      org-appear-autolinks t
      org-appear-autoentities t
      org-appear-autokeywords t
      org-appear-inside-latex nil
      org-hide-emphasis-markers t
      org-pretty-entities t
      org-pretty-entities-include-sub-superscripts t
      org-list-demote-modify-bullet '(("-"  . "-")
                                      ("+"  . "+")
                                      ("*"  . "-")
                                      ("a." . "a)")
                                      ("1." . "1)")
                                      ("1)" . "a)"))
      org-blank-before-new-entry
      '((heading . t)
        (plain-list-item . nil))
      org-src-ask-before-returning-to-edit-buffer nil)
;; options:1 ends here

;; [[file:config.org::*symbols][symbols:1]]
(add-hook! 'org-mode-hook '(org-superstar-mode
                            prettify-symbols-mode))

(setq org-superstar-headline-bullets-list '("◉" "◯" "▣" "□" "◈" "◇"))

(setq org-superstar-item-bullet-alist '((?- . "─")
                                        (?* . "─") ;; NOTE :: asteriks are reserved for headings only (don't use in lists) => no unambigiuity
                                        (?+ . "⇒")))

(appendq! +ligatures-extra-symbols '(:list_property "∷"
                                     :em_dash       "—"
                                     :ellipses      "…"
                                     :arrow_right   "→"
                                     :arrow_left    "←"
                                     :arrow_lr      "↔"
                                     :properties    "⚙"))

(add-hook! 'org-mode-hook
  (appendq! prettify-symbols-alist '(("--"  . "–")
                                     ("---" . "—")
                                     ("->" . "→")
                                     ("=>" . "⇒")
                                     ("<=>" . "⇔"))))
;; symbols:1 ends here

;; [[file:config.org::*task states][task states:1]]
(setq org-todo-keywords '((sequence "[ ](t)"
                           "[@](e)"
                           "[?](?!)"
                           "[-](-!)"
                           "[>](>!)"
                           "[=](=!)"
                           "[&](&!)"
                           "|"
                           "[x](x!)"
                           "[\\](\\!)")))

(setq org-todo-keyword-faces '(("[@]"  . '(bold +org-todo-project))
                               ("[ ]"  . '(bold org-todo))
                               ("[-]"  . '(bold +org-todo-active))
                               ("[>]"  . '(bold +org-todo-onhold))
                               ("[?]"  . '(bold +org-todo-onhold))
                               ("[=]"  . '(bold +org-todo-onhold))
                               ("[&]"  . '(bold +org-todo-onhold))
                               ("[\\]" . '(bold org-done))
                               ("[x]"  . '(bold org-done))))
;; task states:1 ends here

;; [[file:config.org::*task states][task states:2]]
(setq org-log-done 'time
      org-log-repeat 'time
      org-todo-repeat-to-state "[ ]"
      org-log-redeadline 'time
      org-log-reschedule 'time
      org-log-into-drawer "LOG")

(setq org-priority-highest 1
      org-priority-lowest 3)

(setq org-log-note-headings '((done        . "note-done: %t")
                              (state       . "state: %-3S -> %-3s %t") ;; NOTE :: the custom task-statuses are all 3- wide
                              (note        . "note: %t")
                              (reschedule  . "reschedule: %S, %t")
                              (delschedule . "noschedule: %S, %t")
                              (redeadline  . "deadline: %S, %t")
                              (deldeadline . "nodeadline: %S, %t")
                              (refile      . "refile: %t")
                              (clock-out   . "")))
;; task states:2 ends here

;; [[file:config.org::*babel][babel:1]]
(setq org-babel-default-header-args '((:session  . "none")
                                      (:results  . "replace")
                                      (:exports  . "code")
                                      (:cache    . "no")
                                      (:noweb    . "no")
                                      (:hlines   . "no")
                                      (:tangle   . "no")
                                      (:mkdirp   . "yes")
                                      (:comments . "link")))
;; babel:1 ends here

;; [[file:config.org::*agenda][agenda:1]]
(add-hook! 'org-agenda-mode-hook #'org-super-agenda-mode)

(setq org-agenda-files (directory-files-recursively org-directory ".*\.org" t)
      org-agenda-skip-scheduled-if-done t
      org-agenda-sticky t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-tags-column 0
      org-agenda-block-separator ?─
      org-agenda-breadcrumbs-separator "…"
      org-agenda-compact-blocks nil
      org-agenda-show-future-repeats nil
      org-deadline-warning-days 3
      org-agenda-time-grid nil
      org-capture-use-agenda-date t)

(defadvice! z-add-newline (fn &rest args)
  "Separate dates in 'org-agenda' with newline."
  :around #'org-agenda-format-date-aligned
  (concat "\n" (apply fn args) ))
;; agenda:1 ends here

;; [[file:config.org::*agenda][agenda:2]]
(setq org-agenda-todo-keyword-format "%-3s"
      org-agenda-scheduled-leaders '("──────"
                                     "<- %2dd") ;; NOTE :: unicode is not fixed width => breaks formatting => cannot use it.
      org-agenda-deadline-leaders '("━━━━━━"
                                    "=> %2dd"
                                    "<= %2dd")
      org-agenda-prefix-format '((agenda . "%-12c%-7s%-12t")
                                 (todo .   "%-12c%-7s%-12t")
                                 (tags .   "%-12c%-7s%-12t")
                                 (search . "%-12c%-7s%-12t")))
;; agenda:2 ends here

;; [[file:config.org::*clock][clock:1]]
(setq org-clock-out-when-done t
      org-clock-persist t
      org-clock-into-drawer t)
;; clock:1 ends here

;; [[file:config.org::*capture templates][capture templates:1]]
(defvar z-org-literature-dir "~/Documents/literature/notes/")

  (defvar z-org-journal-dir (file-name-concat "~/Documents/journal/"))

  (defun z-doct-journal-file (&optional time)
    "TIME :: time in day of note to return. (default: today)"
    (file-name-concat z-org-journal-dir
                      (format "%s_journal.org"
                              (format-time-string "%F" (or time (current-time))))))

  (defvar z-doct-projects '(("cs"       :keys "c"
                             :children (("pp"     :keys "p")
                                        ("as1"    :keys "a")
                                        ("aw"     :keys "w")
                                        ("ddca"   :keys "d")))
                            ("personal" :keys "p")
                            ("config"   :keys "f")
                            ("compass"  :keys "o")))

  (defun z-doct-projects-file (type path)
    "TYPE :: [ 'agenda, 'notes ]"
    (file-name-concat org-directory
                      path
                      (format "%s.org" (symbol-name type))))

  (defun z-doct-task-template (path)
    (list "task"
          :keys "t"
          :file (z-doct-projects-file 'agenda path)
          :headline "inbox"
          :prepend t
          :empty-lines-after 1
          :template '("* [ ] %^{title}%?")))

  (defun z-doct-event-template (path)
    (list "event"
          :keys "e"
          :file (z-doct-projects-file 'agenda path)
          :headline "events"
          :prepend t
          :empty-lines-after 1
          :template '("* [@] %^{title}%?"
                      "%^T"
                      ":PROPERTIES:"
                      ":REPEAT_TO_STATE: [@]" ; NOTE :: in case is made repeating
                      ":location: %^{location}"
                      ":material: %^{material}"
                      ":END:")))

  (defun z-doct-note-template (path)
    (list "note"
          :keys "n"
          :file (z-doct-projects-file 'notes path)
          :prepend t
          :empty-lines 1
          :template '("* %^{title} %^g"
                      ":PROPERTIES:"
                      ":created: %U"
                      ":END:"
                      "%?")))

  (defun z-doct-expand-projects (&optional projects parent-path)
    "PROJECTS :: nil | used for recursion
PARENT-PATH :: nil | used for recursion"
    (mapcar (lambda (project)
              (let* ((props (cdr project))
                     (tag (car project))
                     (key (plist-get props :keys))
                     (self `(,tag :keys ,key))
                     (children (plist-get props :children))
                     (path (file-name-concat parent-path tag)))
                (append self
                        (if children
                            (list :children (append (z-doct-expand-projects children ;; NOTE :: don't create subdir again for parent-project
                                                                            path)
                                                    (z-doct-expand-projects (list self)
                                                                            nil)))
                          (list :children (list (z-doct-task-template path)
                                                (z-doct-event-template path)
                                                (z-doct-note-template path)))))
                ))
            (or projects
                z-doct-projects)))

  (setq org-capture-templates
        (doct `(,@(z-doct-expand-projects)

                ("journal"
                 :keys "j"
                 :file (lambda () (z-doct-journal-file))
                 :title (lambda () (downcase (format-time-string "daily note: %A, %e. %B %Y")))
                 :children (("journal init"
                             :keys "j"
                             :type plain
                             :template  ("#+title:  %{title}"
                                         "#+author: %(user-full-name)"
                                         "#+email:  %(message-user-mail-address)"
                                         "#+date:   %<%F>"
                                         "#+filetags: :journal:"
                                         ""
                                         "* goals"
                                         "- [ ] %?"
                                         ""
                                         "* agenda"
                                         "** [ ] "))

                            ("note"
                             :keys "n"
                             :headline "notes"
                             :prepent t
                             :empty-lines-after 1
                             :template ("* %^{title}"
                                        ":PROPERTIES:"
                                        ":created: %U"
                                        ":END:"
                                        "%?"))

                            ("yesterday review"
                             :keys "y"
                             :unnarrowed t
                             :file (lambda ()
                                     (z-doct-journal-file (time-subtract (current-time) (days-to-time 1))))
                             :template ("* gratitude"
                                        "- %?"
                                        ""
                                        "* reflection"
                                        "-"))))

                ("literature"
                 :keys "l"
                 :file (lambda () (read-file-name "file: " z-org-literature-dir))
                 :children (("to read"
                             :keys "r"
                             :file ,(file-name-concat z-org-literature-dir "readlist.org")
                             :prepend t
                             :template ("* [ ] %^{title}%? %^g"))

                            ("init"
                             :keys "i"
                             :file (lambda ()
                                     (let* ((name (concat (replace-regexp-in-string " "
                                                                                    "_"
                                                                                    (read-from-minibuffer "short title: "))
                                                          ".org")))
                                       (file-name-concat z-org-literature-dir name)))
                             :type plain
                             :template ("#+title:  %^{full title}"
                                        "#+author: %(user-full-name)"
                                        "#+email:  %(message-user-mail-address)"
                                        "#+date:   %<%F>"
                                        "#+filetags: :literature:%^g"
                                        ""
                                        "* [-] %\\1%?"
                                        ":PROPERTIES:"
                                        ":title:  %\\1"
                                        ":author: %^{author}"
                                        ":year:   %^{year}"
                                        ":type:   %^{ |book|textbook|ebook|paper|article|audiobook|podcast}"
                                        ":pages:  %^{pages}"
                                        ":END:"))

                            ("excerpt"
                             :keys "e"
                             :headline "excerpts"
                             :empty-lines-before 1
                             :template ("* %^{title} [pg:%^{page}]"
                                        ":PROPERTIES:"
                                        ":created: %U"
                                        ":END:"
                                        "#+begin_quote"
                                        "%x"
                                        "#+end_quote"))

                            ("note: literary"
                             :keys "l"
                             :headline "literature notes"
                             :empty-lines-before 1
                             :template ("* %^{title} [pg:%^{page}] %^g"
                                        ":PROPERTIES:"
                                        ":created: %U"
                                        ":END:"
                                        "%?"))

                            ("note: transient"
                             :keys "t"
                             :headline "transient notes"
                             :empty-lines-before 1
                             :template ("* %^{title} %^g"
                                        ":PROPERTIES:"
                                        ":created: %U"
                                        ":END:"
                                        "%?"))

                            ;; NOTE :: make sure to complete the literature-task-headline in order to log closing time.
                            ("summarize"
                             :keys "c"
                             :headline "summary"
                             :unnarrowed t
                             :type plain
                             :template ("%?")))))))
;; capture templates:1 ends here

;; [[file:config.org::*capture templates][capture templates:2]]
)
;; capture templates:2 ends here

;; [[file:config.org::*latex][latex:1]]
(setq +latex-viewers '(zathura))
;; latex:1 ends here

;; [[file:config.org::*verilog-mode][verilog-mode:1]]
(after! verilog-mode
  (setq verilog-auto-newline nil))
;; verilog-mode:1 ends here

;; [[file:config.org::*dictionary][dictionary:1]]
(after! dictionary
  (setq dictionary-server "dict.org"
        dictionary-default-dictionary "*")) ;; no confirmation prompt which server to use
;; dictionary:1 ends here

;; [[file:config.org::*lisp][lisp:1]]
(after! lispy (setq lispy-key-theme '())) ;; don't use insert bindings (unneccessary & creates mental overhead)
;; lisp:1 ends here
