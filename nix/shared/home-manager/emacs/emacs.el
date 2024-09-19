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
      undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo-tree-hist"))
      undo-limit 800000           ; 800kb (default is 160kb)
      undo-strong-limit 12000000  ; 12mb  (default is 240kb)
      undo-outer-limit 128000000)

;; Enable Dirvish globally
(dirvish-override-dired-mode)

;; Configure Dirvish
(setq dirvish-mode-line-format
      '(:left (sort file-time " " file-size symlink) :right (omit yank index)))

(setq dirvish-attributes
      '(all-the-icons file-size file-time collapse subtree-state vc-state))

(setq dirvish-default-layout '(1 0.16 0.84))

;; Enable side-follow mode
(dirvish-side-follow-mode)

;; Enable mouse drag-and-drop
(setq dired-mouse-drag-files t)
(setq mouse-drag-and-drop-region-cross-program t)

;; Hide details by default
(add-hook 'dirvish-setup-hook 'dired-hide-details-mode)

;; Optional: Enable all-the-icons (if you want file icons)
(when (display-graphic-p)
  (require 'all-the-icons))
