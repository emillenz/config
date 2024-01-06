;; [[file:config.org::*User][User:1]]
(setq user-full-name "Emil Lenz"
      user-mail-address "emillenz@protonmail.com")
;; User:1 ends here

;; [[file:config.org::*Theme: Solarized][Theme: Solarized:1]]
(setq doom-theme 'doom-solarized-dark)

(after! evil
  (setq x-stretch-cursor t
        evil-normal-state-cursor   '("#268BD2" box)
        evil-insert-state-cursor   '("#268BD2" bar)
        evil-visual-state-cursor   '("#6c71c4" box)
        evil-motion-state-cursor   '("#cb4b16" box)
        evil-operator-state-cursor '("#cb4b16" box)
        evil-replace-state-cursor  '("#268BD2" hbar)))
;; Theme: Solarized:1 ends here

;; [[file:config.org::*Font][Font:1]]
(setq doom-font-increment 1
      doom-big-font-increment 1
      doom-font                (font-spec :family "Iosevka Comfy" :size 14)
      doom-variable-pitch-font (font-spec :family "Iosevka Comfy Duo" :size 14)
      doom-serif-font          (font-spec :family "Iosevka Comfy Motion Duo" :size 14)
      doom-big-font            (font-spec :family "Iosevka Comfy" :size 24))

(custom-set-faces!
  '(font-lock-keyword-face :slant normal :weight bold)
  '(font-lock-type-face    :slant normal :weight normal)
  '(font-lock-comment-face :slant italic :weight normal))
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
  (set-popup-rule! "^\\*Org Src" :ignore t)) ;; HACK :: fullscreen window

;; HACK :: will only take effect after the config has been reloaded (weird..)
(setq-default +popup-defaults '(:side right
                                :width 0.33
                                :select nil
                                :quit nil
                                :modeline t))
;; Window layout & behavior:1 ends here

;; [[file:config.org::*Window layout & behavior][Window layout & behavior:2]]
(add-hook! '(text-mode-hook
             prog-mode-hook
             dired-mode-hook
             org-agenda-mode-hook
             magit-mode-hook)
           #'visual-fill-column-mode)

(global-display-fill-column-indicator-mode -1)
(setq visual-fill-column-enable-sensible-window-split t
      visual-fill-column-center-text t
      visual-fill-column-width 100)
(setq-default fill-column 100)
;; Window layout & behavior:2 ends here

;; [[file:config.org::*Misc Options][Misc Options:1]]
(setq bookmark-default-file "~/.config/doom/bookmarks"
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
      display-line-numbers-type 'visual
      shell-command-prompt-show-cwd t)

(save-place-mode 1)
(+global-word-wrap-mode 1)
(global-subword-mode 1)

(tab-bar-mode 1)
(setq tab-bar-tab-hints t
      tab-bar-new-button-show nil
      tab-bar-new-tab-to 'rightmost
      tab-bar-close-button-show nil)

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
               "w" #'z-clean-whitespace)
      (:prefix "s"
               (:prefix-map ("t" . "dictionary")
                            "d" #'+lookup/dictionary-definition
                            "s" #'+lookup/synonyms
                            "t" #'dictionary-search)))

  (map! :localleader
        :map org-mode-map
        "\\" #'org-latex-preview
        (:prefix-map ("C" . "code")
                     "d" #'org-babel-detangle
                     "J" #'org-babel-tangle-jump-to-org
                     "j" #'z-jump-src
                     "t" #'org-babel-tangle
                     "e" #'org-edit-special))
;; Leader:1 ends here

;; [[file:config.org::*Global navigation scheme][Global navigation scheme:1]]
(map! :map  'override
      :nvim "M-j"   #'previous-window-any-frame
      :nvim "M-k"   #'next-window-any-frame
      :nvim "M-t"   #'tab-bar-new-tab-to
      :nvim "M-q"   (cmd! (kill-current-buffer) (evil-window-delete))
      :nvmi "M-z"   #'+popup/toggle
      :nvim "M-1"   (cmd! (tab-bar-select-tab 1))
      :nvim "M-2"   (cmd! (tab-bar-select-tab 2))
      :nvim "M-3"   (cmd! (tab-bar-select-tab 3))
      :nvim "M-4"   (cmd! (tab-bar-select-tab 4))
      :nvim "M-5"   (cmd! (tab-bar-select-tab 5))
      :nvim "M-6"   (cmd! (tab-bar-select-tab 6))
      :nvim "M-7"   (cmd! (tab-bar-select-tab 7))
      :nvim "M-8"   (cmd! (tab-bar-select-tab 8))
      :nvim "M-9"   (cmd! (tab-bar-select-tab 9))
      :nvim "M-o"   #'find-file
      :nvim "M-f"   #'consult-find
      :nvim "M-F"   (cmd! (consult-find "~"))
      :nvim "M-g"   #'consult-buffer
      :nvim "M-r"   #'consult-recent-file
      :nvim "M-c"   #'async-shell-command
      :nvim "M-w"   #'+lookup/online
      :nvim "M-;"   #'execute-extended-command
      :nvim "M-'"   #'consult-bookmark

      :nvim "C--"   #'doom/decrease-font-size
      :nvim "C-="   #'doom/increase-font-size
      :nvim "C-0"   #'doom/reset-font-size)
;; Global navigation scheme:1 ends here

;; [[file:config.org::*Evil-mode][Evil-mode:1]]
;; HACK :: disable all default-maps (mappings used are below)
(add-hook 'evil-mode-hook #'evil-cleverparens-mode)
(setq evil-cleverparens-use-s-and-S nil
      evil-cleverparens-use-additional-bindings nil
      evil-cleverparens-use-additional-movement-keys nil)
(map! :nmvo "j"   #'evil-next-visual-line
      :nmvo "k"   #'evil-previous-visual-line

      :nm   "TAB" #'+fold/toggle

      :nmv  "U"   #'evil-redo
      :nmv  "Q"   #'evil-execute-last-recorded-macro
      :nmv  "&"   #'evil-ex-repeat
      :nmv  "M"   (cmd! (evil-goto-mark-line ?m))

      :nmv  "("   #'evil-cp-backward-up-sexp
      :nmv  ")"   #'evil-cp-up-sexp

      :nmv  "+"   #'evil-numbers/inc-at-pt
      :nmv  "-"   #'evil-numbers/dec-at-pt
      :nmv  "g+"  #'evil-numbers/inc-at-pt-incremental
      :nmv  "g-"  #'evil-numbers/dec-at-pt-incremental

      :nmv  "go"  #'consult-imenu
      :nmv  "g/"  #'+default/search-buffer)
;; Evil-mode:1 ends here

;; [[file:config.org::*Control-bindings][Control-bindings:1]]
(map! :inmv "C-s" #'evil-write
      :nmv "C-q" #'kill-current-buffer
      :nmv "C-j" #'evil-forward-section-begin
      :nmv "C-k" #'evil-backward-section-begin)
;; Control-bindings:1 ends here

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

;; [[file:config.org::*Org mode][Org mode:1]]
(map! :map evil-org-mode-map
      :nmv "C-j"     #'org-forward-element
      :nmv "C-k"     #'org-backward-element)
;; Org mode:1 ends here

;; [[file:config.org::*Dired (keys)][Dired (keys):1]]
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
        :nm "E" #'dired-create-directory))

  (map! :localleader
        :map dired-mode-map
        :nm "A" #'z-dired-archive)
;; Dired (keys):1 ends here

;; [[file:config.org::*Minibuffer][Minibuffer:1]]
(map! :map vertico-map
      :nmi "M-g" #'consult-dir)
;; Minibuffer:1 ends here

;; [[file:config.org::*Magit][Magit:1]]
(after! magit
  (map! :map magit-mode-map
        :nm "C-j" #'magit-section-forward-sibling
        :nm "C-k" #'magit-section-backward-sibling))
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

(dolist (cmd '(flycheck-next-error
               flycheck-previous-error
               +lookup/definition
               +lookup/references
               +lookup/implementations
               +default/search-buffer
               consult-imenu))
  (evil-add-command-properties cmd :jump t))
;; Editor:1 ends here

;; [[file:config.org::*Lsp & completion][Lsp & completion:1]]
(setq company-minimum-prefix-length 1
      company-idle-delay 0.1 ;; NOTE :: setting to 0 => huge lags
      company-show-quick-access t
      company-global-modes '(not
                             erc-mode
                             message-mode
                             help-mode
                             gud-mode
                             vterm-mode))
;; Lsp & completion:1 ends here

;; [[file:config.org::*Templates & snippets][Templates & snippets:1]]
(setq yas-triggers-in-field t)
;; Templates & snippets:1 ends here

;; [[file:config.org::*Dired][Dired:1]]
(setq dired-omit-files
      (rx (or ;; NOTE:: this is the elegant && extensible way to do regex.
           (seq bol (? ".") "#")
           (seq bol "." (not (any ".")))
           (seq "~" eol)
           (seq bol "CVS" eol))))

(setq dired-open-extensions '(("mkv"  . "mpv")
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

(setq dired-recursive-copies 'always
 dired-recursive-deletes 'top
 global-auto-revert-non-file-buffers t
 dired-kill-when-opening-new-dired-buffer t)
;; Dired:1 ends here

;; [[file:config.org::*Archive file][Archive file:1]]
(defvar z-archive-dir "~/Archive/"
  "User's archive directory.")

(defun z-dired-archive ()
  (interactive)
  (dolist (file (dired-get-marked-files))
    (let* ((file (dired-get-filename))
           (dest (file-name-concat z-archive-dir
                                   (file-relative-name file "~/"))))
      (rename-file file dest 1)))) ;; NOTE :: "1": propt before overwrite
;; Archive file:1 ends here

;; [[file:config.org::*Programming][Programming:1]]
(add-hook! 'prog-mode-hook #'rainbow-mode #'rainbow-delimiters-mode)
;; Programming:1 ends here

;; [[file:config.org::*Indentation: 2 spaces][Indentation: 2 spaces:1]]
(advice-add #'doom-highlight-non-default-indentation-h :override #'ignore)

(setq tab-always-indent t
      org-indent-indentation-per-level 2
      evil-shift-width 2
      standard-indent 2
      tab-width 2
      evil-indent-convert-tabs t
      indent-tabs-mode nil)
;; Indentation: 2 spaces:1 ends here

;; [[file:config.org::*Clean Whitespace][Clean Whitespace:1]]
(defun z-clean-whitespace ()
  "Deletes consecutive empty lines if > 1, and strip trailing whitespace."
  (interactive)
  (delete-trailing-whitespace)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\n\n+" nil t)
      (replace-match "\n\n"))))
;; Clean Whitespace:1 ends here

;; [[file:config.org::*\[begin org-after-block\]][[begin org-after-block]:1]]
(after! org
;; [begin org-after-block]:1 ends here

;; [[file:config.org::*Options][Options:1]]
(add-hook! 'org-mode-hook
           #'visual-line-mode
           #'org-fragtog-mode
           #'org-appear-mode
           #'org-auto-tangle-mode)

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
      org-appear-inside-latex t
      org-hide-emphasis-markers t)

(+org-pretty-mode 1)

(setq org-pretty-entities t
      org-pretty-entities-include-sub-superscripts t)

(setq org-list-demote-modify-bullet '(("-"  . "-")
                                      ("+"  . "+")
                                      ("*"  . "-")
                                      ("a." . "a)")
                                      ("1." . "1)")
                                      ("1)" . "a)")))

(setq org-blank-before-new-entry '((heading         . t)
                                   (plain-list-item . nil)))
;; Options:1 ends here

;; [[file:config.org::*Symbols][Symbols:1]]
(add-hook! 'org-mode-hook #'org-superstar-mode #'prettify-symbols-mode)
(setq org-superstar-headline-bullets-list '("◉"
                                            "◯"
                                            "◈"
                                            "◇"
                                            "▣"
                                            "□")
      org-superstar-item-bullet-alist '((?- . "─")
                                        (?* . "─") ;; NOTE :: asteriks are reserved for headings only (don't use in lists) => no unambigiuity
                                        (?+ . "⇒")))

(appendq! +ligatures-extra-symbols '(:list_property "∷"
                                     :em_dash       "—"
                                     :ellipses      "…"
                                     :arrow_right   "→"
                                     :arrow_left    "←"
                                     :arrow_lr      "↔"
                                     :properties    "⚙"))
;; Symbols:1 ends here

;; [[file:config.org::*Ligatures][Ligatures:1]]
(add-hook! 'org-mode-hook
  (defun z-org-add-symbols ()
    "Add more sybols to be displayed (for functional notation)"
    (appendq! prettify-symbols-alist '(("->" . "→")
                                       ("=>" . "⇒")
                                       ("<=>" . "⇔")))))
;; Ligatures:1 ends here

;; [[file:config.org::*Task states][Task states:1]]
(setq org-todo-keywords '((type
                           "[#](#)"
                           "[ ](t)" ;; HACK :: cannot use " " => [T]odo
                           "[?](?!)"
                           "[-](-@)"
                           "[=](=@)"
                           "[&](&@)"
                           "|"
                           "[x](x!)"
                           "[@](d@)" ;; HACK :: cannot use"@" => [D]elegated
                           "[\\](\\@)")))
;; Task states:1 ends here

;; [[file:config.org::*Task states][Task states:2]]
(setq org-todo-keyword-faces '(("[#]"  . +org-todo-project)
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
(setq org-log-done 'time
      org-log-repeat 'time
      org-todo-repeat-to-state t
      org-log-redeadline 'time
      org-log-reschedule 'time
      org-log-into-drawer "LOG")

(setq org-priority-highest 1
      org-priority-lowest 3
      org-priority-faces '((?1  . 'all-the-icons-red)
                           (?2 . 'all-the-icons-orange)
                           (?3 . 'all-the-icons-yellow)))

(setq org-log-note-headings '((done        . "done note: %t")
                              (state       . "state: %-3S -> %-3s %t") ;; NOTE :: DON'T change this?; my task-statuses are all 3x wide -> formatting needs adjustment if not in order to align them.
                              (note        . "note: %t")
                              (reschedule  . "reschedule: %S, %t")
                              (delschedule . "del-scheduled: %S, %t")
                              (redeadline  . "re-deadline: %S, %t")
                              (deldeadline . "del-deadline: %S, %t")
                              (refile      . "refile: %t")
                              (clock-out   . "")))
;; Task states:3 ends here

;; [[file:config.org::*Babel][Babel:1]]
(setq org-babel-default-header-args '((:session  . "none")
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
      org-agenda-deadline-faces '((1.0 . error)
                                  (1.0 . org-warning)
                                  (0.5 . org-upcoming-deadline)
                                  (0.0 . org-upcoming-distant-deadline))
      org-agenda-time-grid nil
      org-capture-use-agenda-date t)
;; Agenda:1 ends here

;; [[file:config.org::*Agenda][Agenda:2]]
(setq org-agenda-scheduled-leaders '("─────"
                                     "<-%2dd") ;; NOTE :: unicode is not fixed width => breaks formatting => cannot use it.
      org-agenda-deadline-leaders '("━━━━━"
                                    "=>%2dd"
                                    "<=%2dd")
      org-agenda-todo-keyword-format "%-3s"
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

;; [[file:config.org::*Keywords to downcase][Keywords to downcase:1]]
(defun z-org-convert-keywords-downcase ()
  "Convert all #+KEYWORDS => #+keywords && :keyword: => :keyword:"
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (let ((case-fold-search nil))
      (while (re-search-forward "^[ \t]*#\\+[A-Z_]*" nil t)
        (replace-match (downcase (match-string 0)) t)))))
;; Keywords to downcase:1 ends here

;; [[file:config.org::*Jump to src file][Jump to src file:1]]
(defun z-jump-src ()
  "The opposite of `org-babel-tangle-jump-to-org'.
Jumps at tangled code from org src block."
  (interactive)
  (basic-save-buffer)
  (org-babel-tangle)
  (if (org-in-src-block-p)
      (let* ((header (car (org-babel-tangle-single-block 1
                                                         'only-this-block)))
             (tangle (car header))
             (lang (caadr header))
             (buffer (nth 2 (cadr header)))
             (org-id (nth 3 (cadr header)))
             (source-name (nth 4 (cadr header)))
             (search-comment (org-fill-template org-babel-tangle-comment-format-beg
                                                `(("link" . ,org-id)
                                                  ("source-name" . ,source-name))))
             (file (expand-file-name (org-babel-effective-tangled-filename buffer
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
(defvar z-journal-dir "~/Documents/journal/"
  "Directory for daily journal files.")
(defvar z-literature-notes-dir "~/Documents/literature/notes/"
  "Directory for literature notes.")
(defvar z-literature-source-dir "~/Documents/literature/source/"
  "Directory for literature source files.")

(defun z-doct-agenda (projects &optional parent)
  "Generate doct agenda preset for project.
This helper function is used to consistently create filepaths for the 'agenda.org' file of the project.
"
  (cl-loop for (name key) in projects
           collect `(,name
                     :keys ,key
                     :file ,(file-name-concat org-directory
                                              (car parent)
                                              name
                                              "agenda.org"))))

(setq
 org-capture-templates
 ;; NOTE:: Define generic projects here for refuse in 'notes' and 'agenda'.
 (let ((cs       '("cs"       "c"))
       (dm       '("dm"       "d"))
       (ad       '("ad"       "a"))
       (la       '("la"       "l"))
       (ep       '("ep"       "e"))
       (personal '("personal" "p"))
       (config   '("config"   "f"))
       (compass  '("compass"  "o"))
       (journal  '("journal"  "j")))

   (doct `(("task" :keys "t"
            :headline "Inbox"
            :prepend t
            :empty-lines-after 1
            :template ("* [ ] %^{title} %^g"
                       "%?")
            :children ((,(car cs) :keys ,(cadr cs)
                        :children ,(z-doct-agenda (list cs dm ad la ep) cs))
                       ,@(z-doct-agenda (list personal config compass))))

           ("event" :keys "e"
            :headline "Events"
            :empty-lines-after 1
            :prepend t
            :template ("* [#] %^{title} %^g"
                       "%^T"
                       ":PROPERTIES:"
                       ":location: %^{location}"
                       ":material: %^{material}"
                       ":END:"
                       "%?")
            :children (,@(z-doct-agenda (list personal))
                       ,@(z-doct-agenda (list cs dm ad la ep) cs)))

           ("note" :keys "n"
            :empty-lines-after 1
            :prepend t
            :template ("* %^{title} %^g"
                       ":PROPERTIES:"
                       ":created: %U"
                       ":END:"
                       "%?")
            :children ((,(car cs) :keys ,(cadr cs)
                        :children ,(z-doct-agenda (list cs dm ad la ep) cs))
                       ,@(z-doct-agenda (list personal compass config))))

           ("journal" :keys "j"
            :file (lambda ()
                    (file-name-concat z-journal-dir
                                      (format "%s_journal.org" (format-time-string "%F"))))
            :children (("init-today" :keys "i"
                        :type plain
                        :template ("#+title:  Daily Note: %<%F>"
                                   "#+author: %(user-full-name)"
                                   "#+email:  %(message-user-mail-address)"
                                   "#+date:   %<%F>"
                                   ""
                                   "* Personal Goals"
                                   "- %?"
                                   "* Agenda"
                                   "** [ ] "))
                       ("entry" :keys "e"
                        :empty-lines-after 1
                        :template ("* %^{title}"
                                   ":PROPERTIES:"
                                   ":created: %U"
                                   ":END:"
                                   "%?"))

                       ("review-today" :keys "r"
                        :unnarrowed  t
                        :template ("* Gratitude"
                                   "- %?"
                                   ""
                                   "* Reflection"
                                   "-"))))

           ("literature" :keys "l"
            :file (lambda () (read-file-name "file: " z-literature-notes-dir))
            :children
            (("init-source" :keys "i"
              :file (lambda ()
                      (let* ((source (file-name-base (read-file-name "source: " z-literature-source-dir)))
                             (prompt (format "%s.org" (downcase (replace-regexp-in-string " " "-" source))))
                             (name (read-from-minibuffer "filename: " prompt)))
                        (file-name-concat z-literature-notes-dir name)))
              :type plain
              :immediate-finish t
              :book-author (lambda () (s-titleized-words (read-from-minibuffer "author: " )))
              :template ("#+title:  %^{title}"
                         "#+author: %(user-full-name)"
                         "#+email:  %(message-user-mail-address)"
                         "#+date:   %<%F>"
                         ""
                         "* [-] %\1"
                         ":PROPERTIES:"
                         ":title:  %\1"
                         ":author: %^{author}"
                         ":year:   %^{year}"
                         ":tags:   %^{tags}"
                         ":type:   %^{type|book|ebook|academic-paper|article|audio-book|podcast}"
                         ":pages:  %^{pages}"
                         ":END:"
                         ""
                         "** Excerpts"
                         "** Literature Notes"
                         "** Transient Notes"
                         "** Summary"
                         "%?"))
             ("excerpt" :keys "e"
              :headline "Excerpts"
              :empty-lines-after 1
              :template
              ("* %^{title} [p:%^{page}]"
               "#+begin_quote"
               "%x"
               "#+end_quote"
               "%?"))

             ("literary-note" :keys "l"
              :headline "Literature Notes"
              :empty-lines-after 1
              :template
              ("* %^{title} [p:%^{page}]"
               "%?"))

             ("transient-note" :keys "t"
              :headline "Transient Notes"
              :empty-lines-after 1
              :template
              ("* %^{title}"
               "%?"))

             ;; NOTE:: make sure to complete the literature-task-headline in order to log closing time.
             ("close-source" :keys "c"
              :headline "Summary"
              :unnarrowed t
              :type plain
              :template ("%?"))))))))
;; Capture templates:1 ends here

;; [[file:config.org::*\[end: org-after-block\]][[end: org-after-block]:1]]
)
;; [end: org-after-block]:1 ends here

;; [[file:config.org::*Nushell][Nushell:1]]
(load! "user/nushell-mode.el")
;; Nushell:1 ends here

;; [[file:config.org::*Elisp][Elisp:1]]
(add-hook! 'emacs-lisp-mode-hook (highlight-indent-guides-mode 0))
;; Elisp:1 ends here

;; [[file:config.org::*Latex][Latex:1]]
(setq +latex-viewers '(zathura pdf-tools))
;; Latex:1 ends here
