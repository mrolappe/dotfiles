
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq use-spacemacs (getenv "USE_SPACEMACS"))

(when use-spacemacs
  (setq user-emacs-directory "~/.spacemacs.d/"))

(setq init-file-name (expand-file-name "init.el" user-emacs-directory))

(if (file-exists-p init-file-name)
    (load init-file-name))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (use-package yasnippet which-key undo-tree mmm-mode hydra highlight-escape-sequences evil-unimpaired diff-hl company async aggressive-indent adaptive-wrap ace-window))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
