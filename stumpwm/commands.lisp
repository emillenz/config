;; ---
;; title:  stumpwm commands
;; author: emil lenz
;; email:  emillenz@protonmail.com
;; date:   2024-03-03
;; info:   commands to be bound to keys or called interactively
;; ---

(defvar rofi-menu "rofi -dmenu -i -no-custom -p '  find-file:'")
(defcommand find-file (dir) (:string)
  (run-shell-command (format nil
                             "xdg-open \"$(fd --extension pdf . ~A | ~A)\""
                             dir
                             rofi-menu)))

(defcommand screenshot (&optional select) (:string)
  "SELECT :: [--select]"
  (run-shell-command  (concat "scrot '%Y-%m-%d_T%H-%M-%S.png' --quality 100 --exec 'mv $f ~/Pictures/screenshots/' "
                              select))
  (dunstify "󰹑  scrot" "saved in: ~/Pictures/screenshots" :id "42"))

(defun get-volume ()
  (run-shell-command "pamixer --get-volume-human" t))

(defcommand volume (how) (:string)
  "HOW :: --increase | --decrease"
  (run-shell-command (format nil
                             "pamixer ~A 5"
                             how))
  (dunstify (format nil
                    "󰕾  vol: ~A"
                    how)
            (get-volume) :id "69"))

(defun dunstify (title msg &key id time)
  (run-shell-command (concat "dunstify "
                             (when id (concat "--replace " id " "))
                             (when time (concat "--timeout" time " "))
                             title
                             " "
                             msg)))

(defcommand suspend () ()
  (run-shell-command "playerctl pause; slock; systemctl suspend"))

(defcommand screen-off () ()
  (run-shell-command "playerctl pause; sleep 1; xset dpms force off"))

(defcommand emacs-everywhere () ()
  (run-shell-command "emacsclient --eval '(emacs-everywhere)"
                     (0 t t :class "emacs")))

(defcommand emacs () ()
  (run-or-raise "emacsclient --reuse-frame || emacs --daemon"
                (0 t t :class "emacs")))

(defcommand vid () ()
  (run-or-raise (format nil
                        "mpv ~A"
                        (get-x-selection))
                (0 t t :class "mpv")))

(defcommand web () ()
  (run-or-raise "firefox"
                (0 t t :class "firefox")))

(defcommand music () ()
  (run-or-raise "spotify-launcher"
                (0 t t :class "spotify")))

(defcommand cmd () ()
  (run-or-raise "alacritty --class cmd --title cmd --command tmux new-session -A -s cmd"
                (0 t t :class "cmd")))

(defcommand split () ()
  (hsplit)
  (balance-windows)
  (move-focus :right))

(defcommand audioselect () ()
  (let* ((sinks (split-string (run-shell-command "pamixer --list-sinks")
                              "n"))
         (sink (select-from-menu (current-screen) sinks "sink:")))))
