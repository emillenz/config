;; ---
;; title: bare metal, minmalist emacs config
;; date: 2024-05-27
;; author: emil lenz
;; email: emillenz@protonmail.com
;; info:
;; - no 3rd party dependencies
;;   => easy deployment on servers / other people's machines.
;; - default emacs bindings for speed when editing text.
;;   (it was observed that for simple propt editing a modal keybinding-scheme such as vim actually slows the typist down.)
;;   additionally emacs bindings bring the benefit of being able to extend them in any prompt/gui terminal application.
;; ---

;; (defun z-bootstrap-packages ()
;;   (require 'package)
;;   (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;;   (package-initialize)
;;   (unless (package-installed-p 'use-package)
;;     (package-refresh-contents)
;;     (package-install 'use-package)))
;; (z-bootstrap-packages)

(defun z-ui ()
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (blink-cursor-mode 0)
  (scroll-bar-mode 0)
  (hl-line-mode 1)
  (horizontal-scroll-bar-mode 0)
  (add-hook 'emacs-startup-hook 'toggle-frame-maximized)
  (setq inhibit-startup-screen t
        initial-scratch-message "")
  (load-theme 'modus-operandi))
(z-ui)

(defun z-relativenumbers ()
  (global-display-line-numbers-mode 1)
  (setq display-line-numbers-type 'relative))
(z-relativenumbers)

(defun z-editing-opts ()
  (electric-pair-mode 1)
  (delete-selection-mode 1)
  (add-hook 'before-save-hook #'delete-trailing-whitespace))
(z-editing-opts)

(defun z-indentation ()
  (electric-indent-mode 1)
  (setq tab-always-indent t
        standard-indent 8)
  (setq-default indent-tabs-mode nil)
  (add-hook 'prog-mode-hook
            (lambda ()
              (setq c-basic-offset 8))))
(z-indentation)

(defun z-better-defaults ()
  (global-auto-revert-mode 1)
  (column-number-mode 1)
  (savehist-mode 1)
  (global-word-wrap-whitespace-mode 1)
  (setq ring-bell-function 'ignore
        use-short-answers t
        save-interprogram-paste-before-kill t
        require-final-newline t
        load-prefer-newer t
        frame-inhibit-implied-resize t
        ediff-window-setup-function 'ediff-setup-windows-plain
        backup-by-copying t
        backup-directory-alist `(("." . ,(concat user-emacs-directory
                                                 "backups")))
        custom-file (expand-file-name "custom.el" user-emacs-directory)))
(z-better-defaults)

(defun z-scroll-down-half-page ()
  (interactive)
  (let ((ln (line-number-at-pos (point)))
        (lmax (line-number-at-pos (point-max))))
    (cond ((= ln 1) (move-to-window-line nil))
          ((= ln lmax) (recenter (window-end)))
          (t (progn
               (move-to-window-line -1)
               (recenter))))))

(defun z-scroll-up-half-page ()
  (interactive)
  (let ((ln (line-number-at-pos (point)))
        (lmax (line-number-at-pos (point-max))))
    (cond ((= ln 1) nil)
          ((= ln lmax) (move-to-window-line nil))
          (t (progn
               (move-to-window-line 0)
               (recenter))))))
(defun z-smart-open-line-above ()
  (interactive)
  (move-beginning-of-line nil)
  (insert "\n")
  (if electric-indent-inhibit
      (let* ((indent-end (progn (back-to-indentation)) (point)))
        (indent-start (progn (move-beginning-of-line nil) (point)))
        (indent-chars (buffer-substring indent-start indent-end)))
    (forward-line -1)
    (insert indent-chars))
  (forward-line -1)
  (indent-according-to-mode))

(defun z-move-beginning-of-line (arg)
  (interactive "^p")
  (setq arg (or arg 1))
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))
  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(defmacro cmd! (&rest body)
  `(lambda (count)
     (interactive "p")
     ,@body))

(defun z-better-default-bindings ()
  (global-set-key [remap query-replace] #'query-replace-regexp)
  (global-set-key [remap isearch-forward] #'isearch-forward-regexp)
  (global-set-key [remap isearch-backward] #'isearch-backward-regexp)
  (global-set-key (kbd "TAB") #'hippie-expand)
  (global-set-key (kbd "C-.") #'repeat)
  (global-set-key (kbd "C-q") #'kill-buffer-and-window)
  (global-set-key (kbd "M-q") #'delete-other-windows)
  (global-set-key (kbd "C-<tab>") (cmd! (switch-to-buffer nil)))
  (global-set-key (kbd "C-t") #'next-window-any-frame)
  (global-set-key (kbd "RET") #'newline-and-indent)
  (global-set-key (kbd "M-u") #'upcase-dwim)
  (global-set-key (kbd "M-l") #'downcase-dwim)
  (global-set-key (kbd "M-]") #'forward-paragraph)
  (global-set-key (kbd "M-[") #'backward-paragraph)
  (global-set-key (kbd "C-v") #'z-scroll-down-half-page)
  (global-set-key (kbd "M-v") #'z-scroll-up-half-page)
  (global-set-key (kbd "C-j") (cmd! (delete-indentation 1))) ;; improved `join-line'
  (global-set-key (kbd "M-<backspace>") (cmd! (kill-line 0) (indent-according-to-mode)))
  (global-set-key [remap open-line] (cmd! (move-end-of-line nil) (newline-and-indent)))
  (global-set-key (kbd "C-S-o") #'z-smart-open-line-above)
  (global-set-key [remap move-beginning-of-line] #'z-move-beginning-of-line)
  (global-set-key [remap kill-whole-line] (cmd! (kill-whole-line count) (back-to-indentation)))
  (global-set-key (kbd "C-x C-y") #'duplicate-line))
(z-better-default-bindings)
