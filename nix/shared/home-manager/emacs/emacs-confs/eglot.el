(require 'eglot)
(require 'go-mode)
(require 'nix-mode)
(require 'terraform-mode)
(require 'haskell-mode)
(require 'python-mode)
(require 'markdown-mode)
(require 'yaml-mode)
(require 'elm-mode)

(add-hook 'go-mode-hook #'eglot-ensure)
(add-hook 'nix-mode-hook #'eglot-ensure)
(add-hook 'terraform-mode-hook #'eglot-ensure)
(add-hook 'c-mode-hook #'eglot-ensure)
(add-hook 'haskell-mode-hook #'eglot-ensure)
(add-hook 'python-mode-hook #'eglot-ensure)
(add-hook 'markdown-mode-hook #'eglot-ensure)
(add-hook 'yaml-mode-hook #'eglot-ensure)
(add-hook 'elm-mode-hook #'eglot-ensure)
