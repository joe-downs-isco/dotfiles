(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fill-column 80)
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (company yaml yaml-mode json-mode banner-comment auctex web-mode linum-off fill-column-indicator latex-extra gh-md markdown-mode wucuo)))
 '(scroll-down-aggressively 0.25)
 '(scroll-margin 5)
 '(send-mail-function (quote smtpmail-send-it))
 '(tool-bar-mode nil))

;; Enable installation of packages from MELPA (Milkypostman's Emacs Lisp Package Archive)
;; Code below taken from https://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;;; Check if ~/.emacs.d/elpa exists, if not refresh the package list
(setq home-elpa-d (expand-file-name "~/.emacs.d/elpa/"))
(if (file-directory-p home-elpa-d)
    (message "%s exists; no need to refresh packages" home-elpa-d)
  (package-refresh-contents))

;;; Installs the packages in the list package-selected-packages (set above at
;;; beginning of file in (custom-set-variables)). To interactively add more
;;; packages to this list use M-x package-list-packages
(mapc 'package-install package-selected-packages)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 98 :width normal))))
 '(custom-group-tag ((t (:inherit variable-pitch :foreground "color-184" :weight bold :height 1.2))))
 '(custom-variable-tag ((t (:foreground "color-130" :weight bold))))
 '(font-latex-sectioning-5-face ((t (:foreground "color-51" :weight bold))))
 '(font-lock-builtin-face ((t (:foreground "color-96"))))
 '(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face))))
 '(font-lock-comment-face ((t (:foreground "color-70"))))
 '(font-lock-doc-face ((t (:foreground "color-94"))))
 '(font-lock-function-name-face ((t (:foreground "yellow"))))
 '(font-lock-keyword-face ((t (:foreground "color-134"))))
 '(font-lock-string-face ((t (:foreground "color-168"))))
 '(font-lock-type-face ((t (:foreground "cyan"))))
 '(minibuffer-prompt ((t (:foreground "brightcyan"))))
 '(org-formula ((t (:foreground "color-77"))))
 '(org-table ((t (:foreground "brightblue"))))
 '(outline-1 ((t (:foreground "color-219"))))
 '(outline-2 ((t (:foreground "color-210"))))
 '(outline-3 ((t (:foreground "color-180"))))
 '(outline-4 ((t (:foreground "color-108"))))
 '(outline-5 ((t (:foreground "color-117"))))
 '(outline-6 ((t (:foreground "color-69"))))
 '(outline-7 ((t (:foreground "color-99"))))
 '(outline-8 ((t (:foreground "color-134"))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "white")))))

; Add $HOME/dotfiles/emacs to the load path
(setq home-emacs-d (expand-file-name "~/git/dotfiles/emacs/"))
(if (file-exists-p home-emacs-d) (setq load-path (append (list home-emacs-d) load-path)) nil)

;; Puts a red line at column 81 (interior whitespace of 80) for more consistent formatting
(add-hook 'after-change-major-mode-hook 'fci-mode)
(setq fci-rule-column 80)
(setq fci-rule-color "red")

;; This will be available natively with display-fill-column-indicator as a part of Emacs 27
;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Displaying-Boundaries.html
;; (add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
;; Code from https://emacs.stackexchange.com/a/50583

; Create any and all backups / autosave files in their own, separate directories
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

;
; Load the linum mode
; http://stud4.tuwien.ac.at/~e0225855/linum/linum.html
;

(setq line-number-mode t)
(require 'linum)
(setq linum-format "%d ")
(global-linum-mode 1)
; Don't put line numbers in all modes; e.g., we don't need it in
; *scratch*.  And line numbers really confuse gdb mode.
(require 'linum-off)

; Load web-mode
; https://web-mode.org/
; All code copied from the website's "Install" section
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
