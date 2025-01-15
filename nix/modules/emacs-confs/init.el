;; do not show startup screen
(setq inhibit-startup-screen t)

;; goodbye scrollbar
(scroll-bar-mode 0)

;; prevent emacs from creating annoying auto save files
(setq auto-save-default nil)
(setq make-backup-files nil)

;; highlight matching brackets
(show-paren-mode 1)

;; overwrite selected text
(delete-selection-mode 1)

(load-theme 'dracula t)

(set-face-attribute 'default (selected-frame) :height 140)

;; display line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; set y-or-n prompt
(defalias 'yes-or-no-p 'y-or-n-p)

;; confirm on exit
(setq confirm-kill-emacs 'y-or-n-p)

;; disable ringing
(setq ring-bell-function 'ignore)

;; disabling the menu bars
(menu-bar-mode 0)
(tool-bar-mode 0)

;; setting up which-key
(which-key-mode 1)

;; enable parenthesis autocompletion
(electric-pair-mode)

(load-file "~/.config/emacs/corfu.el")

(load-file "~/.config/emacs/direnv.el")

(load-file "~/.config/emacs/eglot.el")

(load-file "~/.config/emacs/orderless.el")

(load-file "~/.config/emacs/undo-tree.el")

(load-file "~/.config/emacs/vertico.el")
