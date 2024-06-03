;; ---
;; title: bare-metal, minimalist emacs evil-mode config (just evil, no additions)
;; date: 2024-05-27
;; author: emil lenz
;; email: emillenz@protonmail.com
;; ---

;; UI
(progn
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (blink-cursor-mode 0)
  (scroll-bar-mode 0)
  (horizontal-scroll-bar-mode 0)
  (add-hook 'emacs-startup-hook #'toggle-frame-maximized)
  (global-display-line-numbers-mode 1)
  (setq display-line-numbers-type 'relative
        inhibit-startup-screen t
        initial-scratch-message ""))

;; THEME :: MODUS VIENDI
(progn
  (require-theme 'modus-themes)
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs t
        modus-themes-org-blocks 'gray-background
        modus-themes-common-palette-overrides '((fg-region unspecified) ;; NOTE :: don't override syntax highlighting in region
                                                (fg-heading-1 fg-heading-0)))
  (load-theme 'modus-operandi))

;; GLOBAL OPTIONS
(progn
  (electric-indent-mode 1)
  (electric-pair-mode 1)
  (delete-selection-mode 1)
  (global-auto-revert-mode 1)
  (column-number-mode 1)
  (savehist-mode 1)
  (global-word-wrap-whitespace-mode 1)
  (save-place-mode 1)
  (global-subword-mode 1)

  (add-hook 'before-save-hook #'delete-trailing-whitespace)

  (setq-default indent-tabs-mode nil)
  (setq ring-bell-function 'ignore
        global-auto-revert-non-file-buffers t
        use-short-answers t
        save-interprogram-paste-before-kill t
        require-final-newline t
        load-prefer-newer t
        frame-inhibit-implied-resize t
        ediff-window-setup-function 'ediff-setup-windows-plain
        backup-by-copying t
        shell-command-prompt-show-cwd t
        disabled-command-function nil
        backup-directory-alist `(("." .
                                  ,(concat user-emacs-directory "backups")))
        custom-file (expand-file-name "custom.el" user-emacs-directory)))

;; DIRED
(with-eval-after-load 'dired
  (add-hook 'dired-mode-hook #'dired-hide-details-mode)
  (add-hook 'dired-mode-hook #'dired-omit-mode)
  (setq dired-omit-files "^\\..*$")
  (setq dired-recursive-copies 'always
        dired-recursive-deletes 'top
        dired-no-confirm '(uncompress move copy)))

(defvar z-packages '(use-package
                      evil
                      evil-collection
                      vertico)
  "Add the package you want to have installed to this list and then
configure it using: 'use-package'.")

;; PACKAGES SETUP
(progn
  (require 'package)
  (setq package-archives '(("org" . "https://orgmode.org/elpa/")
                           ("gnu" . "https://elpa.gnu.org/packages/")
                           ("melpa" . "https://melpa.org/packages/")))
  (package-initialize)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package z-packages)
    (unless (package-installed-p package)
      (package-install package))))

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil
        evil-ex-substitute-global t
        evil-want-minibuffer t
        evil-want-Y-yank-to-eol t
        evil-undo-system 'undo-redo
        evil-want-C-i-jump t
        evil-want-C-u-scroll t
        evil-want-C-w-delete t
        evil-want-C-h-delete t
        evil-want-C-u-delete t)

  (evil-mode 1)

  (evil-define-key '(normal visual motion) 'global
    "j" #'evil-next-visual-line
    "k" #'evil-previous-visual-line
    "^" #'evil-first-non-blank-of-visual-line
    "$" #'evil-end-of-visual-line
    "U" #'evil-redo)

  (define-key key-translation-map (kbd "C-h") (kbd "DEL")) ;; HACK :: make c-h work properly everywhere

  ;; NAVIGATION SCHEME
  (evil-define-key '(normal motion) 'global
    (kbd "C-s") #'save-buffer
    (kbd "C-q") #'kill-buffer-and-window
    (kbd "C-w") #'next-window-any-frame
    (kbd "C-e") #'find-file
    (kbd "C-g") #'switch-to-buffer
    (kbd "C-b") (lambda () (interactive) (switch-to-buffer nil)))

  ;; GLOBAL-MARKS
  (defun z-goto-global-mark (char)
    "Go to the buffer of the global-mark.
Usage: 'evil-set-mark' <uppercase> 'goto-global-mark' <lowercase>.  (faster/more ergonomic)"
    (let* ((marker (evil-get-marker (upcase char)))
           (already-in-buffer-p (numberp marker)))
      (unless already-in-buffer-p
        (switch-to-buffer (marker-buffer marker)))))
  (advice-add 'evil-goto-mark-line :override #'z-goto-global-mark))

(use-package evil-collection ;; this is a rather large package, but we don't want to make any compromises on evil-mode
  :after evil
  :ensure t
  :custom (evil-collection-setup-minibuffer t) ;; HACK :: must use custom
  :config
  (evil-collection-init)

  (with-eval-after-load 'dired-aux ;; HACK
    (evil-define-key 'normal dired-mode-map (kbd ".") #'dired-omit-mode))

  (with-eval-after-load 'dired
    (evil-define-key 'normal dired-mode-map
      "l" #'dired-find-alternate-file
      "h" #'dired-up-directory)))

(use-package vertico
  :init
  (vertico-mode 1)
  (vertico-flat-mode 1)

  (setq completion-styles '(substring basic)
        read-file-name-completion-ignore-case t
        read-buffer-completion-ignore-case t
        completion-ignore-case t))

;; WINDOWS? => USE WSL
(progn
  (when (and (string-equal system-type "windows-nt")
             (file-exists-p "C:/Windows/System32/bash.exe"))
    (setq shell-file-name "C:/Windows/System32/bash.exe")))
