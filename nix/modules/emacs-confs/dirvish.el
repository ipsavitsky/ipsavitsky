(use-package dirvish
  :init
  (dirvish-override-dired-mode)
  :bind (:map dirvish-mode-map
	      ([left] . dired-up-directory)
	      ([right] . dired-find-file)))
