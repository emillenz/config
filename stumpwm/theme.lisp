;; ---
;; title:  stumpwm modus vivendi colortheme
;; author: emil lenz
;; email:  emillenz@protonmail.com
;; date:   2024-03-01
;; info:
;;   Define variables for all colours used in the modus themes vivendi for Emacs.
;;   Furthermore, a set of variables is defined to be used to configure overall
;;   colour theme throughout the configuration.
;; ---

(defvar modus-theme-colors
  '((bg . "#000000")
    (bg-dim . "#1e1e1e")
    (accent . "#2f447f")
    (fg . "#ffffff")
    (fg-dim . "#989898")
    (border . "#646464")
    (red . "#ff5f59")
    (green . "#44bc44")
    (yellow . "#d0bc00")
    (blue . "#2fafff")
    (magenta . "#feacd0")
    (cyan . "#00d3d0")))

(defun color (color)
  (cdr (assoc color modus-theme-colors)))

(setq *colors*
      (mapcar #'color '(bg
                        red
                        green
                        yellow
                        blue
                        magenta
                        cyan
                        fg)))

(when *initializing*
  (update-color-map (current-screen)))

(set-focus-color         (color 'accent))
(set-unfocus-color       (color 'border))

(set-float-focus-color   (color 'accent))
(set-float-unfocus-color (color 'border))

(set-win-bg-color        (color 'bg))

(defvar border-width 1)
(setf *normal-border-width*    border-width
      *maxsize-border-width*   border-width
      *transient-border-width* border-width
      *window-border-style*    :thin)

;;; Message and input bar
(set-msg-border-width border-width)
(set-fg-color         (color 'fg))
(set-bg-color         (color 'bg))
(set-border-color     (color 'accent))

;;; Etc.
(setf *ignore-wm-inc-hints* t) ; Ensure Emacs uses full height of a frame
