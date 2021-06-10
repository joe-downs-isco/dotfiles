;; Add $HOME/git/dotfiles/emacs to the load path
(setq home-emacs-d (expand-file-name "~/git/dotfiles/emacs/"))
(if (file-exists-p home-emacs-d)
    (setq load-path (append (list home-emacs-d) load-path)))

;; Set and load the custom file (custom.el) to save settings set by emacs for
;; faces, behavior, etc. custom-file must be set so Emacs knows where to save
;; the customizations and doesn't just dump them back here in .emacs.
(setq custom-file "custom.el")
(load custom-file)

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
(setq backup-by-copying t)
(setq backup-directory-alist '((".*". "~/.emacs.d/backups/")))
(setq auto-save-file-name '((".*". "~/.emacs.d/autosaves/")))

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

;; Enable linum mode for smartly adding line numbers to buffers.
(setq line-number-mode t)
(setq linum-format "%d ")
(global-linum-mode 1)
;; Don't put line numbers in all modes; e.g., we don't need it in *scratch*, and
;; line numbers really confuse gdb mode.
(require 'linum-off)

;; Turn on rainbow-related modes for most programming modes
(add-hook 'prog-mode-hook 'rainbow-identifiers-mode)
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
