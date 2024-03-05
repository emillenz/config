;; ---
;; title:  stumpwm autostart
;; author: emil lenz
;; email:  emillenz@protonmail.com
;; date:   2024-03-04
;; info:
;; - autostart processes and commands needed in each sesssion
;; ---

(defvar autostart-processes
  '("playerctld"
    "nm-applet"
    "unclutter"
    "sudo xremap --watch=device ~/.config/xremap/config.yml && sleep 1 && xset r off"
    "alacritty --class cmd --title cmd --command tmux new-session -A -s cmd"
    "emacs --daemon && emacsclient --reuse-frame"
    "syncthing --no-browser"
    "firefox --new-tab https://chat.openai.com"
    "keepassxc"
    "xsetroot -solid '#000000'"
    "xset dpms 0 0 0 && xset s off" ; never screensave / turn screen off (do manually if needed)
    "batsignal -bpe -w 50 -c 20 -d 5"
    "autorandr --change"))

(defcommand autostart () ()
  (loop for proc in autostart-processes do
    (let* ((proc-name (car (split-string proc " ")))))
    (run-shell-command (format nil
                               "pgrep ~A || ~A"
                               proc-name
                               proc))))

(when *initializing*
  (autostart))
