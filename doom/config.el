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

 consult-async-min-input 0
 which-key-idle-delay 1
 which-key-allow-multiple-replacements t
 hscroll-margin 0
 scroll-margin 0
 enable-recursive-minibuffers nil
 highlight-indent-guides-responsive  t
 display-line-numbers-type 'visual)

(setq-default major-mode 'org-mode)

(save-place-mode 1)
(+global-word-wrap-mode 1)
(global-subword-mode 1)

(tab-bar-mode 1)
(setq tab-bar-tab-hints t
      tab-bar-new-button-show nil
      tab-bar-new-tab-to 'rightmost
      tab-bar-close-button-show nil)
;; Misc Options:1 ends here

;; [[file:config.org::*Window layout & behavior][Window layout & behavior:1]]
(setq
 evil-vsplit-window-right t
 even-window-sizes 'width-only
 window-combination-resize t
 split-height-threshold nil
 split-width-threshold 0)

(after! org
  (setq org-src-window-setup 'current-window)
  (set-popup-rule! "^\\*Org Src" :ignore t)) ;; HACK: fullscreen window

(after! doom
  (setq-default
   +popup-defaults
   '(:side right
     :width 0.33
     :select nil
     :quit nil
     :modeline t)))

(after! helpful
  (set-popup-rule! ".*help.*" :ignore t)) ;; HACK: use defautls

(after! lsp-mode
  (set-popup-rule! ".*help.*" :ignore t)) ;; HACK: use defautls
;; Window layout & behavior:1 ends here

;; [[file:config.org::*Window layout & behavior][Window layout & behavior:2]]
;; NOTE: not prog mode -> breaks with flychecking
(add-hook!
 '(text-mode-hook
   dired-mode-hook
   org-agenda-mode-hook
   magit-mode-hook)
 #'visual-fill-column-mode)

(global-display-fill-column-indicator-mode -1) ;; distracting
(setq
 visual-fill-column-enable-sensible-window-split t
 visual-fill-column-center-text t
 visual-fill-column-width 100)
(setq-default fill-column 100)
;; Window layout & behavior:2 ends here

;; [[file:config.org::*Leader][Leader:1]]
(setq
 doom-leader-key "SPC"
 doom-leader-alt-key "M-SPC"
 doom-localleader-key ","
 doom-leader-alt-key "M-,")

(map! :leader
      "t" nil
      "u" doom-leader-toggle-map ;; HACK: remap toggle -> ui (more sensible)
      (:prefix ("u" . "ui")
               "V" #'visual-fill-column-mode
               "C" #'company-mode)
      (:prefix ("c" . "code")
               "w" #'z/clean-whitespace))

(after! evil-org
  (map! :localleader
        :map org-mode-map
        (:prefix ("c" . "code")
                 "d" #'org-babel-detangle
                 "J" #'org-babel-tangle-jump-to-org
                 "j" #'z/jump-src
                 "t" #'org-babel-tangle
                 "e" #'org-edit-special)))
;; Leader:1 ends here

;; [[file:config.org::*Global navigation scheme][Global navigation scheme:1]]
(after! doom
  (map! :map  'override
        :nvim "M-j"     #'previous-window-any-frame
        :nvim "M-k"     #'next-window-any-frame
        :nvim "M-t"     #'tab-bar-new-tab-to
        :nvim "M-q"     (cmd! (if (buffer-modified-p) (ignore-errors (evil-write nil nil))) (kill-current-buffer) (tab-bar-close-tab))
        :nvim "M-Q"     #'save-buffers-kill-terminal
        :nvmi "M-z"     #'+popup/toggle
        :nvim "M-1"     (cmd! (tab-bar-select-tab 1))
        :nvim "M-2"     (cmd! (tab-bar-select-tab 2))
        :nvim "M-3"     (cmd! (tab-bar-select-tab 3))
        :nvim "M-4"     (cmd! (tab-bar-select-tab 4))
        :nvim "M-5"     (cmd! (tab-bar-select-tab 5))
        :nvim "M-6"     (cmd! (tab-bar-select-tab 6))
        :nvim "M-7"     (cmd! (tab-bar-select-tab 7))
        :nvim "M-8"     (cmd! (tab-bar-select-tab 8))
        :nvim "M-9"     (cmd! (tab-bar-select-tab 9))
        :nvim "M-o"     #'find-file
        :nvim "M-f"     #'consult-find
        :nvim "M-F"     (cmd! (consult-find "~"))
        :nvim "M-g"     #'consult-buffer
        :nvim "M-r"     #'consult-recent-file
        :nvim "M-c"     #'shell-command
        :nvim "M-;"     #'execute-extended-command
        :nvim "M-'"     #'consult-bookmark

        :nvim "C--"     #'doom/decrease-font-size
        :nvim "C-="     #'doom/increase-font-size
        :nvim "C-0"     #'doom/reset-font-size))
;; Global navigation scheme:1 ends here

;; [[file:config.org::*Global navigation scheme][Global navigation scheme:2]]
(defadvice! z/newtab (fn &rest args)
  "Open new file-buffers in a new tab."
  :before '(find-file bookmark-jump magit-status)
  (tab-bar-new-tab-to))
;; Global navigation scheme:2 ends here

;; [[file:config.org::*Evil-mode][Evil-mode:1]]
(after! evil
  ;; HACK disable all default-maps (mappings used -> below)
  (add-hook 'evil-mode-hook #'evil-cleverparens-mode)
  (setq evil-cleverparens-use-s-and-S nil
        evil-cleverparens-use-additional-bindings nil
        evil-cleverparens-use-additional-movement-keys nil)
  (map!
   :nmvo "j"   #'evil-next-visual-line
   :nmvo "k"   #'evil-previous-visual-line

   :nm   "TAB" #'+fold/toggle ;; inspired bby org-modes folding

   :nmv  "U"   #'evil-redo
   :nmv  "Q"   #'evil-execute-last-recorded-macro
   :nmv  "&"   #'evil-ex-repeat

   :nmv  "]e"  #'flycheck-next-error
   :nmv  "[e"  #'flycheck-previous-error

   :nmv  "("   #'evil-cp-backward-up-sexp
   :nmv  ")"   #'evil-cp-up-sexp

   :nmv  "+"   #'evil-numbers/inc-at-pt
   :nmv  "-"   #'evil-numbers/dec-at-pt
   :nmv  "g+"  #'evil-numbers/inc-at-pt-incremental
   :nmv  "g-"  #'evil-numbers/dec-at-pt-incremental

   :nmv  "go"  #'consult-imenu
   :nmv  "g/"  #'+default/search-buffer))
;; Evil-mode:1 ends here

;; [[file:config.org::*Control-bindings][Control-bindings:1]]
(after! evil
  (map!
   :inmv "C-s" #'evil-write
   :inmv "C-j" #'drag-stuff-down
   :inmv "C-k" #'drag-stuff-up))
;; Control-bindings:1 ends here

;; [[file:config.org::*Instant jumping][Instant jumping:1]]
(after! evil
  (map! :map evil-snipe-local-mode-map ;; HACK: need to override evil-snipe
        :nmvo "s" #'evil-avy-goto-char-2-below
        :nmvo "S" #'evil-avy-goto-char-2-above))
;; Instant jumping:1 ends here

;; [[file:config.org::*Evil surround operator][Evil surround operator:1]]
(after! evil
  (map! :map evil-operator-state-map
        "`" #'evil-surround-edit)
  (map!
   :nmv "`" #'evil-surround-region
   :nmv "`" #'evil-surround-region))
;; Evil surround operator:1 ends here

;; [[file:config.org::*Alignment][Alignment:1]]
(after! evil
  (map!
   :nmv "g<" #'evil-lion-left
   :nmv "g>" #'evil-lion-right))
;; Alignment:1 ends here

;; [[file:config.org::*Org mode][Org mode:1]]
(after! evil-org
  (map! :map evil-org-mode-map
        :nmv "]]"     #'org-forward-heading-same-level
        :nmv "[["     #'org-backward-heading-same-level
        :inmv "S-RET" #'org-meta-return
        :inmv "C-RET" #'+org/insert-item-below
        :inmv "C-j"   #'org-metadown
        :inmv "C-k"   #'org-metaup
        :inmv "C-h"   #'org-metaleft
        :inmv "C-l"   #'org-metaright))

(after! org-mode
  (map! :localleader
        "l f"  #'z/org-link-file))
;; Org mode:1 ends here

;; [[file:config.org::*Dired][Dired:1]]
(after! dired
  (map! :map dired-mode-map
        :nm "h" #'dired-up-directory
        :nm "l" #'dired-open-file
        :nm "f" #'dired-goto-file
        :nm "c" #'dired-do-copy
        :nm "C" #'dired-do-compress
        :nm "r" #'dired-do-rename
        :nm "R" #'dired-do-redisplay
        :nm "d" #'dired-do-delete
        :nm "x" #'dired-do-chmod
        :nm "s" #'dired-sort-toggle-or-edit
        :nm "o" #'find-file
        :nm "p" #'dired-do-print
        :nm "y" #'dired-copy-filename-as-kill
        :nm "z" #'dired-do-compress
        :nm "." #'dired-omit-mode
        :nm "e" #'dired-create-empty-file
        :nm "E" #'dired-create-directory)

  (map! :localleader
        :map dired-mode-map
        :nm "A" #'z/dired-archive))
;; Dired:1 ends here

;; [[file:config.org::*Minibuffer][Minibuffer:1]]
(map! :map vertico-map
      :nmi "M-g" #'consult-dir)
;; Minibuffer:1 ends here

;; [[file:config.org::*Evil mode][Evil mode:1]]
(after! evil
  (evil-surround-mode 1)

  (setq
   evil-magic 'very-magic
   evil-want-fine-undo nil
   evil-ex-substitute-global t
   evil-move-cursor-back t
   evil-move-beyond-eol nil
   evil-kill-on-visual-paste nil
   evil-want-C-i-jump t
   evil-want-minibuffer t)

  (setq
   evil-snipe-scope 'visible
   evil-snipe-repeat-keys t
   evil-snipe-override-evil-repeat-keys t
   evil-snipe-auto-scroll nil)

  (dolist (cmd
           '(flycheck-next-error
             flycheck-previous-error
             +lookup/definition
             +lookup/references
             +lookup/implementations))
    (evil-add-command-properties cmd :jump t)))
;; Evil mode:1 ends here

;; [[file:config.org::*Lsp & completion][Lsp & completion:1]]
(after! company
  (setq
   company-minimum-prefix-length 1
   company-idle-delay 0.1 ;; NOTE: don't set to 0
   company-show-quick-access t
   company-global-modes
   '(not
     erc-mode
     message-mode
     help-mode
     gud-mode
     vterm-mode)))
;; Lsp & completion:1 ends here

;; [[file:config.org::*Templates & snippets][Templates & snippets:1]]
(setq yas-triggers-in-field t)

(set-file-templates!
 '(org-mode :trigger "header")
 '(prog-mode :trigger "header"))
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
          ("pdf"  . "zathura")))

  (add-hook! 'dired-mode-hook #'dired-hide-details-mode)

  (setq
   dired-recursive-copies 'always
   dired-recursive-deletes 'top
   global-auto-revert-non-file-buffers t
   dired-kill-when-opening-new-dired-buffer t))
;; Dired Mode:1 ends here

;; [[file:config.org::*Archive file][Archive file:1]]
(defun z/dired-archive ()
  (interactive)
  (dolist (file (dired-get-marked-files))
    (let* ((file (dired-get-filename))
           (dest (concat "~/Archive/" (file-relative-name file "~/"))))
      (rename-file file dest 1)))) ;; NOTE: "1": propt before overwrite
;; Archive file:1 ends here

;; [[file:config.org::*\[begin\]][[begin]:1]]
(after! org
;; [begin]:1 ends here

;; [[file:config.org::*Options][Options:1]]
(add-hook! 'org-mode-hook
           #'visual-line-mode
           #'org-num-mode
           #'org-appear-mode
           #'org-auto-tangle-mode)

(setq
 org-directory "~/Documents/org"
 org-archive-location "~/Archive/org/%s::" ;; NOTE: archive based on file path
 org-blank-before-new-entry '((heading . t)
                              (plain-list-item . nil))
 org-use-property-inheritance t
 org-reverse-note-order t
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
 '((?-  . "─")
   (?* . "─") ;; NOTE: never use these, asteriks are for headings only -> no unambigiuity
   (?+ . "→")))
;; Symbols:1 ends here

;; [[file:config.org::*Ligatures][Ligatures:1]]
(setq-default prettify-symbols-alist
              '(("->" . "→")
                ("|" . "│")
                ("=>" . "⇒")
                ("<=>" . "⇔")))
;; Ligatures:1 ends here

;; [[file:config.org::*Task states][Task states:1]]
(setq org-todo-keywords
      '((type
         "[#](#)"
         "[ ](t)" ;; HACK: cannot use " " -> [T]odo
         "[?](?!)"
         "[-](-@)"
         "[=](=@)"
         "[&](&@)"
         "|"
         "[x](x!)"
         "[@](d@)" ;; HACK: cannot use"@" -> [D]elegated
         "[\\](\\@)")))
;; Task states:1 ends here

;; [[file:config.org::*Task states][Task states:2]]
(setq org-todo-keyword-faces
      '(("[#]"  . +org-todo-project)
        ("[ ]"  . +org-todo-cancel)
        ("[-]"  . +org-todo-onhold)
        ("[?]"  . org-todo)
        ("[=]"  . org-todo)
        ("[&]"  . org-todo)
        ("[@]"  . +org-todo-active)
        ("[\\]" . org-done)
        ("[X]"  . org-done)))
;; Task states:2 ends here

;; [[file:config.org::*Task states][Task states:3]]
(setq
 org-log-done 'time
 org-log-repeat 'time
 org-todo-repeat-to-state t
 org-log-redeadline 'note
 org-log-reschedule 'time
 org-log-into-drawer "LOG")

(setq
 org-priority-highest 1
 org-priority-lowest 3
 org-priority-faces
 '((?1  . 'all-the-icons-red)
   (?2 . 'all-the-icons-orange)
   (?3 . 'all-the-icons-yellow)))
;; Task states:3 ends here

;; [[file:config.org::*Babel][Babel:1]]
(setq
 org-babel-default-header-args
 '((:session  . "none")
   (:results  . "replace")
   (:exports  . "code")
   (:cache    . "no")
   (:noweb    . "no")
   (:hlines   . "no")
   (:tangle   . "no")
   (:mkdirp   . "yes")
   (:comments . "link")))
;; Babel:1 ends here

;; [[file:config.org::*Agenda][Agenda:1]]
(add-hook! 'org-agenda-mode-hook #'org-super-agenda-mode)

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
 org-capture-use-agenda-date t)
;; Agenda:1 ends here

;; [[file:config.org::*Agenda][Agenda:2]]
(setq
 org-agenda-scheduled-leaders '("─────" "←%3dd")
 org-agenda-deadline-leaders '("━━━━━" "⇒%3dd" "⇐%3dd")
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
  (let* ((file (org-link-complete-file))
        (title (replace-regexp-in-string "file:" "" (capitalize (replace-regexp-in-string "[-_.]" " " (file-name-sans-extension (file-name-nondirectory file)))))))
    (insert
     (format " [[%s][%s]]"
      file
      title))))
;; Link file:1 ends here

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

;; [[file:config.org::*Capture templates][Capture templates:1]]
(setq
 org-capture-templates
 (doct
  '((:group "default-opts"
     :headline "inbox"
     :prepend t
     :clock-keep t

     :children
     (("task" :keys "t"
       :template
       ("* [ ] %^{title} %^g"
        "%?") ;; NOTE: not putting final insert on newline => tasks are a list and not paragraph
       :children
       (("cs"   :keys "c" :file "cs/tasks.org"
         :children
         (("la" :keys "l" :olp ("linear algebra" "inbox"))
          ("ep" :keys "e" :olp ("einfuehrung programmierung" "inbox"))
          ("dm" :keys "d" :olp ("discrete math" "inbox"))
          ("ad" :keys "a" :olp ("algorithms & datastructures" "inbox"))))
        ("personal" :keys "p" :file "personal/tasks.org")
        ("compass"  :keys "s" :file "compass/tasks.org")
        ("config"   :keys "o" :file "config/tasks.org")))

      ("event" :keys "e"
       :template
       ("* [#] %^{title} %^g"
        "%^t"
        "LOCATION: %^{location}"
        "PRE: %^{pre}"
        "%?")
       :children
       (("cs"       :keys "c" :file "cs/events.org")
        ("personal" :keys "p" :file "personal/events.org")))

      ("note" :keys "n"
       :template
       ("* %^{title} %^g"
        ":PROPERTIES:"
        ":CREATED: %U"
        ":END:"
        "%?")
       :children
       (("cs"       :keys "c"
         :children
         (("la" :keys "l" :file "cs/la/notes.org")
          ("ep" :keys "e" :file "cs/ep/notes.org")
          ("dm" :keys "d" :file "cs/dm/notes.org")
          ("ad" :keys "a" :file "cs/ad/notes.org")))
        ("personal" :keys "p" :file "personal/notes.org")
        ("compass"  :keys "s" :file "compass/notes.org")
        ("config"   :keys "o" :file "config/notes.org")))

      ("journal" :keys "j"
       :template
       ("* %^{title} %^g"
        ":PROPERTIES:"
        ":CREATED: %U"
        ":END:"
        "%?")
       :children ("personal" :keys "p" :file "personal/journal.org")))))))
;; Capture templates:1 ends here

;; [[file:config.org::*\[End\]][[End]:1]]
)
;; [End]:1 ends here

;; [[file:config.org::*Programming mode][Programming mode:1]]
(add-hook! 'prog-mode-hook
           #'rainbow-mode
           #'rainbow-delimiters-mode)
;; Programming mode:1 ends here

;; [[file:config.org::*Indentation: 2 spaces][Indentation: 2 spaces:1]]
(advice-add #'doom-highlight-non-default-indentation-h :override #'ignore) ;; turn off whitespace highlighting
(setq
 tab-always-indent t
 org-indent-indentation-per-level 2
 evil-shift-width 2
 standard-indent 2
 tab-width 2
 evil-indent-convert-tabs t
 indent-tabs-mode nil)
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

;; [[file:config.org::*Command-line: nushell][Command-line: nushell:1]]
(load! "user/nushell-mode.el")
;; Command-line: nushell:1 ends here

;; [[file:config.org::*Command-line: nushell][Command-line: nushell:2]]
(setq shell-command-prompt-show-cwd t)
;; Command-line: nushell:2 ends here
