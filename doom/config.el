;; [[file:config.org::*User][User:1]]
(setq
 user-full-name "Emil Lenz"
 user-mail-address "emillenz@protonmail.com")
;; User:1 ends here

;; [[file:config.org::*Theme][Theme:1]]
(setq
 doom-themes-enable-bold t
 doom-theme 'doom-solarized-dark

 doom-themes-enable-italic nil)

(after! evil
  (setq
   x-stretch-cursor t
   evil-normal-state-cursor   '("#268BD2" box)
   evil-insert-state-cursor   '("#268BD2" bar)
   evil-visual-state-cursor   '("#6c71c4" box)
   evil-motion-state-cursor   '("#cb4b16" box)
   evil-operator-state-cursor '("#cb4b16" box)
   evil-replace-state-cursor  '("#268BD2" hbar)))
;; Theme:1 ends here

;; [[file:config.org::*Font][Font:1]]
(setq
 doom-font-increment 1
 doom-big-font-increment 1
 doom-font                (font-spec :family "Terminus" :size 12)
 doom-variable-pitch-font (font-spec :family "Terminus" :size 12)
 doom-serif-font          (font-spec :family "Terminus" :size 12)
 doom-big-font            (font-spec :family "Terminus" :size 24))

(custom-set-faces!
  '(font-lock-keyword-face :slant normal :weight bold)
  '(font-lock-type-face    :slant normal :weight normal)
  '(font-lock-comment-face :slant normal :weight normal))
;; Font:1 ends here

;; [[file:config.org::*Modeline][Modeline:1]]
(setq
 display-battery-mode nil
 display-time-mode nil
 doom-modeline-height 15
 doom-modeline-bar-width 5
 doom-modeline-enable-word-count t
 doom-modeline-persp-name t)
;; Modeline:1 ends here

;; [[file:config.org::*Misc Options][Misc Options:1]]
(setq
 bookmark-default-file "~/.config/doom/bookmarks"
 delete-by-moving-to-trash t
 truncate-string-ellipsis "…"
 auto-save-default t

 confirm-kill-emacs nil
 undo-limit 80000000
 history-length 1000
 which-key-idle-delay 1
 which-key-allow-multiple-replacements t
 hscroll-margin 0
 scroll-margin 0 ;; maximize screen real estate (minimize context switching)
 highlight-indent-guides-responsive  t
 display-line-numbers-type 'visual)

(setq-default major-mode 'org-mode)

(save-place-mode 1)
(+global-word-wrap-mode 1)
(global-subword-mode 1)
(beacon-mode 1)

(tab-bar-mode 1)
(setq tab-bar-tab-hints t
      tab-bar-close-button-show nil)
;; Misc Options:1 ends here

;; [[file:config.org::*Window layout & behavior][Window layout & behavior:1]]
(setq
 evil-vsplit-window-right t
 even-window-sizes 'width-only
 window-combination-resize t
 split-height-threshold nil
 split-width-threshold 0
 )
;; Window layout & behavior:1 ends here

;; [[file:config.org::*Window layout & behavior][Window layout & behavior:2]]
(setq-default +popup-defaults
              '(:side right
                :width 0.33
                :select nil
                :quit nil
                :modeline t))
;; Window layout & behavior:2 ends here

;; [[file:config.org::*Window layout & behavior][Window layout & behavior:3]]
;; NOTE: not prog mode
(add-hook!
 '(text-mode-hook
   dired-mode-hook
   org-agenda-mode-hook
   magit-mode-hook
   )
 #'visual-fill-column-mode)

(global-display-fill-column-indicator-mode -1) ;; distracting
(setq
 visual-fill-column-enable-sensible-window-split t
 visual-fill-column-center-text t
 visual-fill-column-width 100
 fill-column 100)
;; Window layout & behavior:3 ends here

;; [[file:config.org::*Completion menus][Completion menus:1]]
(setq consult-async-min-input 0)
;; Completion menus:1 ends here

;; [[file:config.org::*Leader][Leader:1]]
(setq
 doom-leader-key "SPC"
 doom-leader-alt-key "M-SPC"
 doom-localleader-key ","
 doom-leader-alt-key "M-,")

(map! :leader
      (:prefix ("t" . "toggle")
               "V" 'visual-fill-column-mode
               "C" 'company-mode)
      (:prefix ("i" . "insert")
               "d" #'z/insert-todays-date
               "D" #'z/insert-any-date)
      (:prefix ("c" . "code")
               "w" #'z/clean-whitespace
               (:prefix ("b" . "org-babel")
                        "d" #'org-babel-detangle
                        "J" #'org-babel-tangle-jump-to-org
                        "j" #'z/jump-src
                        "t" #'org-babel-tangle
                        "e" #'org-edit-special)))
;; Leader:1 ends here

;; [[file:config.org::*Global navigation scheme][Global navigation scheme:1]]
(setq tab-bar-new-tab-to 'rightmost)

;; HACK: ~:inmvorem~ binds globally no matter where you are
(after! evil
(map! :map  'override
      :inmvorem "M-j" #'tab-bar-switch-to-prev-tab
      :inmvorem "M-J" #'tab-bar-move-tab-backward
      :inmvorem "M-k" #'tab-bar-switch-to-next-tab
      :inmvorem "M-K" #'tab-bar-move-tab
      :inmvorem "M-q" #'tab-bar-close-tab
      :inmvorem "M-Q" #'save-buffers-kill-terminal
      :inmvorem "M-t" #'tab-bar-new-tab-to
      :inmvorem "M-1" (cmd! (tab-bar-select-tab 1))
      :inmvorem "M-2" (cmd! (tab-bar-select-tab 2))
      :inmvorem "M-3" (cmd! (tab-bar-select-tab 3))
      :inmvorem "M-4" (cmd! (tab-bar-select-tab 4))
      :inmvorem "M-5" (cmd! (tab-bar-select-tab 5))
      :inmvorem "M-6" (cmd! (tab-bar-select-tab 6))
      :inmvorem "M-7" (cmd! (tab-bar-select-tab 7))
      :inmvorem "M-8" (cmd! (tab-bar-select-tab 8))
      :inmvorem "M-9" (cmd! (tab-bar-select-tab 9))
      :inmvorem "M-e" #'find-file
      :inmvorem "M-F" (cmd! (consult-find "~"))
      :inmvorem "M-f" #'consult-find
      :inmvorem "M-g" #'consult-buffer
      :inmvorem "M-c" #'shell-command
      :inmvorem "M-;" #'execute-extended-command
      :inmvorem "M-'" #'consult-bookmark

      :inmvorem "C--" #'doom/decrease-font-size
      :inmvorem "C-=" #'doom/increase-font-size
      :inmvorem "C-0" #'doom/reset-font-size)
)

(after! evil-org
  (map! :map evil-org-agenda-mode-map
        :inmvorem "M-j" #'evil-tab-previous
        :inmvorem "M-k" #'evil-tab-next
        ))
;; Global navigation scheme:1 ends here

;; [[file:config.org::*Evil-mode][Evil-mode:1]]
(after! evil
  ;; HACK disable all default-maps (custom map below)
  (add-hook 'evil-mode-hook #'evil-cleverparens-mode)
  (setq evil-cleverparens-use-s-and-S nil
        evil-cleverparens-use-additional-bindings nil
        evil-cleverparens-use-additional-movement-keys nil)
  (map!
   :nmvo "j"   #'evil-next-visual-line
   :nmvo "k"   #'evil-previous-visual-line

   :nmv  "U"   #'evil-redo
   :nmv  "Q"   #'evil-execute-last-recorded-macro
   :nmv  "RET" #'electric-newline-and-maybe-indent

   :nmv  "]e"  #'flycheck-next-error
   :nmv  "[e"  #'flycheck-previous-error

   :nmv  "H"   #'evil-first-non-blank
   :nmv  "L"   #'evil-end-of-visual-line

   :nmv  "("   #'evil-cp-backward-up-sexp
   :nmv  ")"   #'evil-cp-up-sexp
   :nmv  "{"   #'evil-cp-previous-opening
   :nmv  "}"   #'evil-cp-next-closing

   :nmv  "+"   #'evil-numbers/inc-at-pt
   :nmv  "-"   #'evil-numbers/dec-at-pt
   :nmv  "g+"  #'evil-numbers/inc-at-pt-incremental
   :nmv  "g-"  #'evil-numbers/dec-at-pt-incremental

   :nmv  "go" #'consult-outline
   )
  )
;; Evil-mode:1 ends here

;; [[file:config.org::*Alignment][Alignment:1]]
(after! evil
  (map!
   :nmv "g<" #'evil-lion-left
   :nmv "g>" #'evil-lion-right
   ))
;; Alignment:1 ends here

;; [[file:config.org::*Control-bindings][Control-bindings:1]]
(after! evil
  (map!
   :inmvorem "C-s" #'basic-save-buffer
   :inmvorem "C-z" #'evil-scroll-line-to-center
   :inmvorem "C-w" #'next-window-any-frame
   :inmvorem "C-q" #'evil-window-delete
   :inmv     "C-j" #'drag-stuff-down
   :inmv     "C-k" #'drag-stuff-up
   ))
;; Control-bindings:1 ends here

;; [[file:config.org::*Instant jumping][Instant jumping:1]]
(after! avy (setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?n ?s ?p ?y ?f ?g ?c ?r ?l ?q ?j ?k ?x ?b ?m ?w ?v ?z)))
(after! evil
  (map! :map evil-snipe-local-mode-map ;; need to override evil-snipe
        :nmvo "s" #'evil-avy-goto-char-2-below
        :nmvo "S" #'evil-avy-goto-char-2-above
        ))
;; Instant jumping:1 ends here

;; [[file:config.org::*Evil surround operator][Evil surround operator:1]]
(after! evil
  (map! :map evil-operator-state-map
        "'" #'evil-surround-edit)
  (map!
   :nmv "'" #'evil-surround-region
   :nmv "'" #'evil-surround-region
   ))
;; Evil surround operator:1 ends here

;; [[file:config.org::*Org mode][Org mode:1]]
(after! evil-org
  (map! :map evil-org-mode-map
        :nmv "]]"     #'org-forward-paragraph
        :nmv "[["     #'org-backward-paragraph
        :inmv "S-RET" #'org-meta-return
        :inmv "C-RET" #'+org/insert-item-below
        :nmv  "RET"   #'org-return-maybe-indent
        :nmvo "H"     #'evil-org-beginning-of-line
        :nmvo "L"     #'evil-org-end-of-line
        :inmv "C-j"   #'org-metadown
        :inmv "C-k"   #'org-metaup
        :inmv "C-h"   #'org-metaleft
        :inmv "C-l"   #'org-metaright
        )
  (map! :leader
        (:prefix ("c" . "code")
                 "f" #'z/org-format-buffer
                 )
        )

  (map! :localleader
        :map evil-org-mode-map
        "~"    #'z/org-convert-keywords-downcase
        "l f"  #'z/org-link-file
        )
  (map! :map org-src-mode-map
        :nm "ZZ" #'org-edit-src-exit
        :nm "ZQ" #'org-edit-src-abort
        )
  )
;; Org mode:1 ends here

;; [[file:config.org::*Dired][Dired:1]]
(after! dired
  (map! :map dired-mode-map
        :nm "h" #'dired-up-directory
        :nm "l" #'dired-open-file
        :nm "c" #'dired-do-copy
        :nm "C" #'dired-do-compress
        :nm "r" #'dired-do-rename
        :nm "R" #'dired-do-redisplay
        :nm "d" #'dired-do-delete
        :nm "x" #'dired-do-chmod
        :nm "s" #'dired-sort-toggle-or-edit
        :nm "o" #'dired-do-chown
        :nm "p" #'dired-do-print
        :nm "y" #'dired-copy-filenamecopy-filename-as-kill
        :nm "z" #'dired-do-compress
        :nm "." #'dired-omit-mode
        :nm "e" #'dired-create-empty-file
        :nm "E" #'dired-create-directory
        )
)
;; Dired:1 ends here

;; [[file:config.org::*Evil mode][Evil mode:1]]
(after! evil
  (evil-surround-mode 1)

  (setq
   evil-magic 'verymagic ;; less escaping
   evil-want-fine-undo nil
   evil-ex-substitute-global t
   evil-move-cursor-back t
   evil-move-beyond-eol nil
   evil-kill-on-visual-paste nil
   evil-want-C-i-jump t
   evil-want-minibuffer t
   )

  (setq
   evil-snipe-scope 'visible
   evil-snipe-repeat-keys t
   evil-snipe-override-evil-repeat-keys t
   evil-snipe-auto-scroll nil
   )

  (dolist (cmd
           '(flycheck-next-error
             flycheck-previous-error
             +lookup/definition
             +lookup/references
             +lookup/implementations
             ))
    (evil-add-command-properties cmd :jump t)))
;; Evil mode:1 ends here

;; [[file:config.org::*Lsp & completion][Lsp & completion:1]]
(after! company
  (setq
   company-minimum-prefix-length 1
   company-idle-delay 0.2 ;; BUG: never set to 0
   company-show-quick-access t
   company-global-modes
   '(not
     erc-mode
     message-mode
     help-mode
     gud-mode
     vterm-mode))
  )
;; Lsp & completion:1 ends here

;; [[file:config.org::*Templates & snippets][Templates & snippets:1]]
(setq yas-triggers-in-field t)
(set-file-templates!
 '(org-mode :trigger "header")
 '(prog-mode :trigger "header")
 )
;; Templates & snippets:1 ends here

;; [[file:config.org::*Dired Mode][Dired Mode:1]]
(after! dired
  (setq dired-omit-files
        (rx (or
             (seq bol (? ".") "#")
             (seq bol "." (not (any ".")))
             (seq "~" eol)
             (seq bol "CVS" eol))))

  (setq dired-open-extensions
        '(("mkv"  . "mpv")
          ("mp4"  . "mpv")
          ("mp3"  . "ncmpcpp")
          ("gif"  . "nsxiv")
          ("jpeg" . "nsxiv")
          ("jpg"  . "nsxiv")
          ("png"  . "nsxiv")
          ("docx" . "libreoffice")
          ("odt"  . "libreoffice")
          ("odf"  . "libreoffice")
          ("epub" . "zathura")
          ("pdf"  . "zathura")
          ))

  (add-hook! 'dired-mode-hook #'dired-hide-details-mode)

  (setq
   dired-recursive-copies 'always
   dired-recursive-deletes 'top
   global-auto-revert-non-file-buffers t
   dired-kill-when-opening-new-dired-buffer t
   )
  )
;; Dired Mode:1 ends here

;; [[file:config.org::*Org Mode][Org Mode:1]]
(after! org
;; Org Mode:1 ends here

;; [[file:config.org::*Options][Options:1]]
(use-package! org-pandoc-import :after org)

(add-hook! 'org-mode-hook
           #'visual-line-mode
           #'org-num-mode
           #'org-appear-mode
           )

;; NOTE: add hook AFTER entering org-mode
(add-hook! 'org-mode-hook
  (lambda () (add-hook! 'after-save-hook #'org-babel-tangle)))

(setq
 org-directory "~/Documents/org"
 org-archive-location "~/Archive/org/%s::" ;; archive based on file path
 org-blank-before-new-entry '((heading . t)
                              (plain-list-item . nil))
 org-use-property-inheritance t
 org-startup-with-inline-images t
 org-startup-indented t
 org-list-allow-alphabetical t
 org-tags-column 0
 org-fold-catch-invisible-edits 'smart
 org-export-headline-levels 5
 org-refile-use-outline-path 'file
 org-refile-allow-creating-parent-nodes 'confirm
 org-use-sub-superscripts 't
 org-startup-with-inline-images t
 org-fontify-quote-and-verse-blocks t
 org-fontify-whole-block-delimiter-line t
 org-export-with-sub-superscripts '{}
 doom-themes-org-fontify-special-tags t
 org-startup-with-latex-preview nil
 org-insert-heading-respect-content t
 org-M-RET-may-split-line t
 org-ellipsis "…"
 org-num-max-level 3
 org-table-convert-region-max-lines 20000)

(setq
 org-hide-leading-stars t
 org-appear-autoemphasis t
 org-appear-autosubmarkers t
 org-appear-autolinks t
 org-appear-autoentities t
 org-hide-emphasis-markers t)

(+org-pretty-mode 1)

(setq
 org-pretty-entities t
 org-pretty-entities-include-sub-superscripts t)

(setq
 org-list-demote-modify-bullet
 '( ("-"  . "+")
    ("+"  . "+")
    ("*"  . "+")
    ("1."  . "a.")
    ("1)" . "a)")))

(setf org-blank-before-new-entry
      '((heading          . t)
        (plain-list-item . nil)))
;; Options:1 ends here

;; [[file:config.org::*Symbols][Symbols:1]]
(add-hook! 'org-mode-hook #'org-superstar-mode #'prettify-symbols-mode)
(setq
 org-superstar-headline-bullets-list '("◉" "◯" "◈" "◇" "▣" "□")
 org-superstar-item-bullet-alist
 '((?-  . "━")
   (?* . "●")
   (?+ . "")))

(setq-default prettify-symbols-alist
              '(("#+begin_src" . "")
                ("#+end_src" . "")
                ("#+begin_quote" . "")
                ("#+end_quote" . "")
                ("#+begin_comment" . "⫽")
                ("#+end_comment" . "⫽")
                ("#+RESULTS:" . "󰞖"))) ;; HACK: results is an uppercase artifact
;; Symbols:1 ends here

;; [[file:config.org::*Symbols][Symbols:2]]
(plist-put! +ligatures-extra-symbols
            :and           nil
            :or            nil
            :for           nil
            :not           nil
            :true          nil
            :false         nil
            :int           nil
            :float         nil
            :str           nil
            :bool          nil
            :list          nil
            )
;; Symbols:2 ends here

;; [[file:config.org::*Todo states][Todo states:1]]
(setq org-todo-keywords
      '((type
         "[#](#)"
         "[ ](t)"
         "[?](?!)"
         "[>](>@)"
         "[\\](\\@)"
         "[&](&@)"
         "|"
         "[X](x!)"
         "[^](^@)"
         "[@](d@)"))) ;; HACK: cannot use"@"
;; Todo states:1 ends here

;; [[file:config.org::*Todo states][Todo states:2]]
(setq org-todo-keyword-faces
      '(("[#]"  . +org-todo-project)
        ("[ ]"  . +org-todo-cancel)
        ("[>]"  . +org-todo-onhold)
        ("[@]"  . +org-todo-active)
        ("[?]"  . org-todo)
        ("[\\]" . org-todo)
        ("[&]"  . org-todo)
        ("[X]"  . org-done)
        ("[^]"  . org-done)
        ))
;; Todo states:2 ends here

;; [[file:config.org::*Todo states][Todo states:3]]
(setq
 org-log-done 'time
 org-log-repeat 'time
 org-todo-repeat-to-state t
 org-log-redeadline 'note
 org-log-reschedule 'time
 org-log-into-drawer "LOG"
 )

(setq
 org-priority-highest 1
 org-priority-lowest 3
 org-priority-faces
 '((?1  . 'all-the-icons-red)
   (?2 . 'all-the-icons-orange)
   (?3 . 'all-the-icons-yellow)))
;; Todo states:3 ends here

;; [[file:config.org::*Babel][Babel:1]]
(setq org-babel-default-header-args
      '((:session  . "none")
        (:results  . "replace")
        (:exports  . "code")
        (:cache    . "no")
        (:noweb    . "no")
        (:hlines   . "no")
        (:tangle   . "no")
        (:mkdirp   . "yes")
        (:comments . "no")))
;; Babel:1 ends here

;; [[file:config.org::*Org-src-edit-mode][Org-src-edit-mode:1]]
(defvar org-babel-lang-list
  '("python"
    "ipython"
    "bash"
    "sh"
    "c"
    "cpp"
    "java"
    "rust"
    ))

(cl-defmacro lsp-org-babel-enable (lang)
  "Support LANG in org source code block."
  (setq centaur-lsp 'lsp-mode)
  (cl-check-type lang stringp)
  (let*
      ((edit-pre (intern (format
                          "org-babel-edit-prep:%s"
                          lang)))
       (intern-pre (intern (format
                            "lsp--%s"
                            (symbol-name edit-pre)))))
    `(progn
       (defun ,intern-pre (info)
         (let ((file-name (->> info caddr (alist-get :file))))
           (unless file-name
             (setq file-name (make-temp-file "babel-lsp-")))
           (setq buffer-file-name file-name)
           (lsp-deferred)))
       (put ',intern-pre 'function-documentation
            (format
             "Enable lsp-mode in the buffer of org source block (%s)."
             (upcase ,lang)))
       (if (fboundp ',edit-pre)
           (advice-add ',edit-pre :after ',intern-pre)
         (progn
           (defun ,edit-pre (info)
             (,intern-pre info))
           (put ',edit-pre 'function-documentation
                (format
                 "Prepare local buffer environment for org source block (%s)."
                 (upcase ,lang))))))))
(dolist (lang org-babel-lang-list)
  (eval `(lsp-org-babel-enable ,lang)))
;; Org-src-edit-mode:1 ends here

;; [[file:config.org::*Agenda][Agenda:1]]
(after! org-agenda (org-super-agenda-mode))

(setq
 org-agenda-files (directory-files-recursively org-directory ".*\.org" t)
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
 org-agenda-deadline-faces
 '((1.0 . error)
   (1.0 . org-warning)
   (0.5 . org-upcoming-deadline)
   (0.0 . org-upcoming-distant-deadline))
 org-agenda-time-grid nil
 org-capture-use-agenda-date t
 )
;; Agenda:1 ends here

;; [[file:config.org::*Agenda][Agenda:2]]
(setq
 org-agenda-scheduled-leaders '("─────" "<-%2dd")
 org-agenda-deadline-leaders '("━━━━━" "=>%2dd" "<=%2dd")
 org-agenda-todo-keyword-format "%-3s"
 org-agenda-prefix-format
 '((agenda . "%-12c%-6s%-12t")
   (todo .   "%-12c%-6s%-12t")
   (tags .   "%-12c%-6s%-12t")
   (search . "%-12c%-6s%-12t")))
;; Agenda:2 ends here

;; [[file:config.org::*Clock][Clock:1]]
(setq
 org-clock-out-when-done t
 org-clock-persist t
 org-clock-into-drawer t)
;; Clock:1 ends here

;; [[file:config.org::*Roam][Roam:1]]
(setq
 org-roam-directory "~/Documents/"
 org-roam-dailies-directory "~/Documents/journal/"
 org-roam-completion-everywhere t
 org-auto-align-tags t
 org-roam-dailies-capture-templates
 '(("d" "default" entry
    (file "~/Documents/templates/journal_template.org")
    :target (file+head
             "%<%Y-%m-%d>.org" ;; NOTE: needs this exact format as filename to show up in org-agenda
             "#+title:\tDaily Journal: %<%Y-%m-%d>\n#+author:\tEmil Lenz\n#+email:\temillenz@protonmail.com\n#+date:\t\t%<%A, %e %B, %Y>\n"
             ))))
;; Roam:1 ends here

;; [[file:config.org::*Faces][Faces:1]]
(custom-set-faces!
  '(org-todo               :weight bold   :height 1.0)
  '(org-checkbox           :weight bold   :height 1.0)
  '(org-priority           :weight bold   :height 1.0)
  '(org-document-title     :weight bold   :height 1.2)
  '(outline-1              :weight bold   :height 1.3)
  '(outline-2              :weight bold   :height 1.2)
  '(outline-3              :weight bold   :height 1.1)
  '(outline-4              :weight normal :height 1.0)
  '(outline-5              :weight normal :height 1.0)
  '(outline-6              :weight normal :height 1.0)
  '(outline-8              :weight normal :height 1.0)
  '(org-special-keyword    :weight normal :height 1.0)
  '(org-tag                :weight bold)
  '(markdown-header-face-1 :inherit outline-1)
  '(markdown-header-face-2 :inherit outline-2)
  '(markdown-header-face-3 :inherit outline-3)
  '(markdown-header-face-4 :inherit outline-4)
  '(markdown-header-face-5 :inherit outline-5)
  '(markdown-header-face-6 :inherit outline-6)
  '(markdown-header-face-7 :inherit outline-7)
  '(markdown-header-face-8 :inherit outline-8))
;; Faces:1 ends here

;; [[file:config.org::*Personal tags (TODO: custmize)][Personal tags (TODO: custmize):1]]
(setq org-tag-persistent-alist
      '(
        ("ep "   . ?e)
        ("la"   . ?l)
        ("ad"    . ?a)
        ("dm"    . ?d)
        ("personal" . ?p)
        ))
;; Personal tags (TODO: custmize):1 ends here

;; [[file:config.org::*Insert date][Insert date:1]]
(defun z/insert-todays-date ()
  "Insert todays date (text or data format)."
  (interactive)
  (let ((char (read-char-choice "Date format: [t] text | [d] data " '(?t ?d))))
    (let ((fstring (cond
                    ((equal char ?t) "%A, %B %d, %Y")
                    ((equal char ?d) "%Y-%m-%d"))))
      (insert (format-time-string fstring)))))

(defun z/insert-any-date (date)
  "Insert DATE using the current locale."
  (interactive (list (calendar-read-date)))
  (insert (calendar-date-string date)))
;; Insert date:1 ends here

;; [[file:config.org::*Keywords to downcase][Keywords to downcase:1]]
(defun z/org-convert-keywords-downcase ()
  "Convert all #+KEYWORDS => #+keywords && :keyword: => :keyword:"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((case-fold-search nil))
      (while (re-search-forward
              "^[ \t]*#\\+[A-Z_]*" nil t)
        (replace-match
         (downcase (match-string 0)) t)))))
;; Keywords to downcase:1 ends here

;; [[file:config.org::*Link file][Link file:1]]
(defun z/org-link-file ()
  "Insert a file link."
  (interactive)
  (let ((file (org-link-complete-file)))
    (insert
     (format " [[%s][%s]]" file (replace-regexp-in-string "file:" "" (capitalize (replace-regexp-in-string "[-_.]" " " (file-name-sans-extension (file-name-nondirectory file)))))))))
;; Link file:1 ends here

;; [[file:config.org::*Format org buffer][Format org buffer:1]]
(defun z/org-format-buffer ()
  "Regenerating the text from its internal parsed representation. Quite amazing."
  (interactive)
  (when (y-or-n-p "Really format current buffer? ")
    (let ((document (org-element-interpret-data (org-element-parse-buffer))))
      (erase-buffer)
      (insert document)
      (goto-char (point-min)))))
;; Format org buffer:1 ends here

;; [[file:config.org::*Jump to src file][Jump to src file:1]]
(defun z/jump-src ()
   "The opposite of `org-babel-tangle-jump-to-org'.
Jumps at tangled code from org src block."
   (interactive)
   (basic-save-buffer)
   (org-babel-tangle)
   (if (org-in-src-block-p)
       (let*
           ((header (car
                     (org-babel-tangle-single-block
                      1
                      'only-this-block)))
            (tangle (car header))
            (lang (caadr header))
            (buffer (nth 2 (cadr header)))
            (org-id (nth 3 (cadr header)))
            (source-name (nth 4 (cadr header)))
            (search-comment (org-fill-template
                             org-babel-tangle-comment-format-beg
                             `(("link" . ,org-id)
                               ("source-name" . ,source-name))))
            (file (expand-file-name
                   (org-babel-effective-tangled-filename
                    buffer
                    lang
                    tangle))))
         (if (not (file-exists-p file))
             (message "File does not exist. 'org-babel-tangle' first to create file.")
           (find-file file)
           (goto-char (point-min))
           (search-forward search-comment)))
     (message "Cannot jump to tangled file because point is not at org src block.")))
;; Jump to src file:1 ends here

;; [[file:config.org::*Jump to src file][Jump to src file:2]]
)
;; Jump to src file:2 ends here

;; [[file:config.org::*Capture templates][Capture templates:1]]
;; NOTE: files are relative to org-dir
(setq +org-capture-todo-file     "todo.org"
      +org-capture-notes-file    "notes.org"
      +org-capture-journal-file  "journal.org"
      +org-capture-events-file   "events.org"
      +org-capture-projects-file "projects.org"
      org-capture-templates
      '(("p" "personal")
        ("pt" "TODO :personal" entry
         (file+headline +org-capture-todo-file "Inbox")
         "* [ ] %^{task} %^G\nSCHEDULED: %^t\n%?"
         :prepend t
         :empty-lines-after 1
         :clock-keep t)
        ("pn" "NOTE :personal" entry
         (file+headline +org-capture-notes-file "Inbox")
         "* %^{title} %^G\n:PROPERTIES:\n:CREATED: %U\n:END:\n%?"
         :prepend t
         :empty-lines-after 1
         :clock-keep t)
        ("pe" "EVENT :personal" entry
         (file+headline +org-capture-events-file "Inbox")
         "* %^{event} %^G\n%^t\nLOCATION: %^{Location}\nMATERIAL: %^{Material}\n%?"
         :prepend t
         :empty-lines-after 1
         :clock-keep t
         )
        ("pj" "JOURNAL :personal" entry
         (file+olp+datetree +org-capture-journal-file)
         "* %U\n%[~/Documents/templates/journal_template.org]"
         :prepend t
         :empty-lines-after 1
         :clock-keep t)

        ("c" "computerscience")
        ("ct" "TODO :cs" entry
         (file+headline "~/Documents/org/cs_todo.org" "Inbox")
         "* [ ] %^{task} %^G\nSCHEDULED: %^t\n%?"
         :prepend t
         :empty-lines-after 1
         :clock-keep t)
        ("cn" "NOTE :cs" entry
         (file+headline "~/Documents/org/cs_notes.org" "Inbox")
         "* %^{title} %^G\n:PROPERTIES:\n:CREATED: %U\n:END:\n%?"
         :prepend t
         :empty-lines-after 1
         :clock-keep t)
        ))
;; Capture templates:1 ends here

;; [[file:config.org::*Programming mode][Programming mode:1]]
(add-hook! 'prog-mode-hook
           #'rainbow-mode
           #'rainbow-delimiters-mode)

;; NOTE: add hook AFTER entering prog-mode
(add-hook! 'prog-mode-hook
  (lambda () (add-hook! 'before-save-hook #'+format/region-or-buffer)))
;; Programming mode:1 ends here

;; [[file:config.org::*Indentation: 2 spaces][Indentation: 2 spaces:1]]
(advice-add #'doom-highlight-non-default-indentation-h :override #'ignore) ;; turn off whitespace highlighting
(setq
 org-indent-indentation-per-level 2
 evil-shift-width 2
 standard-indent 2
 tab-width 2
 evil-indent-convert-tabs t
 indent-tabs-mode nil
 )

(setq-hook! 'prog-mode-hook
  org-indent-indentation-per-level 2
  evil-shift-width 2
  standard-indent 2
  tab-width 2
  evil-indent-convert-tabs t
  indent-tabs-mode nil
  )

(setq-hook! 'python-mode-hook
  python-indent 2
  python-indent-offset 2)

(setq-hook! 'rustic-mode-hook
  rustic-indent 2
  rustic-indent-offset 2)

(setq-hook! 'nushell-mode-hook
  nushell-indent-offset 2)

(setq-hook! 'c-mode-hook
  c-basic-offset 2)

(setq-hook! 'lisp-mode-hook
  lisp-body-indent 2
  lisp-indent-offset 2)
;; Indentation: 2 spaces:1 ends here

;; [[file:config.org::*Format buffer][Format buffer:1]]
(defun z/clean-whitespace ()
  "Deletes consecutive empty lines if > 1."
  (interactive)
  (delete-trailing-whitespace)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\n\n+" nil t)
      (replace-match "\n\n"))))
;; Format buffer:1 ends here

;; [[file:config.org::*Nushell][Nushell:1]]
(load! "user/nushell-mode.el")
;; Nushell:1 ends here
