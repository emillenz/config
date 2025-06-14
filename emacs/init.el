;; -*- lexical-binding: t -*-

;; ---
;; title: minimalist, distractionless vanilla emacs config
;; date: [2025-05-09]
;; author: emil lenz
;; email: emillenz@protonmail.com
;; ---

(use-package use-package
  :config
  (setopt use-package-always-demand t
          use-package-enable-imenu-support t))

(use-package package
  :config
  (add-to-list 'package-archives
	       '("melpa" . "https://melpa.org/packages/"))
  (package-initialize))

(use-package emacs
  :config
  (global-auto-revert-mode)
  (global-visual-line-mode)
  (column-number-mode)
  (global-subword-mode)
  (delete-selection-mode)
  (electric-indent-mode)
  (electric-pair-mode)
  (save-place-mode)
  (auto-save-visited-mode)
  (kill-ring-deindent-mode)
  (fringe-mode 0)

  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (blink-cursor-mode -1)
  (scroll-bar-mode -1)
  (scroll-bar-mode -1)
  (horizontal-scroll-bar-mode -1)
  (tooltip-mode -1)

  (setopt user-full-name "emil lenz"
	  user-mail-address "emillenz@protonmail.com")

  (setopt mouse-autoselect-window t
	  uniquify-buffer-name-style 'forward
	  delete-by-moving-to-trash t
	  remote-file-name-inhibit-delete-by-moving-to-trash t
	  ring-bell-function 'ignore
	  enable-recursive-minibuffers t
	  revert-without-query '(".*\\.pdf")
	  global-auto-revert-non-file-buffers t
	  auto-save-include-big-deletions t
	  kill-buffer-delete-auto-save-files t
	  auto-save-list-file-prefix (expand-file-name "autosave/" user-emacs-directory)
	  custom-file (expand-file-name "custom.el" user-emacs-directory)
	  use-short-answers t
	  save-interprogram-paste-before-kill t
	  require-final-newline t
	  load-prefer-newer t
	  desktop-dirname user-emacs-directory
	  find-file-visit-truename t
	  comment-empty-lines nil
	  show-paren-when-point-inside-paren t
	  kill-do-not-save-duplicates t
	  shift-select-mode nil
	  kmacro-execute-before-append nil
	  vc-follow-symlinks t
	  pulse-flag 'default)

  (setopt history-length 1000
          history-delete-duplicates t)

  (setopt shell-command-prompt-show-cwd t
          async-shell-command-display-buffer nil
          async-shell-command-buffer 'new-buffer)

  (setopt create-lockfiles nil
          make-backup-files nil
          delete-old-versions t
          version-control t
          kept-new-versions 5
          kept-old-versions 5
          vc-make-backup-files nil
          backup-by-copying t
          backup-by-copying-when-linked t
          backup-directory-alist `(("." . ,(concat user-emacs-directory "backups"))))

  (setopt initial-scratch-message nil
          inhibit-startup-echo-area-message user-login-name
          initial-buffer-choice nil
          inhibit-splash-screen t
          inhibit-startup-screen t
          inhibit-startup-buffer-menu t
          frame-title-format "%b ― emacs"
          icon-title-format frame-title-format
          frame-inhibit-implied-resize t
          use-file-dialog nil
          use-dialog-box nil)

  (setopt scroll-preserve-screen-position t
          scroll-error-top-bottom t
          auto-window-vscroll nil)

  (setopt compilation-scroll-output t
          next-error-recenter '(4))

  (progn
    (setopt tab-always-indent t
            indent-tabs-mode t
	    standard-indent 8
	    tab-width standard-indent)

    (setopt c-default-style "linux")
    (with-eval-after-load 'js (setopt js-indent-level standard-indent))
    (with-eval-after-load 'sh-script (setopt sh-basic-offset standard-indent)))

  (add-hook 'before-save-hook 'delete-trailing-whitespace)

  (progn
    (setopt line-spacing (/ 1.0 5))
    (setopt shr-use-fonts nil)
    (add-to-list 'default-frame-alist '(font . "Aporetic Sans Mono 10")))

  (progn
    (setopt minibuffer-prompt-properties
            '(read-only t intangible t cursor-intangible t face minibuffer-prompt))
    (add-hook 'minibuffer-setup-hook 'cursor-intangible-mode))

  (progn
    (set-language-environment "utf-8")
    (setopt default-input-method nil))

  (put 'narrow-to-region 'disabled nil)

  (seq-do (lambda (fn)
            (advice-add fn :before (defun --deactivate-mark (&rest _) (deactivate-mark))))
          '(apply-macro-to-region-lines
            eval-region
            align
            align-entire))

  (progn
    (defun advice-add-push-mark-once (fn)
      (advice-add fn
                  :before
                  (defun --push-mark-once (&rest _)
                    (unless (or (use-region-p)
                                (eq last-command this-command)
                                (when (mark) (= (mark) (point))))
                      (push-mark)))))

    (seq-do 'advice-add-push-mark-once
            '(mark-paragraph
              backward-up-list
              down-list)))

  (seq-do (lambda (cmd)
            (advice-add cmd :around
                        (defun --undo-amalgamate (fn &rest args)
                          (with-undo-amalgamate
                            (apply fn args)))))
          '(kmacro-end-and-call-macro-dwim
            query-replace-regexp))

  (progn
    (defmacro keymap-set! (keymap &rest pairs)
      (macroexp-progn
       (cl-loop for (key cmd)
		on pairs
		by 'cddr
		collect (list 'keymap-set keymap key cmd))))

    (setopt kill-whole-line t
	    set-mark-command-repeat-pop t)

    (keymap-set! global-map
		 "<remap> <downcase-word>" 'downcase-dwim
		 "<remap> <upcase-word>" 'upcase-dwim
		 "<remap> <capitalize-word>" 'capitalize-dwim
		 "<remap> <delete-horizontal-space>" 'cycle-spacing
		 "<remap> <kill-buffer>" 'kill-current-buffer
		 "C-M-/" 'hippie-expand
		 "C-z" 'repeat
		 "M-SPC" 'mark-word)

    (keymap-set! ctl-x-map
		 "f" 'recentf-open
		 "M-t" 'transpose-regions)

    (keymap-set! ctl-x-x-map
		 "f" 'global-font-lock-mode)

    (keymap-set! help-map
		 "."
		 (defun describe-symbol-at-point ()
                   (interactive)
                   (describe-symbol (symbol-at-point))))

    (keymap-set! indent-rigidly-map
		 "C-i" 'indent-rigidly-right-to-tab-stop
		 "C-M-i" 'indent-rigidly-left-to-tab-stop
		 "SPC" 'indent-rigidly-right
		 "DEL" 'indent-rigidly-left)

    (progn
      (put 'fist-error 'repeat-map 'next-error-repeat-map)
      (keymap-set! next-error-repeat-map "M-<" 'first-error))

    (progn
      (setopt kill-read-only-ok t)

      (keymap-set! global-map
                   "<remap> <kill-ring-save>"
		   (defun kill-ring-save-region-or-next-kill ()
		     (interactive)
		     (if (use-region-p)
			 (call-interactively 'kill-ring-save)
		       (let ((buffer-read-only t)
			     (kill-read-only-ok t))
			 (save-excursion
			   (call-interactively
			    (key-binding
			     (read-key-sequence "save next kill: "))))))))

      (advice-add 'kill-region
		  :before
		  (defun --pulse-read-only (beg end &optional region)
		    (when buffer-read-only
		      (pulse-momentary-highlight-region beg end)))))

    (advice-add 'yank
		:after
		(defun --yank-indent (&rest _)
                  (unless (minibufferp)
		    (indent-region (point) (mark)))))

    (keymap-set! global-map
		 "<remap> <open-line>"
		 (defun open-line-indent ()
		   (interactive)
		   (if (eq (point) (save-excursion
				     (back-to-indentation)
				     (point)))
		       (call-interactively 'split-line)
		     (save-excursion
		       (call-interactively 'default-indent-new-line)))))

    (keymap-set! global-map
		 "<remap> <comment-dwim>"
		 (defun comment-sexp-dwim ()
		   (interactive)
		   (save-mark-and-excursion
		     (unless (use-region-p)
		       (call-interactively 'mark-sexp))
		     (call-interactively 'comment-dwim))))

    (keymap-set! global-map
		 "<remap> <eval-last-sexp>"
		 (defun eval-sexp-dwim (&optional arg)
		   (interactive "P")
		   (save-mark-and-excursion
		     (unless (use-region-p)
		       (mark-sexp (if (or (not arg)
					  (consp arg))
				      1
				    arg) t))
		     (eval-region (region-beginning)
				  (region-end)
				  (if (consp arg)
				      (current-buffer)
				    t)))))

    (keymap-set! ctl-x-map
		 "C-b"
		 (defun switch-to-other-buffer ()
		   (interactive)
		   (let ((buf (caar (window-prev-buffers))))
		     (switch-to-buffer (unless (eq buf (current-buffer)) buf)))))

    (keymap-set! global-map
		 "<remap> <kmacro-end-and-call-macro>"
		 (defun kmacro-end-and-call-macro-dwim ()
		   (interactive)
		   (call-interactively
		    (if (use-region-p)
			'apply-macro-to-region-lines
		      'kmacro-end-and-call-macro))))))

(use-package window
  :config
  (setopt display-buffer-alist
	  (list (list (rx "*"
			  (or "Completions"
			      "Register Preview")
			  "*")
		      'display-buffer-at-bottom)
		'(".*" display-buffer-same-window)))

  (advice-add 'switch-to-buffer-other-window :override 'switch-to-buffer)

  (with-eval-after-load 'ediff
    (setopt ediff-window-setup-function 'ediff-setup-windows-plain))

  (with-eval-after-load 'man
    (setopt Man-notify-method 'pushy))

  (with-eval-after-load 'org
    (setopt org-src-window-setup 'current-window
	    org-agenda-window-setup 'current-window)

    (add-to-list 'display-buffer-alist
		 (list (rx "*"
			   (or (seq "Org " (or "Help" "todo"))
			       "Agenda Commands")
			   "*")
		       'display-buffer-at-bottom))))

(use-package modus-themes
  :init
  (setopt modus-themes-italic-constructs t
	  modus-themes-bold-constructs t
	  modus-themes-common-palette-overrides '((fg-region unspecified)
						  (fg-heading-1 fg-heading-0)
						  (bg-prose-block-contents bg-dim)))
  (load-theme 'modus-operandi))

(use-package register
  :config
  (setopt register-use-preview 'never)

  (progn
    (defun buffer-to-register (reg)
      (interactive (list (register-read-with-preview "buffer to register: ")))
      (set-register reg `(buffer . ,(current-buffer))))

    (defun point-to-register-dwim ()
      (interactive)
      (call-interactively
       (if current-prefix-arg
           'buffer-to-register
         'point-to-register)))

    (keymap-set! global-map
                 "<remap> <point-to-register>" 'point-to-register-dwim
		 "M-#" 'point-to-register-dwim
		 "M-j" 'jump-to-register)))

(use-package ffap
  :config
  (ffap-bindings))

(use-package hl-line
  :config
  (global-hl-line-mode))

(progn
  (global-font-lock-mode -1)

  (with-eval-after-load 'diff-mode
    (add-hook 'diff-mode-hook 'font-lock-mode))

  (with-eval-after-load 'magit
    (add-hook 'magit-mode-hook 'font-lock-mode)))

(use-package comint
  :config
  (setopt comint-input-ignoredups t
	  comint-prompt-read-only t))

(use-package isearch
  :config
  (add-hook 'isearch-update-post-hook
            (defun --isearch-beginning-of-match ()
	      (when (and isearch-other-end
                         isearch-forward
                         (string-prefix-p "isearch" (symbol-name last-command)))
                (goto-char isearch-other-end))))

  (setopt isearch-lax-whitespace t
          search-whitespace-regexp ".*?")

  (setopt lazy-highlight-initial-delay 0
          isearch-lazy-count t
          isearch-allow-motion t
          isearch-motion-changes-direction t
          isearch-wrap-pause 'no)

  (progn
    (keymap-unset isearch-mode-map "C-w" t)
    (keymap-unset isearch-mode-map "C-M-d" t)
    (keymap-set! isearch-mode-map
                 "<remap> <isearch-delete-char>" 'isearch-del-char)))

(use-package repeat
  :config
  (repeat-mode)
  (setopt repeat-keep-prefix t))

(use-package replace
  :config
  (progn
    (defvar suppressed-map
      (let ((map (make-keymap)))
        (set-char-table-range (nth 1 map) t 'ignore)
        map))

    (define-keymap :keymap query-replace-map :parent suppressed-map))

  (keymap-set! global-map
	       "<remap> <query-replace>" 'query-replace-regexp
	       "<remap> <isearch-query-replace>" 'isearch-query-replace-regexp)

  (keymap-set! query-replace-map
	       "p" 'backup))

(use-package icomplete
  :config
  (fido-vertical-mode)

  (setopt completion-auto-help nil)

  (setopt icomplete-delay-completions-threshold 0
          icomplete-compute-delay 0
          icomplete-prospects-height 12
          icomplete-tidy-shadowed-file-names t
          completions-detailed t
          max-mini-window-height 12)

  (setopt completion-ignore-case t
          read-buffer-completion-ignore-case t
          read-file-name-completion-ignore-case t)

  (keymap-set! icomplete-minibuffer-map
	       "C-c M-w"
	       (defun icomplete--save-candidate ()
		 (interactive)
		 (kill-new (car completion-all-sorted-completions))
		 (abort-recursive-edit)))

  (keymap-set! icomplete-minibuffer-map
	       "C-i" 'icomplete-force-complete
	       "C-M-m" 'icomplete-fido-exit))

(use-package recentf
  :config
  (recentf-mode)
  (setopt recentf-max-saved-items 300))

(use-package bookmark
  :config
  (setopt bookmark-fringe-mark nil
          bookmark-save-flag 1))

(use-package savehist
  :config
  (savehist-mode)
  (setopt savehist-additional-variables
          '(kill-ring
            register-alist
            mark-ring global-mark-ring
            search-ring regexp-search-ring)))

(use-package dired
  :config
  (add-hook 'dired-mode-hook 'dired-hide-details-mode)
  (add-hook 'dired-mode-hook 'dired-omit-mode)

  (setopt dired-kill-when-opening-new-dired-buffer t
	  dired-free-space nil
          dired-omit-files "^\\..*$"
          dired-clean-confirm-killing-deleted-buffers nil
          dired-dwim-target t
          dired-listing-switches "-alhF"
          dired-recursive-copies 'always
          dired-recursive-deletes 'always
          dired-no-confirm '(uncompress move copy)
          dired-create-destination-dirs 'ask
          dired-vc-rename-file t
          dired-auto-revert-buffer 'dired-directory-changed-p
          dired-create-destination-dirs-on-trailing-dirsep t)

  (keymap-set! dired-mode-map
	       "b" 'dired-up-directory)

  (progn
    (defvar dired-archive-dir "~/Archive")

    (keymap-set! dired-mode-map
		 "C-c a"
		 (defun dired-archive ()
		   (interactive)
		   (seq-do (lambda (file)
			     (let* ((dest (file-name-concat
					   dired-archive-dir
					   (concat
					    (file-name-sans-extension (file-relative-name file "~/"))
					    ".archived_"
					    (format-time-string "%F_T%H-%M-%S")
					    (when (file-name-extension file)
					      (concat "." (file-name-extension file))))))
				    (dir (file-name-directory dest)))

			       (unless (file-exists-p dir)
				 (make-directory dir t))
			       (rename-file file dest 1)))
			   (dired-get-marked-files nil nil))
		   (revert-buffer)))))

(progn
  (use-package org
    :config
    (setopt org-special-ctrl-k t)

    (setopt org-tags-column 0
            org-use-property-inheritance t
	    org-reverse-note-order t
	    org-refile-use-outline-path 'full-file-path
	    org-fontify-quote-and-verse-blocks t
	    org-hide-emphasis-markers t
	    org-pretty-entities t)

    (setopt org-log-done 'time
	    org-log-redeadline 'time
	    org-log-reschedule 'time
	    org-log-into-drawer "LOG")

    (setopt org-priority-highest 1
	    org-priority-lowest 3)

    (progn
      (setopt org-todo-keywords '((sequence
				   "[ ]([)"
				   "[@](e)"
				   "[?](?)"
				   "[+](+!)"
				   "[-](-!)"
				   "[>](>!)"
				   "[=](=!)"
				   "[&](&!)"
				   "|"
				   "[X](x!)"
				   "[\\](\\!)")))

      (setopt org-log-note-headings
	      '((done . "done :: %t")
		(state . "state :: %t %-3s")
		(note . "note :: %t")
		(reschedule . "reschedule :: %t")
		(delschedule . "delschedule :: %t")
		(redeadline . "redeadline :: %t")
		(deldeadline . "deldeadline :: %t")
		(refile . "refile :: %t")
		(clock-out . "clock-out :: %t"))))

    (modify-syntax-entry ?: "_" org-mode-syntax-table))

  (use-package org-indent
    :after org
    :config
    (add-hook 'org-mode-hook 'org-indent-mode)
    (setopt org-indent-indentation-per-level standard-indent)))

(use-package project
  :config
  (setopt project-switch-commands 'project-find-file
	  project-mode-line t))

(use-package puni
  :ensure t
  :init
  (puni-global-mode)
  (with-eval-after-load 'pdf-view
    (add-hook 'pdf-view-mode-hook (defun --puni-mode-disabled () (puni-mode -1))))

  (setopt puni-blink-for-sexp-manipulating t)

  (seq-do (lambda (cmd)
	    (advice-add-push-mark-once cmd))
          '(puni-end-of-sexp
	    puni-beginning-of-sexp))

  (advice-add 'puni-kill-line
	      :around
	      (defun --save-point (fn &rest args)
		(if (bolp)
		    (save-excursion
		      (apply fn args))
		  (apply fn args))))

  (keymap-set! puni-mode-map
               "C-<backspace>"
	       (defun puni-backward-kill-line-to-indent (&optional arg)
		 (interactive "P")
		 (let ((pos-indent (save-excursion (back-to-indentation) (point))))
		   (if (or arg (<= (point) pos-indent))
		       (puni-backward-kill-line arg)
		     (puni-soft-delete (point)
				       pos-indent
				       'strict-sexp
				       'beyond
				       'kill)))))

  (progn
    (keymap-set! puni-mode-map
                 "C-M-r" 'puni-raise
                 "C-M-s" 'puni-splice

                 "C-(" 'puni-slurp-backward
                 "C-)" 'puni-slurp-forward
                 "C-{" 'puni-barf-backward
                 "C-}" 'puni-barf-forward)

    (with-eval-after-load 'org
      (keymap-set! org-mode-map
                   "<remap> <puni-kill-line>" 'org-kill-line))

    (keymap-set! lisp-mode-shared-map
                 "C-c v" 'puni-convolute)))

(use-package magit
  :ensure t)

(use-package pdf-tools
  :ensure t
  :init (pdf-tools-install)
  :config
  (setopt pdf-view-continuous nil
	  large-file-warning-threshold (expt 10 8)
	  pdf-view-display-size 'fit-height
	  pdf-view-resize-factor 1.1))

(use-package whisper
  :ensure t
  :vc (:url "https://github.com/natrys/whisper.el"))
