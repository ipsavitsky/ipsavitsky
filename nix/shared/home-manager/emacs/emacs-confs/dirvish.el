;; Enable Dirvish globally
(dirvish-override-dired-mode)

;; Configure Dirvish
(setq dirvish-mode-line-format '(:left (sort file-time " " file-size symlink) :right (omit yank index))
      dirvish-attributes '(all-the-icons file-size file-time collapse subtree-state vc-state))

;; (setq dirvish-default-layout '(1 0.16 0.84))

;; Hide details by default
(add-hook 'dirvish-setup-hook 'dired-hide-details-mode)

(when (display-graphic-p)
  (require 'all-the-icons))
