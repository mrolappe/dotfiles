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
 '(package-selected-packages
   '(lua-mode org-bullets htmlize doom-themes doom-modeline forth-mode keepass-mode go-mode org-ql fuel geiser ox-hugo magrant keypression nov circe erc emms lispy paren-face smartparens engine-mode restclient all-the-icons-dired all-the-icons ace-window rustic mu4e-views pocket-reader counsel-ffdata haskell-mode docker ivy-rich yasnippet-snippets yasnippet eshell-git-prompt vterm lsp-ivy lsp-ui lsp-mode kotlin-mode company-quickhelp company elfeed-org elfeed flycheck anki-editor mu4e-alert alert helpful exec-path-from-shell diminish keyfreq spaceline deft rainbow-delimiters git-auto-commit-mode magit which-key evil counsel ivy solarized-theme use-package))
 '(show-paren-mode t)
 '(smtpmail-smtp-server "smtp.web.de")
 '(smtpmail-smtp-service 25)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
