;;; Octave
(font-lock-add-keywords 'octave-mode
			;; Highlight variables in assignment, skip ==
			`(("\\([[:graph:]]*\\)\\([[:blank:]]\\{1,\\}=\\{1\\}[[:blank:]]\\{1,\\}\\)\\([[:graph:]]\\)"
			   1 font-lock-variable-name-face)))
