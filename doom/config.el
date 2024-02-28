;; [[file:config.org::*user][user:1]]
(setq user-full-name "emil lenz"
      user-mail-address "emillenz@protonmail.com")
;; user:1 ends here

;; [[file:config.org::*modus-theme][modus-theme:1]]
(use-package! modus-themes
  :config
  (setq
   modus-themes-mixed-fonts t
   modus-themes-italic-constructs t
   modus-themes-bold-constructs t
   modus-themes-org-blocks 'gray-background)

  (setq modus-themes-common-palette-overrides
        `((fg-region unspecified) ;; NOTE :: don't override syntax highlighting in region

          (bg-tab-bar bg-main)
          (bg-tab-other bg-inactive)
          (bg-tab-current bg-completion)

          (fg-heading-1 fg-heading-0)))

  ;; HACK :: cannot customize these things with `modus-themes-common-palette-overrides'
  (modus-themes-with-colors
    (setq
     evil-insert-state-cursor `(,fg-main bar)
     evil-normal-state-cursor `(,fg-main box)
     evil-motion-state-cursor `(,fg-main box)
     evil-visual-state-cursor `(,yellow box)
     evil-operator-state-cursor `(,red box)
     evil-replace-state-cursor `(,red hbar)))

  (custom-set-faces!
    `(org-list-dt :inherit modus-themes-heading-1)
    `(org-block-begin-line :foreground ,(modus-themes-get-color-value 'prose-metadata))
    `(org-quote :slant italic))
  (setq doom-theme 'modus-vivendi))
;; modus-theme:1 ends here

;; [[file:config.org::*font][font:1]]
(setq doom-font                (font-spec :family "Iosevka Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font" :size 14)
      doom-serif-font          (font-spec :family "Iosevka Nerd Font" :size 14)
      doom-big-font            (font-spec :family "Iosevka Nerd Font" :size 24))

(custom-set-faces!
  '(font-lock-keyword-face :slant normal :weight bold)
  '(font-lock-type-face    :slant normal)
  '(font-lock-comment-face :slant italic)
  '(font-lock-string-face  :slant italic))
;; font:1 ends here

;; [[file:config.org::*modeline][modeline:1]]
(setq display-battery-mode nil
      display-time-mode nil
      doom-modeline-height 15
      doom-modeline-bar-width 5
      doom-modeline-enable-word-count t
      doom-modeline-persp-name t
      doom-modeline-major-mode-icon t)
;; modeline:1 ends here

;; [[file:config.org::*window layout & behavior][window layout & behavior:1]]
(setq evil-vsplit-window-right t
      even-window-sizes 'width-only
      window-combination-resize t
      split-height-threshold nil
      split-width-threshold 0)

(setq +popup-defaults
      '(:side right
        :select nil
        :quit nil
        :width 0.33
        :modeline nil))

(after! org
  (setq org-src-window-setup 'current-window)
  (set-popup-rule! "^\\*Org Src" :ignore t))

(set-popup-rules! `(("^\\*info" :ignore t)
                    ("^\\*helpful" :quit t)))

(after! lsp-mode
  (set-popup-rules! `(("^\\*lsp-help\\*" :side bottom :quit t))))
;; window layout & behavior:1 ends here

;; [[file:config.org::*window layout & behavior][window layout & behavior:2]]
(add-hook! '(text-mode-hook
             ;; prog-mode-hook ;; NOTE :: no-use, breaks with flycheck
             dired-mode-hook
             conf-mode-hook
             Info-mode-hook
             org-agenda-mode-hook
             magit-mode-hook)
           #'visual-fill-column-mode)

(global-display-fill-column-indicator-mode 0)

(setq visual-fill-column-enable-sensible-window-split t
      visual-fill-column-center-text t
      visual-fill-column-width 100
      fill-column 100)
;; window layout & behavior:2 ends here

;; [[file:config.org::*tabs][tabs:1]]
(tab-bar-mode 1)
(setq tab-bar-tab-hints t
      tab-bar-new-button-show nil
      tab-bar-new-tab-to 'rightmost
      tab-bar-close-button-show nil)
;; tabs:1 ends here

;; [[file:config.org::*misc options][misc options:1]]
(setq bookmark-default-file "~/.config/doom/bookmarks"
      delete-by-moving-to-trash t
      truncate-string-ellipsis "…"
      auto-save-default t
      confirm-kill-emacs nil
      undo-limit 80000000
      history-length 1000
      consult-async-min-input 0
      hscroll-margin 0
      scroll-margin 0
      enable-recursive-minibuffers t
      display-line-numbers-type 'visual
      shell-command-prompt-show-cwd t)

(save-place-mode 1)
(+global-word-wrap-mode 1)
(global-subword-mode 1)

(setq calc-angle-mode 'rad
      calc-symbolic-mode t)
;; misc options:1 ends here

;; [[file:config.org::*leader][leader:1]]
(setq doom-leader-key "SPC"
      doom-leader-alt-key "M-SPC"
      doom-localleader-key ","
      doom-leader-alt-key "M-,")

(map! :leader
      (:prefix "t"
               "V" #'visual-fill-column-mode
               "C" #'company-mode)
      (:prefix "c"
               "w" #'clean_whitespace)

      (:prefix "o"
               "c" #'eshell)
      (:prefix "s"
               (:prefix-map ("t" . "dictionary")
                            "d" #'+lookup/dictionary-definition
                            "s" #'+lookup/synonyms
                            "w" #'ispell-word
                            "t" #'dictionary-search)))
;; leader:1 ends here

;; [[file:config.org::*global navigation scheme][global navigation scheme:1]]
(map! :map 'override
      :inmv "M-j"   #'previous-window-any-frame
      :inmv "M-k"   #'next-window-any-frame
      :inmv "M-t"   #'tab-bar-new-tab-to
      :inmv "M-q"   #'evil-quit
      :inmv "M-1"   (cmd! (tab-bar-select-tab 1))
      :inmv "M-2"   (cmd! (tab-bar-select-tab 2))
      :inmv "M-3"   (cmd! (tab-bar-select-tab 3))
      :inmv "M-4"   (cmd! (tab-bar-select-tab 4))
      :inmv "M-o"   #'find-file
      :inmv "M-f"   #'consult-find
      :inmv "M-F"   (cmd! (consult-find "~"))
      :inmv "M-g"   #'consult-buffer
      :inmv "M-r"   #'consult-recent-file
      :inmv "M-c"   #'async-shell-command
      :inmv "M-w"   #'+lookup/online
      :inmv "M-;"   #'execute-extended-command
      :inmv "M-'"   #'consult-bookmark

      :inmv "C--"   #'doom/decrease-font-size
      :inmv "C-="   #'doom/increase-font-size
      :inmv "C-0"   #'doom/reset-font-size)
;; global navigation scheme:1 ends here

;; [[file:config.org::*global navigation scheme][global navigation scheme:2]]
(defadvice! evil_quit (&optional force)
  "Close current tab before closing current frame (more sensible)."
  :override #'evil-quit
  (condition-case nil
      (evil-window-delete)
    (error
     (if (and (bound-and-true-p server-buffer-clients)
              (fboundp 'server-edit)
              (fboundp 'server-buffer-done))
         (if force
             (server-buffer-done (current-buffer))
           (server-edit))
       (condition-case nil
           (delete-frame)
         (error
          (if force
              (kill-emacs)
            (save-buffers-kill-emacs))))))))
;; global navigation scheme:2 ends here

;; [[file:config.org::*evil][evil:1]]
(map! :nmvo "j"   #'evil-next-visual-line
      :nmvo "k"   #'evil-previous-visual-line

      :nm   "TAB" #'+fold/toggle

      :nmv  "("   #'sp-beginning-of-sexp
      :nmv  ")"   #'sp-end-of-sexp

      :nmv  "U"   #'evil-redo
      :nmv  "Q"   #'evil-execute-last-recorded-macro
      :nmv  "&"   #'evil-ex-repeat
      :nm   "M"   (cmd! (evil-set-jump))

      :nmv  "+"   #'evil-numbers/inc-at-pt
      :nmv  "-"   #'evil-numbers/dec-at-pt
      :nmv  "g+"  #'evil-numbers/inc-at-pt-incremental
      :nmv  "g-"  #'evil-numbers/dec-at-pt-incremental

      :nmv  "go"  #'consult-imenu
      :nmv  "g/"  #'+default/search-buffer)

(map! :nm "C-j" #'evil-forward-section-end
      :nm "C-k" #'evil-backward-section-begin
      :nm "C-l" #'recenter-top-bottom)

(map! :after org :map evil-org-mode-map
      :nmv "C-j"  #'org-forward-element
      :nmv "C-k"  #'org-backward-element)
;; evil:1 ends here

;; [[file:config.org::*evil][evil:2]]
(defadvice! update_evil_search_reg ()
  "Update evil search register after jumping to a line with
  `+default/search-buffer' to be able to jump to next/prev matches.
This is sensible default behaviour, and integrates it into evil."
  :after #'+default/search-buffer
  (let ((str (string-replace
              " " ".*"
              (car consult--line-history))))
    (push str evil-ex-search-history)
    (setq evil-ex-search-pattern (list str t t))))
;; evil:2 ends here

;; [[file:config.org::*Instant jumping][Instant jumping:1]]
(map! :map evil-snipe-local-mode-map ;; HACK :: need to override evil-snipe
      :nmvo "s" #'evil-avy-goto-char-2-below
      :nmvo "S" #'evil-avy-goto-char-2-above)
;; Instant jumping:1 ends here

;; [[file:config.org::*Evil surround operator][Evil surround operator:1]]
(map! :map evil-operator-state-map
      "`" #'evil-surround-edit)

(map! :nmv "`" #'evil-surround-region
      :nmv "`" #'evil-surround-region)
;; Evil surround operator:1 ends here

;; [[file:config.org::*Alignment][Alignment:1]]
(map! :nmv "g<" #'evil-lion-left
      :nmv "g>" #'evil-lion-right)
;; Alignment:1 ends here

;; [[file:config.org::*org][org:1]]
(map! :localleader :map org-mode-map
      "\\" #'org-latex-preview
      ","  #'org-ctrl-c-ctrl-c
      (:prefix-map ("`" . "org-src")
                   "`" #'org-edit-special
                   "g" #'org_goto_src
                   "t" #'org-babel-tangle))
;; org:1 ends here

;; [[file:config.org::*dired (keybindings)][dired (keybindings):1]]
(map! :map dired-mode-map :after dired
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

(map! :map dired-mode-map :localleader :after dired
      :nm "a" #'dired_archive)
;; dired (keybindings):1 ends here

;; [[file:config.org::*magit][magit:1]]
(map! :map magit-mode-map :after magit
      :nm "C-j" #'magit-section-forward-sibling
      :nm "C-k" #'magit-section-backward-sibling)
;; magit:1 ends here

;; [[file:config.org::*info][info:1]]
(map! :map Info-mode-map :after Info-mode
      :nm "C-j" #'Info-forward-node
      :nm "C-k" #'Info-backward-node)
;; info:1 ends here

;; [[file:config.org::*editor][editor:1]]
(evil-surround-mode 1)

(setq evil-magic 'very-magic
      evil-want-fine-undo nil
      evil-ex-substitute-global t
      evil-move-cursor-back t
      evil-move-beyond-eol nil
      evil-kill-on-visual-paste nil
      evil-want-C-i-jump t
      evil-want-minibuffer t)

(setq evil-snipe-scope 'visible
      evil-snipe-repeat-keys t
      evil-snipe-override-evil-repeat-keys t
      evil-snipe-auto-scroll nil)
;; editor:1 ends here

;; [[file:config.org::*jump property][jump property:1]]
(dolist (cmd '(flycheck-next-error
               flycheck-previous-error
               +lookup/definition
               +lookup/references
               +lookup/implementations
               +default/search-buffer
               consult-imenu))
  (evil-add-command-properties cmd :jump t))

(dolist (cmd '(evil-backward-section-begin
               evil-jump-item
               evil-backward-paragraph
               evil-forward-paragraph
               evil-forward-section-end))
  (evil-remove-command-properties cmd :jump))
;; jump property:1 ends here

;; [[file:config.org::*lsp & completion][lsp & completion:1]]
(setq company-minimum-prefix-length 1
      company-idle-delay 0.1 ;; NOTE :: setting to 0 => huge lags
      company-tooltip-idle-delay 0.1
      company-show-quick-access t
      company-global-modes '(not
                             help-mode
                             eshell-mode
                             org-mode
                             vterm-mode))
;; lsp & completion:1 ends here

;; [[file:config.org::*templates & snippets][templates & snippets:1]]
(setq yas-triggers-in-field t)
;; templates & snippets:1 ends here

;; [[file:config.org::*dired][dired:1]]
(add-hook! dired-mode-hook #'display-line-numbers-mode)

;; NOTE:: this is the elegant && extensible way to do regex.
(setq dired-omit-files
      (rx (or (seq bol (? ".") "#")
              (seq bol "." (not (any ".")))
              (seq "~" eol)
              (seq bol "CVS" eol))))

(setq dired-open-extensions
      '(("mkv"  . "mpv")
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
        ("pdf"  . "zathura")))

(add-hook! 'dired-mode-hook #'dired-hide-details-mode)

(setq dired-recursive-copies 'always
      dired-recursive-deletes 'top
      global-auto-revert-non-file-buffers t)
;; dired:1 ends here

;; [[file:config.org::*Archive file][Archive file:1]]
(defvar archive_dir "~/Archive/"
  "User's archive directory.")

(defun dired_archive ()
  (interactive)
  (let ((files (dired-get-marked-files nil nil)))
    (dolist (f files)
      (let* ((dest (file-name-concat
                    archive_dir
                    (file-relative-name f "~/")))
             (dir (file-name-directory dest)))
        (unless (file-exists-p dir)
          (make-directory dir t))
        (rename-file f dest 1)))))
;; Archive file:1 ends here

;; [[file:config.org::*programming][programming:1]]
(add-hook! 'prog-mode-hook #'rainbow-delimiters-mode)
;; programming:1 ends here

;; [[file:config.org::*Indentation: 2 spaces][Indentation: 2 spaces:1]]
(advice-add #'doom-highlight-non-default-indentation-h :override #'ignore)

(setq tab-always-indent t
      org-indent-indentation-per-level 2
      evil-shift-width 2
      standard-indent 2
      ;;      tab-width 2
      evil-indent-convert-tabs t
      indent-tabs-mode nil)
;; Indentation: 2 spaces:1 ends here

;; [[file:config.org::*Clean Whitespace][Clean Whitespace:1]]
(defun clean_whitespace ()
  "Deletes consecutive empty lines if > 1, and strips trailing whitespace."
  (interactive)
  (delete-trailing-whitespace)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\n\n+" nil t)
      (replace-match "\n\n")))
  (basic-save-buffer))
;; Clean Whitespace:1 ends here

;; [[file:config.org::*conf-mode][conf-mode:1]]
(add-hook! 'conf-mode-hook #'rainbow-mode)
;; conf-mode:1 ends here

;; [[file:config.org::*options][options:1]]
(add-hook! 'org-mode-hook
           '(visual-line-mode
             org-fragtog-mode
             rainbow-mode
             +org-pretty-mode
             org-appear-mode))

(setq org-directory "~/Documents/org/"
      org-archive-location "~/Archive/org/%s::" ;; NOTE :: archive based on file path
      org-use-property-inheritance t
      org-reverse-note-order t
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
      org-hide-emphasis-markers t)

(setq org-pretty-entities t
      org-pretty-entities-include-sub-superscripts t)

(setq org-list-demote-modify-bullet
      '(("-"  . "-")
        ("+"  . "+")
        ("*"  . "-")
        ("a." . "a)")
        ("1." . "1)")
        ("1)" . "a)")))

(setq org-blank-before-new-entry '((heading         . t)
                                   (plain-list-item . nil)))
;; options:1 ends here

;; [[file:config.org::*symbols][symbols:1]]
(add-hook! 'org-mode-hook '(org-superstar-mode prettify-symbols-mode))

(setq org-superstar-headline-bullets-list
      '("◉" "◯" "▣" "□" "◈" "◇"))

(setq org-superstar-item-bullet-alist
      '((?- . "─")
        (?* . "─") ;; NOTE :: asteriks are reserved for headings only (don't use in lists) => no unambigiuity
        (?+ . "⇒")))

(appendq! +ligatures-extra-symbols
          '(:list_property "∷"
            :em_dash       "—"
            :ellipses      "…"
            :arrow_right   "→"
            :arrow_left    "←"
            :arrow_lr      "↔"
            :properties    "⚙"))

(add-hook! 'org-mode-hook
  (appendq! prettify-symbols-alist
            '(("--"  . "–")
              ("---" . "—")
              ("->" . "→")
              ("=>" . "⇒")
              ("<=>" . "⇔"))))
;; symbols:1 ends here

;; [[file:config.org::*task states][task states:1]]
(after! org
  (setq org-todo-keywords
        '((type
           "[#](#)")
          (sequence
           "[ ](t)" ;; HACK :: cannot use " " => [T]odo
           "[?](?!)"
           "[-](-@)"
           "[=](=@)"
           "[&](&@)"
           "|"
           "[x](x!)"
           "[@](d@)" ;; HACK :: cannot use"@" => [D]elegated
           "[\\](\\@)")))

  (setq org-todo-keyword-faces
        '(("[#]"  . '(bold +org-todo-project))
          ("[ ]"  . '(bold org-todo))
          ("[-]"  . '(bold +org-todo-active))
          ("[?]"  . '(bold +org-todo-onhold))
          ("[=]"  . '(bold +org-todo-onhold))
          ("[&]"  . '(bold +org-todo-onhold))
          ("[@]"  . '(bold +org-todo-onhold))
          ("[\\]" . '(bold org-done))
          ("[x]"  . '(bold org-done)))))
;; task states:1 ends here

;; [[file:config.org::*task states][task states:2]]
(setq org-log-done 'time
      org-log-repeat 'time
      org-todo-repeat-to-state t
      org-log-redeadline 'time
      org-log-reschedule 'time
      org-log-into-drawer "LOG")

(setq org-priority-highest 1
      org-priority-lowest 3)

(setq org-priority-faces
      '((?1 . 'all-the-icons-red)
        (?2 . 'all-the-icons-orange)
        (?3 . 'all-the-icons-yellow)))

(setq org-log-note-headings
      '((done        . "done note: %t")
        (state       . "state: %-3S -> %-3s %t") ;; NOTE :: DON'T change this?; my task-statuses are all 3x wide -> formatting needs adjustment if not in order to align them.
        (note        . "note: %t")
        (reschedule  . "re-schedule: %S, %t")
        (delschedule . "rm-schedule: %S, %t")
        (redeadline  . "re-deadline: %S, %t")
        (deldeadline . "rm-deadline: %S, %t")
        (refile      . "refile: %t")
        (clock-out   . "")))
;; task states:2 ends here

;; [[file:config.org::*babel][babel:1]]
(setq org-babel-default-header-args
      '((:session  . "none")
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
(add-hook! 'org-agenda-mode-hook
           #'org-super-agenda-mode)

(setq org-agenda-files
      (directory-files-recursively org-directory ".*\.org" t)
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

(setq org-agenda-deadline-faces
      '((1.0 . error)
        (1.0 . org-warning)
        (0.5 . org-upcoming-deadline)
        (0.0 . org-upcoming-distant-deadline)))
;; agenda:1 ends here

;; [[file:config.org::*agenda][agenda:2]]
(setq org-agenda-todo-keyword-format "%-3s"
      org-agenda-scheduled-leaders '("─────" "<-%2dd") ;; NOTE :: unicode is not fixed width => breaks formatting => cannot use it.
      org-agenda-deadline-leaders '("━━━━━" "=>%2dd" "<=%2dd")
      org-agenda-prefix-format '((agenda . "%-12c%-6s%-12t")
                                 (todo .   "%-12c%-6s%-12t")
                                 (tags .   "%-12c%-6s%-12t")
                                 (search . "%-12c%-6s%-12t")))
;; agenda:2 ends here

;; [[file:config.org::*clock][clock:1]]
(setq org-clock-out-when-done t
      org-clock-persist t
      org-clock-into-drawer t)
;; clock:1 ends here

;; [[file:config.org::*capture templates][capture templates:1]]
(defvar org_journal_dir (file-name-concat "~/Documents/journal/")
  "directory for daily journal files.")
(defvar org_literature_dir "~/Documents/literature/notes/"
  "directory for literature notes.")
(defvar doct_projects '(("cs" :keys "c"
                         :children (("pp" :keys "p")
                                    ("as1" :keys "a")
                                    ("aw" :keys "w")
                                    ("ddca" :keys "d")
                                    ("asdf" :keys "t")))
                        ("personal" :keys "p")
                        ("config" :keys "f")
                        ("compass" :keys "o"))
  "user projects for capture templates.")

(defun doct_expand_projects (projects target &optional ppath)
  "generate doct preset for project (standardized).

PROJECTS :: all projects with their keys [and children]
TARGET :: the caputure target file tag (notes / agenda)
PPATH :: always omit (used for internal recursive purposes)

This approach to doct ensures all keys for one project use the same prefix and
reduces code repetition."
  (mapcar
   (lambda (proj)
     (let* ((name (car proj))
            (path (file-name-concat ppath name))
            (keys (plist-get (cdr proj) :keys))
            (children (plist-get (cdr proj) :children))
            (file (file-name-concat
                   org-directory
                   path
                   (format "%s.org" target)))
            (self `(,name :keys ,keys :file ,file)))
       (append
        self
        (when children
          `(:children ,(cons self (doct_expand_projects children target path)))))))
   projects))

(defun doct_journal_file (&optional time)
  "filepath for journal.

TIME :: Time of note to return. (default: today)"
  (file-name-concat
   org_journal_dir
   (format
    "%s__journal.org"
    (format-time-string "%F" (or time (current-time))))))

(after! org
  (setq
   org-capture-templates
   (doct
    `(("task" :keys "t"
       :headline "inbox"
       :prepend t :empty-lines-after 1
       :template ("* [ ] %^{title}%? %^g")
       :children ,(doct_expand_projects doct_projects "agenda"))

      ("event" :keys "e"
       :headline "events"
       :prepend t :empty-lines-after 1
       :template ("* [#] %^{title}%? %^g"
                  "%^T"
                  ":PROPERTIES:"
                  ":location: %^{location}"
                  ":material: %^{material}"
                  ":END:")
       :children ,(doct_expand_projects doct_projects "agenda"))

      ("note" :keys "n"
       :prepend t :empty-lines 1
       :template ("* %^{title} %^g"
                  ":PROPERTIES:"
                  ":created: %U"
                  ":END:"
                  "%?")
       :children ,(doct_expand_projects doct_projects "notes"))

      ("journal" :keys "j"
       :file (lambda () (doct_journal_file))
       :children (("begin today" :keys "t"
                   :type plain
                   :template ("#+title:  Daily Note: %<%A, %e. %B %Y>"
                              "#+author: %(user-full-name)"
                              "#+email:  %(message-user-mail-address)"
                              "#+date:   %<%F>"
                              "#+filetags: :journal:"
                              ""
                              "* goals"
                              "- %?"
                              ""
                              "* agenda"
                              "** [ ] "
                              "SCHEDULED: <%<%F %a>>"))
                  ("entry" :keys "e"
                   :empty-lines-before 1
                   :template ("* %^{title}"
                              ":PROPERTIES:"
                              ":created: %U"
                              ":END:"
                              "%?"))

                  ("end yesterday" :keys "y"
                   :empty-lines-before 1
                   :unnarrowed t
                   :file (lambda () (doct_journal_file (time-subtract
                                                        (current-time)
                                                        (days-to-time 1))))
                   :template ("* gratitude"
                              "- %?"
                              ""
                              "* reflection"
                              "-"))))

      ("literature" :keys "l"
       :file (lambda () (read-file-name "file: " org_literature_dir))
       :children (("init" :keys "i"
                   :file
                   (lambda ()
                     (let* ((name (concat
                                   (replace-regexp-in-string
                                    " " "_"
                                    (read-from-minibuffer "short title: "))
                                   ".org")))
                       (file-name-concat
                        literature_notes_dir
                        name)))
                   :type plain
                   :template ("#+title:  %^{full title}"
                              "#+author: %(user-full-name)"
                              "#+email:  %(message-user-mail-address)"
                              "#+date:   %<%F>"
                              "#+filetags: :literature:"
                              ""
                              "* [-] %\\1%?"
                              ":PROPERTIES:"
                              ":title:  %\\1"
                              ":author: %^{author}"
                              ":year:   %^{year}"
                              ":tags:   %^{tags}"
                              ":type:   %^{book|ebook|paper|article|audiobook|podcast}"
                              ":pages:  %^{pages}"
                              ":END:"
                              ""
                              "** excerpts"
                              "** literature notes"
                              "** transient notes"
                              "** summary"))

                  ("excerpt" :keys "e"
                   :headline "excerpts"
                   :empty-lines-after 1
                   :template ("* %^{title} [p:%^{page}] %^g"
                              "#+begin_quote"
                              "%x"
                              "#+end_quote"))

                  ("note: literary" :keys "l"
                   :headline "literature notes"
                   :empty-lines-after 1
                   :template ("* %^{title} [p:%^{page}] %^g"
                              "%?"))

                  ("note: transient" :keys "t"
                   :headline "transient notes"
                   :empty-lines-after 1
                   :template ("* %^{title} %^g"
                              "%?"))

                  ;; NOTE :: make sure to complete the literature-task-headline in order to log closing time.
                  ("summarize" :keys "c"
                   :headline "summary"
                   :unnarrowed t
                   :type plain
                   :template ("%?"))))))))
;; capture templates:1 ends here

;; [[file:config.org::*org-latex][org-latex:1]]
(add-hook! 'org-mode-hook #'laas-mode)
(setq org-startup-with-latex-preview t)
;; org-latex:1 ends here

;; [[file:config.org::*keywords to downcase][keywords to downcase:1]]
(defun org_convert_keywords_downcase ()
  "Convert all #+KEYWORDS => #+keywords && :keyword: => :keyword:"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((case-fold-search nil))
      (while (re-search-forward "^[ \t]*#\\+[A-Z_]*" nil t)
        (replace-match (downcase (match-string 0)) t)))))
;; keywords to downcase:1 ends here

;; [[file:config.org::*Jump to src file][Jump to src file:1]]
(defun org_goto_src ()
  "The opposite of `org-babel-tangle-jump-to-org'.
Jumps at tangled code from org src block."
  (interactive)
  (basic-save-buffer)
  (org-babel-tangle)
  (if (org-in-src-block-p)
      (let* ((header (car
                      (org-babel-tangle-single-block 1 'only-this-block)))
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

;; [[file:config.org::*shell][shell:1]]
(setq shell-file-name "/usr/bin/bash")  ;; NOTE :: emacs expects bash for it's internal shellcommands, hence we need bash otherwise plugins will break
;; shell:1 ends here

;; [[file:config.org::*nushell-ts-mode][nushell-ts-mode:1]]
(use-package! nushell-ts-mode)
;; nushell-ts-mode:1 ends here

;; [[file:config.org::*latex][latex:1]]
(setq +latex-viewers '(zathura))
;; latex:1 ends here
