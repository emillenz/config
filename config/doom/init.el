;;; init.el -*- lexical-binding: t; -*-

;; NOTE :: for each enabled cadidate see the readme ~SPC h d m~ for available flags.
(doom! :input
       ;;bidi                       ; (tfel ot) thgir etirw uoy gnipleh
       ;;chinese
       ;;japanese
       ;;layout                     ; auie,ctsrnm is the superior home row

       :completion
       ;(company +childframe +box +tng) ; heavy
       ;;helm                       ; the *other* search engine for love and life
       ;;ido                        ; the other *other* search engine...
       ;;ivy                        ;  (+fuzzy +icons) vertico but worse
       vertico             ; (+icons) the best => fastest & most minimal
       (corfu +dabbrev +orderless) ;; lighweight + native

       :ui
       ;;deft                       ; notational velocity for Emacs
       ;; doom                         ; what makes DOOM look the way it does
       ;;doom-dashboard             ; a nifty splash screen for Emacs => bloat
       ;;doom-quit                  ; DOOM quit-message prompts when you quit Emacs
       ;;emoji                      ; (+unicode +github)
       hl-todo                      ; highlight keywords: TODO/FIXME/NOTE/DEPRECATED/HACK/REVIEW/BUG
       ;;hydra
       ;;indent-guides              ; highlighted indent columns
       (ligatures                   ; (+iosevka +extra) ligatures and symbols
        +iosevka)
       ;;minimap                    ; show a map of the code on the side
       (modeline +light)            ; (+light) light is much faster than doom's modeline
       ;;nav-flash                  ; blink cursor line after big motions
       ;;neotree                    ; a project drawer, like NERDTree for vim
       ophints                      ; highlight the region an operation acts on
       ;; popup                     ; (+all) NOTE :: NOT! enabled. (this just makes managing windows more complex, we want a focused single maximized window workflow.)
       ;;tabs                       ; a tab bar for Emacs
       ;;treemacs                   ; a project drawer, like neotree but cooler
       unicode                      ; extended unicode support for various languages
       (vc-gutter
        +pretty)                    ; (+pretty) vcs diff in the fringe
       ;; vi-tilde-fringe              ; fringe tildes to mark beyond EOB
       ;;window-select              ; visually switch windows
       ;; workspaces                 ; tab emulation, persistence & separate workspaces
       ;; zen                          ; distraction-free coding or writing

       :editor
       (evil +everywhere)           ; (+everywhere) come to the dark side, we have cookies
       file-templates               ; auto-snippets for empty files
       fold                         ; (nigh) universal code folding
       ;; (format +lsp)                ; (+onsave)
       ;;god                        ; run Emacs commands without modifier keys
       lispy                        ; vim for lisp, for people who don't like vim
       ;;multiple-cursors           ; editing in many places at once
       ;;objed                      ; text object editing for the innocent
       ;;parinfer                   ; turn lisp into python, sort of
       ;;rotate-text                ; cycle region at point between text candidates
       snippets                     ; my elves. They type so I don't have to
       word-wrap                    ; soft wrapping with language-aware indent

       :emacs
       dired                      ; (+icons) making dired pretty [functional]
       electric                     ; smarter, keyword-based electric-indent
       ;;ibuffer                    ; (+icons) interactive buffer management
       (undo +tree)                 ; (+tree) persistent, smarter undo for your inevitable mistakes
       vc                           ; version-control and Emacs, sitting in a tree

       :term
       eshell                     ; the elisp shell that works everywhere
       shell                      ; simple shell REPL for Emacs NOTE :: use this over vterm (better emacs integration).
       ;; term                       ; basic terminal emulator for Emacs
       ;; vterm                     ; the best terminal emulation in Emacs

       :checkers
       ;; syntax                     ; (+childframe) ;; flycheck is bloat, all you need is a compiler
       ;;(spell)                    ; (+everywhere +flyspell) // tasing you for misspelling mispelling
       ;; grammar                      ; tasing grammar mistake every you make

       :tools
       ;;ansible
       ;;biblio                     ; Writes a PhD for you (citation needed)
       (debugger +lsp)              ; (+lsp) FIXME stepping through code, to help you add bugs
       ;;direnv
       ;;docker                     ; (+lsp)
       ;;editorconfig               ; let someone else argue about tabs vs spaces
       ein                          ; tame Jupyter notebooks with emacs
       (eval
        +overlay)                   ; (+overlay) run code, run (also, repls)
       ;;gist                       ; interacting with github gists
       (lookup                      ; navigate your code and its documentation
        +dictionary                 ; (+dictionary +docsets +offline) incredibly handy when reading prose
        +docsets
        +offline)
       ;; (lsp
       ;;  +peek)                      ; (+peek) M-x vscode
       (magit                       ; (+forge) a git porcelain for Emacs
        +forge)
       make                       ; run make tasks from Emacs
       ;;pass                       ; (+auth) password manager for nerds
       ;; pdf                          ; pdf enhancements; emacs sucks donkey ass for anything graphical => use external pdf viewer
       ;;prodigy                    ; FIXME managing external services & code builders
       ;;rgb                        ; creating color strings
       ;;taskrunner                 ; taskrunner for all your projects
       ;;terraform                  ; infrastructure as code
       ;;tmux                       ; an API for interacting with tmux
       tree-sitter                  ; syntax and parsing, sitting in a tree...
       ;;upload                     ; map local to remote projects via ssh/ftp
       ;;collab

       :os
       ;;(:if IS-MAC macos)         ; improve compatibility with macOS
       (tty +osc)                   ; (+osc) improve the terminal Emacs experience

       :lang
       ;;agda                       ; types of types of types of types...
       ;;beancount                  ; mind the GAAP
       (cc +lsp)                    ; (+lsp) C >  C++ == 1
       (clojure +lsp +treesitter)                    ; java with a lisp
       ;;common-lisp                ; if you've seen one lisp, you've seen them all
       ;;coq                        ; proofs-as-programs
       ;;crystal                    ; ruby at the speed of c
       ;;csharp                     ; unity, .NET, and mono shenanigans
       ;;data                       ; config/data formats
       ;;(dart +flutter)            ; paint ui and not much else
       ;;dhall
       ;;elixir                     ; erlang done right
       ;;elm                        ; care for a cup of TEA?
       emacs-lisp                   ; drown in parentheses
       ;;erlang                     ; an elegant language for a more civilized age
       ;;ess                        ; emacs speaks statistics
       ;;factor
       ;;faust                      ; dsp, but you get to keep your soul
       ;;fortran                    ; in FORTRAN, GOD is REAL (unless declared INTEGER)
       ;;fsharp                     ; ML stands for Microsoft's Language
       ;;fstar                      ; (dependent) types and (monadic) effects and Z3
       ;;gdscript                   ; the language you waited for
       (go +lsp
	   +tree-sitter)                  ; the hipster dialect
       ;;(graphql +lsp)             ; Give queries a REST
       ;;(haskell +lsp)             ; a language that's lazier than I am
       ;;hy                         ; readability of scheme w/ speed of python
       ;;idris                      ; a language you can depend on
       (json +lsp
	     +tree-sitter)                         ; At least it ain't XML
       ;; (java +lsp)                  ; (+lsp) the poster child for carpal tunnel syndrome
       ;;javascript                 ; all(hope(abandon(ye(who(enter(here))))))
       ;;julia                      ; a better, faster MATLAB
       ;;kotlin                     ; a better, slicker Java(Script)
       (latex                       ; (+lsp +latexmk +cdlatex +fold) writing papers in Emacs has never been so fun
        +lsp
        +latexmk
        +fold)
       ;;lean                       ; for folks with too much to prove
       ;;ledger                     ; be audit you can be
       ;;lua                        ; ( +lsp +fennel +trees-itter) one-based indices? one-based indices
       markdown                     ; writing docs for people to ignore
       ;;nim                        ; python + lisp at the speed of c
       ;;nix                        ; I hereby declare "nix geht mehr!"
       ;;ocaml                      ; an objective camel
       (org                         ; organize your plain life in plain text
        ;; +dragndrop                  ; drag & drop files/images into org buffers
        ;; +jupyter                    ; ipython/jupyter support for babel
        +pandoc                     ; export-with-pandoc support
        +pretty
        +roam2                      ; wander around notes
        ;;+present                  ; using org-mode for presentations
        ;;+gnuplot                  ; who doesn't like pretty pictures
        ;;+pomodoro                 ; be fruitful with the tomato technique
        ;;+hugo                     ; use Emacs for hugo blogging
        ;;+noter                    ; enhanced PDF notetaking
        )
       ;;php                        ; perl's insecure younger brother
       ;;plantuml                   ; diagrams for confusing people more
       ;;purescript                 ; javascript, but functional
       (python                      ; beautiful is better than ugly
        +lsp)
       ;;qt                         ; the 'cutest' gui framework ever
       ;;racket                     ; a DSL for DSLs
       ;;raku                       ; the artist formerly known as perl6
       ;;rest                       ; Emacs as a REST client
       ;;rst                        ; ReST in peace
       ;; (ruby +lsp +tree-sitter)          ; +rails 1.step {|i| p "Ruby is #{i.even? ? 'love' : 'life'}"}
       ;;(rust +lsp)                ; Fe2O3.unwrap().unwrap().unwrap().unwrap()
       ;;scala                      ; java, but good
       ;;(scheme +guile)            ; a fully conniving family of lisps
       (sh +lsp
           +tree-sitter) ; she sells {ba,z,fi}sh shells on the C xor
       ;;sml
       ;;solidity                   ; do you need a blockchain? No.
       ;;(swift +lsp)               ; who asked for emoji variables?
       ;;terra                      ; Earth and Moon in alignment for performance.
       ;;web                        ; the tubes
       yaml                         ; JSON, but readable
       ;;zig                        ; C, but simpler

       :email
       ;;(mu4e +org +gmail)
       ;;notmuch
       ;;(wanderlust +gmail)

       :app
       calendar
       ;;emms
       everywhere                   ; *leave* Emacs!? You must be joking
       ;;irc                        ; how neckbeards socialize
       ;;(rss +org)                 ; emacs as an RSS reader

       :config
       literate
       (default
        +bindings
        +smartparens))
