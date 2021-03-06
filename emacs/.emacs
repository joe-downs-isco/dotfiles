(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages (quote (gh-md markdown-mode wucuo)))
 '(scroll-down-aggressively 0.25)
 '(scroll-margin 5))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-group-tag ((t (:inherit variable-pitch :foreground "color-184" :weight bold :height 1.2))))
 '(custom-variable-tag ((t (:foreground "color-130" :weight bold))))
 '(font-lock-builtin-face ((t (:foreground "color-96"))))
 '(font-lock-comment-delimiter-face ((t (:inherit font-lock-comment-face))))
 '(font-lock-comment-face ((t (:foreground "color-70"))))
 '(font-lock-doc-face ((t (:foreground "color-94"))))
 '(font-lock-function-name-face ((t (:foreground "yellow"))))
 '(font-lock-keyword-face ((t (:foreground "color-134"))))
 '(font-lock-string-face ((t (:foreground "color-168"))))
 '(font-lock-type-face ((t (:foreground "cyan"))))
 '(minibuffer-prompt ((t (:foreground "brightcyan"))))
 '(web-mode-html-tag-bracket-face ((t (:foreground "white")))))

; Add $HOME/dotfiles/emacs to the load path
(setq home-emacs-d (expand-file-name "~/git/dotfiles/emacs/"))
(if (file-exists-p home-emacs-d) (setq load-path (append (list home-emacs-d) load-path)) nil)


; Create any and all backups / autosave files in their own, separate directories
(setq backup-by-copying t)
(setq backup-directory-alist '((".*". "~/.emacs.d/backups/")))
(setq auto-save-file-name '((".*". "~/.emacs.d/autosaves/")))

;; Enable installation of packages from MELPA (Milkypostman's Emacs Lisp Package Archive)
;; Code below taken from https://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

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
(add-hook 'prog-mode-hook 'wucuo-start)
(add-hook 'text-mode-hook 'wucuo-start)
