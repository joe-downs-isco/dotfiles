;;; Emacs Setup
;; Add $HOME/git/dotfiles/emacs to the load path
(setq home-emacs-d (expand-file-name "~/git/dotfiles/emacs/"))
(if (file-exists-p home-emacs-d)
    (setq load-path (append (list home-emacs-d) load-path)))

;; Set and load the custom file (custom.el) to save settings set by emacs for
;; faces, behavior, etc. custom-file must be set so Emacs knows where to save
;; the customizations and doesn't just dump them back here in .emacs.
(setq custom-file (concat home-emacs-d "custom.el"))
(load custom-file)

;; Set and load the keybindings file (keybinds.el) for all my custom-set
;; keyboard shortcuts
(setq keybinds-file (concat home-emacs-d "keybinds.el"))
(load keybinds-file)

;; Enable installation of packages from MELPA (Milkypostman's Emacs Lisp Package
;; Archive). Code below taken from https://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable/disable MELPA Stable if desired.  See
;; `package-archive-priorities` and `package-pinned-packages`. Most users will
;; not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;; Check if ~/.emacs.d/elpa exists, if not refresh the package list
(setq home-elpa-d (expand-file-name "~/.emacs.d/elpa/"))
(if (file-directory-p home-elpa-d)
    (message "%s exists; no need to refresh packages" home-elpa-d)
  (package-refresh-contents))

;; Installs the packages in the list package-selected-packages (set above at
;; beginning of file in (custom-set-variables)). To interactively add more
;; packages to this list use M-x package-list-packages
(mapc 'package-install package-selected-packages)

;; A fill column indicator is available natively as a part of Emacs 27. If
;; running version 26 or below, instead use fill-column-indicator. Regardless of
;; which is used, both will put a vertical red bar "|" at column 81 (interior
;; width of 80).
(if (version< emacs-version "27")
    (progn
      (message "Emacs version is below 27, using fill-column-indicator")
      (add-hook 'after-change-major-mode-hook 'fci-mode)
      (setq fci-rule-column fill-column)
      (setq fci-rule-color "red"))
  (add-hook 'after-change-major-mode-hook 'display-fill-column-indicator-mode))

;; Create any and all backups/autosave files in their own, separate directories
;; This snippet of code was taken from https://stackoverflow.com/a/18330742
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )

;; Show trailing whitespace only in programming and text modes (i.e., not in
;; minibuffers)
(defun visible-whitespace () (setq show-trailing-whitespace t))
(add-hook 'prog-mode-hook 'visible-whitespace)
(add-hook 'text-mode-hook 'visible-whitespace)
;;; Package Customization

;; Use company-mode (autocompletion) everywhere
(add-hook 'after-init-hook 'global-company-mode)
;; No delay in showing suggestions.
(setq company-idle-delay 0)
;; Show suggestions after entering one character.
(setq company-minimum-prefix-length 1)
;; Wrap around to the top after reaching the bottom of the suggestion list.
(setq company-selection-wrap-around t)
;; Use tab key to cycle through suggestions. ('tng' means 'tab and go')
(company-tng-configure-default)

;; Initialize backends for different company-related packages AFTER company has
;; loaded, so that this variable actually exists.
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-c-headers))

;; Turn off company-dabbrev downcasing (e.g., turning "fooBar" to "foobar")
(setq company-dabbrev-downcase nil)

;; Enable linum mode for smartly adding line numbers to buffers.
(setq line-number-mode t)
(setq linum-format "%d ")
(global-linum-mode 1)
;; Don't put line numbers in all modes; e.g., we don't need it in *scratch*, and
;; line numbers really confuse gdb mode.
(require 'linum-off)

;; Turn on rainbow-related modes for most programming modes
;;(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;; Load web-mode. Code below taken from https://web-mode.org/
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;; Use wucuo
(add-hook 'after-change-major-mode-hook 'wucuo-start)
;;(add-hook 'text-mode-hook 'wucuo-start)

;; Use anaconda and anaconda-eldoc-mode
(add-hook 'python-mode-hook 'anaconda-mode)
(add-hook 'python-mode-hook 'anaconda-eldoc-mode)

;;; Magit Customization
;; Auto-refresh Magit status buffer after saving a file
(with-eval-after-load 'magit-mode
  (add-hook 'after-save-hook 'magit-after-save-refresh-status t))

;;;; Elcord (Discord rich presence integration)
(require 'elcord)
(elcord-mode)

;;;; Diredfl
(require 'diredfl)
(add-hook 'dired-mode-hook 'diredfl-mode)

;;; Projectile
(require 'projectile)
(setq helm-projectile-fuzzy-match nil)
(require 'helm-projectile)
(helm-projectile-on)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(setq projectile-project-search-path '("~/git/" "~/git/.dev/" "~/git/.installs"))
(setq projectile-auto-discover t)

;;; Yasnippet
(require 'yasnippet)
;; Add our own custom snippets
(setq yas-snippet-dirs (append (list (concat home-emacs-d "snippets")) (yas-snippet-dirs)))
;; Enable yas-global-mode
(yas-global-mode 1)



;;;; External Configs
;; Load separate config file for helm stuffs
(setq helm-cfg-file (concat home-emacs-d "cfg-helm.el"))
(load helm-cfg-file)

;; Org Stuffs
(setq org-cfg-file (concat home-emacs-d "cfg-org.el"))
(load org-cfg-file)
;; Set a LaTeX packages to fix the horrible default margins
(setq org-latex-packages-alist '(("" "fullpage")))
;; Hide markup characters (e.g., *foo* would just be foo [but bold])
(setq org-hide-emphasis-markers t)

;;; LaTeX stuffs
;; Turn off fontifying (e.g., making sub- and super-scripts smaller)
(setq tex-fontify-script nil)
(setq font-latex-fontify-script nil)

