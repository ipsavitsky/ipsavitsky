;; setting up undo-tree
(global-undo-tree-mode 1)
(setq undo-tree-auto-save-history t
      undo-tree-visualizer-diff t
      undo-tree-enable-undo-in-region t
      undo-tree-history-directory-alist '(("." . "~/.config/emacs/undo-tree-hist"))
      undo-limit 800000           ; 800kb (default is 160kb)
      undo-strong-limit 12000000  ; 12mb  (default is 240kb)
      undo-outer-limit 128000000)
