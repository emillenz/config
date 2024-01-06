;; -*- no-byte-compile: t; -*-

(package! evil-escape :disable t) ;; NOTE ::: Bloat, remap an ergo key os-wide

(package! dired-open)
(package! rainbow-mode)
(package! wc-mode)
(package! clippy)
(package! org-appear)
(package! org-roam)
(package! doct)
(package! all-the-icons-ivy)
(package! org-super-agenda)
(package! org-superstar)
(package! org-tidy)
(package! evil-numbers)
(package! org-auto-tangle)
(package! evil-cleverparens)
(package! consult-dir)
(package! chatgpt-shell)
(package! org-pandoc-import
  :recipe (:host github
           :repo "tecosaur/org-pandoc-import"
           :files ("*.el" "filters" "preprocessors")))
(package! org-fragtog)
