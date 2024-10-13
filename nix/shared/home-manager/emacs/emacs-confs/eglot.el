(require 'eglot)

(add-hook 'go-mode-hook #'eglot-ensure)
(add-hook 'nix-mode-hook #'eglot-ensure)
(add-hook 'terraform-mode-hook #'eglot-ensure)
