;; ---
;; title:  stumpwm keybindings
;; author: emil lenz
;; email:  emillenz@protonmail.com
;; date:   2024-03-01
;; ---

(which-key-mode)
(defvar scripts-dir "~/.config/bin/")

(defun defkey (map keys)
  (loop for (key body) in keys
        do (let ((cmd (if (stringp body)
                          body
                          (concat "eval " (write-to-string body)))))
             (define-key map (kbd key) cmd))))

(defvar find-map
  (let ((m (make-sparse-keymap)))
    (defkey m
        '(("s-c" "find-file ~/Documents/uni/cs/s2/")
          ("s-l" "find-file ~/Documents/literature/source/")
          ("s-a" "find-file ~/")))
    m))

(defvar sysact-map
  (let ((m (make-sparse-keymap)))
    (defkey m
        '(("s-q" "quit")
          ("s-P" "exec systemctl poweroff")
          ("s-r" "loadrc")
          ("s-R" "exec systemctl reboot")
          ("s-s" "sleep")
          ("s-o" "screen-off")))
    m))

(defvar open-map
  (let ((m (make-sparse-keymap)))
    (defkey m
        '(("s-c" "cmd")
          ("s-e" "emacs")
          ("s-E" "emacs-everywhere")
          ("s-v" "vid")
          ("s-w" "web")
          ("s-m" "music")))
    m))

(define-interactive-keymap media-map nil
  ((kbd "s-t") "exec playerctl play-pause" t)
  ((kbd "s-k") "exec playerctl previous")
  ((kbd "s-j") "exec playerctl next")
  ((kbd "s-h") "exec playerctl position -5")
  ((kbd "s-l") "exec playerctl position +5")
  ((kbd "s-d") "volume --decrease")
  ((kbd "s-u") "volume --increase")
  ((kbd "s-m") "exec pamixer --toggle-mute" t))

(set-prefix-key (kbd "s-SPC"))

(defkey *top-map*
    `(("XF86MonBrightnessDown" "exec brightnessctl set 5%-")
      ("XF86MonBrightnessUp" "exec brightnessctl set 5%+")
      ("s-RET" "move-window right")
      ("S-s-RET" "move-window left")
      ("s-TAB" "fnext")
      ("s-ISO_Left_Tab" "fprev")
      ("s-q" "delete-window")
      ("s-g" "exec rofi -show window")
      ("s-x" "exec rofi -show drun")
      ("s-f" ,find-map)
      ("s-o" ,open-map)))

(loop for (key group) in `(("a" ,group-all)
                           ("e" ,group-edit)
                           ("c" ,group-cmd)
                           ("w" ,group-web)
                           ("v" ,group-vid)
                           ("m" ,group-music)
                           ("d" ,group-doc))
      do (define-key *top-map*  (kbd (concat "s-" key)) (concat "gmove " group))
         (define-key *top-map*  (kbd (concat "s-" (string-upcase key)))
           (concat "gmove-and-follow " group)))


(defkey *root-map*
    `(("s-s" "screenshot")
      ("s-S" "screenshot --select")
      ("s-m" "media-map")
      ("s-q" ,sysact-map)
      ("s-o" "exec autorandr --change")
      ("s-a" ,(concat scripts-dir "audio"))
      ("s-k" ,(concat scripts-dir "killprocess"))))
