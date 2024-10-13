;; do not show startup screen
(setq inhibit-startup-screen t)

;; prevent emacs from creating annoying auto save files
(setq auto-save-default nil)
(setq make-backup-files nil)

;; highlight matching brackets
(show-paren-mode 1)

(load-theme 'dracula t)

(set-face-attribute 'default (selected-frame) :height 300)

;; display line numbers
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; set y-or-n prompt
(defalias 'yes-or-no-p 'y-or-n-p)

;; confirm on exit
(setq confirm-kill-emacs 'y-or-n-p)

;; disabling the menu bars
(menu-bar-mode 0)
(tool-bar-mode 0)

;; setting up which-key
(which-key-mode 1)

(load-file "~/.config/emacs/undo-tree.el")

(load-file "~/.config/emacs/dirvish.el")

(load-file "~/.config/emacs/helm.el")

(load-file "~/.config/emacs/direnv.el")

;; smartparens config					
(add-hook 'prog-mode-hook #'smartparens-mode)

(load-file "~/.config/emacs/eglot.el")
