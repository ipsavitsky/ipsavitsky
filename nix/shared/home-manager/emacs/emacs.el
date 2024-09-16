(setq inhibit-startup-screen t)

(load-theme 'dracula t)

(set-face-attribute 'default (selected-frame) :height 300)

; set y-or-n prompt
(defalias 'yes-or-no-p 'y-or-n-p)

; confirm on exit
(setq confirm-kill-emacs 'y-or-n-p)

; disabling the menu bars
(menu-bar-mode 0)
(tool-bar-mode 0)

; setting up which-key
(which-key-mode 1)

; setting up undo-tree
(global-undo-tree-mode 1)
(setq undo-tree-auto-save-history t
      undo-tree-visualizer-diff t
      undo-tree-enable-undo-in-region t
      undo-tree-history-directory-alist `(("~/.config/emacs/undo-tree-hist/"))
      undo-limit 800000           ; 800kb (default is 160kb)
      undo-strong-limit 12000000  ; 12mb  (default is 240kb)
      undo-outer-limit 128000000)

; override dirvish
(dirvish-override-dired-mode)
(dirvish-side-follow-mode)
(setq dirvish-subtree-always-show-state t)
