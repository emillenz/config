;; ---
;; title:  stumpwm groups
;; author: emil lenz
;; email:  emillenz@protonmail.com
;; date:   2024-03-03
;; info:
;;   - automatically places freqently used apps in groups for hotkey access
;; ---

(defvar group-all "all")
(defvar group-edit "edit")
(defvar group-cmd "cmd")
(defvar group-web "web")
(defvar group-doc "doc")
(defvar group-music "music")
(defvar group-vid "music")

;; NOTE :: Must come before specific asssignments
(define-frame-preference group-all
    (0 t t ))

(define-frame-preference group-edit
    (0 t t :class "Emacs")
  (0 t t :class "Eclipse"))

(define-frame-preference group-cmd
    (0 t t :class "cmd")
  (0 t t :class "alacritty"))

(define-frame-preference group-web
    (0 t t :class "firefox"))

(define-frame-preference group-doc
    (0 t t :class "Zathura"))

(define-frame-preference group-music
    (0 t t :class "Spotify"))

(define-frame-preference group-vid
    (0 t t :class "mpv"))

(when *initializing*
  (gnewbg group-all)
  (gnewbg group-edit)
  (gnewbg group-web)
  (gnewbg group-cmd)
  (gnewbg group-doc)
  (gnewbg group-music)
  (gnewbg group-vid))
