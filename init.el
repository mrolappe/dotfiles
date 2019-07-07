(require 'org)
(require 'ob-tangle)

(setq init-dir (file-name-directory (or load-file-name (buffer-file-name))))

(setq loader-org-file-name (expand-file-name "loader.org" init-dir))

(if (file-exists-p loader-org-file-name)
    (org-babel-load-file loader-org-file-name)
  (message "loader.org not found: " loader-org-file-name))

(defun mro-edit-init-file ()
  (interactive)
  (find-file init-file-name))
