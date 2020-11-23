;; tmp dotf .emacs.d
(require 'org)
(require 'ob-tangle)

(setq init-dir (file-name-directory (or load-file-name (buffer-file-name))))

(setq loader-org-file-name (expand-file-name "loader.org" init-dir))

(if (file-exists-p loader-org-file-name)
    (org-babel-load-file loader-org-file-name)
  (message "loader.org not found: " loader-org-file-name))

(defun rlp/edit-loader-org ()
  (interactive)
  (find-file loader-org-file-name))

(defun rlp/edit-elfeed-org ()
  (interactive)
  "edit elfeed feeds org file"
  (find-file (expand-file-name "elfeed.org" init-dir)))

(defun rlp/ffgr ()
  "find git-repos dir"
  (interactive)
  (find-file "~/git-repos"))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("14f13fee1792f44c448df33e3d3a03ce9adbf1b47da8be490f604ac7ae6659b9" "9a313a6a47c9655d9f2b87e846a31e9c21076f71d85bfb22065b21d5e8da684d" "0ecfd25c7f4b32b4703dfbbad3c0cb865aeb17efb0b694624a604ed89550ee8d" "9271c0ad73ef29af016032376d36e8aed4e89eff17908c0b578c33e54dfa1da1" "d543a5f82ce200d50bdce81b2ecc4db51422439ba7c0e6845483dd89566e4cf9" default))
 '(package-selected-packages
   '(docker ivy-rich company-quickhelp eshell-git-prompt vterm kotlin-mode lsp-mode anki-editor mu4e-alert helpful forth-mode dimmer org-download rustic htmlize org-caldav rg flycheck clojure-snippets lispy restclient focus keyfreq dashboard spaceline deft rainbow-delimiters smartparens git-auto-commit-mode magit bm which-key ace-link counsel ivy-hydra ivy evil solarized-theme use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'narrow-to-region 'disabled nil)
