;;;; org-mode Customization
(setq org-adapt-indentation t)

;;; org-roam Customization
;; Sample Config from the git repo
(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/git-personal/roam-notes/"))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more informative completion interface
  (setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))

;; Use a new default template for org-roam-captures. This just gives us the node
;; name as the filename, instead of a loooong timestamp. I think my note-taking
;; method (at least for now until I look into journaling and whatnot, I won't
;; have nodes with the same name; instead just expanding on the current one.
(setq org-roam-capture-templates
      '(("d" "default" plain "%?"
	 :target (file+head "${title}.org"
                            "#+title: ${title}\n")
	 :unnarrowed t)))
