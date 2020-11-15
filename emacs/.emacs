(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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
 '(minibuffer-prompt ((t (:foreground "brightcyan")))))

; Add $HOME/dotfiles/emacs to the load path
(setq home-emacs-d (expand-file-name "~/git/dotfiles/emacs/"))
(if (file-exists-p home-emacs-d) (setq load-path (append (list home-emacs-d) load-path)) nil)


; Create any and all backups / autosave files in their own, separate directories
(setq backup-by-copying t)
(setq backup-directory-alist '((".*". "~/.emacs.d/backups/")))
(setq auto-save-file-name '((".*". "~/.emacs.d/autosaves/")))


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
