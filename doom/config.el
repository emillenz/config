;; [[file:config.org::*User][User:1]]
(setq user-full-name "emil lenz"
      user-mail-address "emillenz@protonmail.com")
;; User:1 ends here

;; [[file:config.org::*Modus theme][Modus theme:1]]
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
;; Modus theme:1 ends here

;; [[file:config.org::*Font][Font:1]]
(setq doom-font                (font-spec :family "Iosevka Nerd Font" :size 14)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font" :size 14)
      doom-serif-font          (font-spec :family "Iosevka Nerd Font" :size 14)
      doom-big-font            (font-spec :family "Iosevka Nerd Font" :size 24))

(custom-set-faces!
  '(font-lock-keyword-face :slant normal :weight bold)
  '(font-lock-type-face    :slant normal)
  '(font-lock-comment-face :slant italic)
  '(font-lock-string-face  :slant italic))
;; Font:1 ends here

;; [[file:config.org::*Modeline][Modeline:1]]
(setq display-battery-mode nil
      display-time-mode nil
      doom-modeline-height 15
      doom-modeline-bar-width 5
      doom-modeline-enable-word-count t
      doom-modeline-persp-name t
      doom-modeline-major-mode-icon t)
;; Modeline:1 ends here

;; [[file:config.org::*Window layout & behavior][Window layout & behavior:1]]
(setq evil-vsplit-window-right t
      even-window-sizes 'width-only
      window-combination-resize t
      split-height-threshold nil
      split-width-threshold 0)

(after! org
  (setq org-src-window-setup 'current-window)
;; Window layout & behavior:1 ends here

;; [[file:config.org::*Window layout & behavior][Window layout & behavior:2]]
(add-hook! '(text-mode-hook
             ;; prog-mode-hook ;; NOTE :: don't use it, breaks with flycheck
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
;; Window layout & behavior:2 ends here

;; [[file:config.org::*Tabs][Tabs:1]]
(tab-bar-mode 1)
(setq tab-bar-tab-hints t
      tab-bar-new-button-show nil
      tab-bar-new-tab-to 'rightmost
      tab-bar-close-button-show nil)

(defadvice! with_newtab (fn &rest args)
  :before '(eshell
            +vterm/here
            info)
  (tab-bar-new-tab-to))
;; Tabs:1 ends here

;; [[file:config.org::*Misc Options][Misc Options:1]]
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
;; Misc Options:1 ends here

;; [[file:config.org::*Leader][Leader:1]]
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
;; Leader:1 ends here

;; [[file:config.org::*Global navigation scheme][Global navigation scheme:1]]
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
;; Global navigation scheme:1 ends here

;; [[file:config.org::*Global navigation scheme][Global navigation scheme:2]]
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
;; Global navigation scheme:2 ends here

;; [[file:config.org::*Evil][Evil:1]]
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

(map! :nm "C-k" #'evil-backward-section-begin
      :nm "C-j" #'evil-forward-section-end
      :nm "C-l" #'recenter-top-bottom)

(map! :after org :map evil-org-mode-map
      :nmv "C-j"  #'org-forward-element
      :nmv "C-k"  #'org-backward-element)
;; Evil:1 ends here

;; [[file:config.org::*Evil][Evil:2]]
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
;; Evil:2 ends here

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

;; [[file:config.org::*Org][Org:1]]
(map! :localleader :map org-mode-map
      "\\" #'org-latex-preview
      ","  #'org-ctrl-c-ctrl-c
      (:prefix-map ("`" . "org-src")
                   "`" #'org-edit-special
                   "g" #'org_goto_src
                   "t" #'org-babel-tangle))
;; Org:1 ends here

;; [[file:config.org::*Dired (keybindings)][Dired (keybindings):1]]
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
;; Dired (keybindings):1 ends here

;; [[file:config.org::*Magit][Magit:1]]
(map! :map magit-mode-map :after magit
      :nm "C-j" #'magit-section-forward-sibling
      :nm "C-k" #'magit-section-backward-sibling)
;; Magit:1 ends here

;; [[file:config.org::*Editor][Editor:1]]
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
;; Editor:1 ends here

;; [[file:config.org::*Jump property][Jump property:1]]
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
             evil-forward-section-end))
      (evil-remove-command-properties cmd :jump))
;; Jump property:1 ends here

;; [[file:config.org::*Lsp & completion][Lsp & completion:1]]
(setq company-minimum-prefix-length 1
      company-idle-delay 0.1 ;; NOTE :: setting to 0 => huge lags
      company-tooltip-idle-delay 0.1
      company-show-quick-access t
      company-global-modes '(not
                             help-mode
                             eshell-mode
                             org-mode
                             vterm-mode))
;; Lsp & completion:1 ends here

;; [[file:config.org::*Templates & snippets][Templates & snippets:1]]
(setq yas-triggers-in-field t)
;; Templates & snippets:1 ends here

;; [[file:config.org::*Dired][Dired:1]]
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
;; Dired:1 ends here

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

;; [[file:config.org::*Programming][Programming:1]]
(add-hook! 'prog-mode-hook #'rainbow-delimiters-mode)
;; Programming:1 ends here

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

;; [[file:config.org::*Conf-mode][Conf-mode:1]]
(add-hook! 'conf-mode-hook #'rainbow-mode)
;; Conf-mode:1 ends here

;; [[file:config.org::*Options][Options:1]]
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
;; Options:1 ends here

;; [[file:config.org::*Symbols][Symbols:1]]
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
;; Symbols:1 ends here

;; [[file:config.org::*Task states][Task states:1]]
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
;; Task states:1 ends here

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
        (:comments . "link")))
;; Babel:1 ends here

;; [[file:config.org::*Agenda][Agenda:1]]
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
;; Agenda:1 ends here

;; [[file:config.org::*Agenda][Agenda:2]]
(setq org-agenda-todo-keyword-format "%-3s"
      org-agenda-scheduled-leaders '("─────" "<-%2dd") ;; NOTE :: unicode is not fixed width => breaks formatting => cannot use it.
      org-agenda-deadline-leaders '("━━━━━" "=>%2dd" "<=%2dd")
      org-agenda-prefix-format '((agenda . "%-12c%-6s%-12t")
                                 (todo .   "%-12c%-6s%-12t")
                                 (tags .   "%-12c%-6s%-12t")
                                 (search . "%-12c%-6s%-12t")))
;; Agenda:2 ends here

;; [[file:config.org::*Clock][Clock:1]]
(setq org-clock-out-when-done t
      org-clock-persist t
      org-clock-into-drawer t)
;; Clock:1 ends here

;; [[file:config.org::*Capture templates][Capture templates:1]]
(defvar journal_dir "~/Documents/journal/"
  "Directory for daily journal files.")
(defvar literature_notes_dir "~/Documents/literature/notes/"
  "Directory for literature notes.")
(defvar literature_source_dir "~/Documents/literature/source/"
  "Directory for literature source files.")

(defun doct_expand (proj projs &optional type parent)
  "Generate doct preset for project (standardized).

`PROJ:'   'name            | Project key (name)
`PROJS:'  '((name ?k)..)   | Projects plist containing PROJ
`TYPE:'   'agenda / 'notes | Which file to use (ex: agend.org). Omitted? => no :file returned.
`PARENT:' 'parent          | Is it a subproject of PARENT? (for :file).

This approach to doct ensures all keys for one project use the same prefix and reduces
code repetition."
  (let* ((name (symbol-name proj))
         (key (char-to-string (alist-get proj projs)))
         (file (file-name-concat
                org-directory
                (when parent (symbol-name parent))
                name
                (format "%s.org" (symbol-name type)))))
    `(,name
      :keys ,key
      ,@(when type `(:file ,file)))))

(after! org
  (setq
   org-capture-templates
   (let ((projs '((CS . ?C)
                  (cs . ?c)
                  (dm . ?d)
                  (ad . ?a)
                  (la . ?l)
                  (ep . ?e)
                  (personal . ?p)
                  (config . ?f)
                  (compass . ?o))))
     (doct
      `(("task" :keys "t"
         :headline "inbox"
         :prepend t :empty-lines-after 1
         :template ("* [ ] %^{title}%? %^g")
         :children ((,@(doct_expand 'cs projs)
                     :children ,(mapcar
                                 (lambda (proj)
                                   (doct_expand proj projs 'agenda 'cs))
                                 '(dm ad la ep)))
                    ,@(mapcar
                       (lambda (proj)
                         (doct_expand proj projs 'agenda))
                       '(personal config compass))))

        ("event" :keys "e"
         :headline "events"
         :prepend t :empty-lines-after 1
         :template ("* [#] %^{title}%? %^g"
                    "%^T"
                    ":PROPERTIES:"
                    ":location: %^{location}"
                    ":material: %^{material}"
                    ":END:")
         :children ((,@(doct_expand 'cs projs)
                     :children ,(mapcar
                                 (lambda (proj)
                                   (doct_expand proj projs 'agenda 'cs))
                                 '(dm ad la ep)))
                    ,@(mapcar
                       (lambda (proj)
                         (doct_expand proj projs 'agenda))
                       '(personal cs))))

        ("note" :keys "n"
         :prepend t :empty-lines-after 1
         :template ("* %^{title} %^g"
                    ":PROPERTIES:"
                    ":created: %U"
                    ":END:"
                    "%?")
         :children ((,@(doct_expand 'cs projs)
                     :children ,(mapcar
                                 (lambda (proj)
                                   (doct_expand proj projs 'notes 'cs))
                                 '(dm ad la ep)))
                    ,@(mapcar
                       (lambda (proj)
                         (doct_expand proj projs 'notes))
                       '(cs personal config compass))))

        ("journal" :keys "j"
         :file (lambda ()
                 (file-name-concat
                  journal_dir
                  (format "%s_journal.org" (format-time-string "%F"))))
         :children (("begin" :keys "i"
                     :type plain
                     :template ("#+title:  Daily Note: %<%A, %e. %B %Y>"
                                "#+author: %(user-full-name)"
                                "#+email:  %(message-user-mail-address)"
                                "#+date:   %<%F>"
                                ""
                                "* personal goals"
                                "- %?"
                                ""
                                "* agenda"
                                "** [ ] "))
                    ("entry" :keys "e"
                     :empty-lines-before 1
                     :template ("* %^{title}"
                                ":PROPERTIES:"
                                ":created: %U"
                                ":END:"
                                "%?"))

                    ("end" :keys "r"
                     :unnarrowed t
                     :template ("* gratitude"
                                "- %?"
                                ""
                                "* reflection"
                                "-"))))

        ("literature" :keys "l"
         :file (lambda () (read-file-name "file: " literature_notes_dir))
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
                     :book-author
                     (lambda () (s-titleized-words (read-from-minibuffer "author: ")))
                     :template ("#+title:  %^{full title}"
                                "#+author: %(user-full-name)"
                                "#+email:  %(message-user-mail-address)"
                                "#+date:   %<%F>"
                                ""
                                "* [-] %\\1"
                                ":PROPERTIES:"
                                ":title:  %\\1"
                                ":author: %^{author}"
                                ":year:   %^{year}"
                                ":tags:   %^{tags}"
                                ":type:   %^{type|book|ebook|paper|article|audio-book|podcast}"
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
                     :template ("* %^{title} [p:%^{page}]"
                                "#+begin_quote"
                                "%x"
                                "#+end_quote"))

                    ("note: literary" :keys "l"
                     :headline "literature notes"
                     :empty-lines-after 1
                     :template ("* %^{title} [p:%^{page}]"
                                "%?"))

                    ("note: transient" :keys "t"
                     :headline "transient notes"
                     :empty-lines-after 1
                     :template ("* %^{title}"
                                "%?"))

                    ;; NOTE:: make sure to complete the literature-task-headline in order to log closing time.
                    ("summarize" :keys "c"
                     :headline "summary"
                     :unnarrowed t
                     :type plain
                     :template ("%?")))))))))
;; Capture templates:1 ends here

;; [[file:config.org::*Latex][Latex:1]]
(add-hook! 'org-mode-hook #'laas-mode)
(setq org-startup-with-latex-preview t)
;; Latex:1 ends here

;; [[file:config.org::*Keywords to downcase][Keywords to downcase:1]]
(defun org_convert_keywords_downcase ()
  "Convert all #+KEYWORDS => #+keywords && :keyword: => :keyword:"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((case-fold-search nil))
      (while (re-search-forward "^[ \t]*#\\+[A-Z_]*" nil t)
        (replace-match (downcase (match-string 0)) t)))))
;; Keywords to downcase:1 ends here

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

;; [[file:config.org::*Nushell][Nushell:1]]
(load! "user/nushell-mode.el")
(setq shell-file-name "/usr/bin/bash")  ;; NOTE :: Emacs expects bash for it's internal shellcommands
;; Nushell:1 ends here

;; [[file:config.org::*Latex][Latex:1]]
(setq +latex-viewers '(zathura))
;; Latex:1 ends here
