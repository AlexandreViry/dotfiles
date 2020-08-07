(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (tsdh-dark)))
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-empty ((t (:foreground "firebrick" :background "SlateGray1"))))
 '(whitespace-hspace ((t (:foreground "white" :background "red"))))
 '(whitespace-indentation ((t (:foreground "firebrick" :background "beige"))))
 '(whitespace-line ((t (:foreground "black" :background "red"))))
 '(whitespace-newline ((t (:foreground "orange" :background "blue"))))
 '(whitespace-space ((t (:bold t :foreground "gray75"))))
 '(whitespace-space-after-tab ((t (:foreground "black" :background "green"))))
 '(whitespace-space-before-tab ((t (:foreground "black" :background "DarkOrange"))))
 '(whitespace-tab ((t (:foreground "red"))))
 '(whitespace-trailing ((t (:foreground "red" :background "yellow")))))

;; Display line, column
(line-number-mode t)
(column-number-mode t)

;; Display menubar but not tool bar
(menu-bar-mode t)
(tool-bar-mode -1)

;; Indent with spaces
(setq-default indent-tabs-mode nil)

;; Highlight while search/replace
(setq search-highlight t query-replace-highlight t)

;; Highlight selection
(transient-mark-mode t)

;; Delete selected text
(delete-selection-mode t)

;; Replace all yes-no questions into y-n
(fset 'yes-or-no-p 'y-or-n-p)

;; Copy/paste insert at the cursor point
(setq mouse-yank-at-point -1)

;; No backup files
(setq make-backup-files nil)

;; Don't save abbrevs
(setq save-abbrevs nil)

;; End file with new line
(setq require-final-newline t)

;; Replace tab with spaces
(setq-default indent-tabs-mode nil)

;; Show parenthesis
(require 'paren)
(show-paren-mode t)
(setq blink-matching-paren t)
(setq blink-matching-paren-on-screen t)
(setq show-paren-style 'expression)
(setq blink-matching-paren-dont-ignore-comments t)

;; Global shortcuts
(global-set-key [f5] 'compile)
(global-set-key [f6] 'interrupt-and-recompile)
(global-set-key [f7] 'next-error)

;; Whitespace
(require 'whitespace)
(setq whitespace-style '(face trailing empty lines-tail tabs tab-mark))
(setq whitespace-space 'whitespace-hspace)
;;(setq whitespace-line-column 80)
(add-hook 'prog-mode-hook 'whitespace-mode)

;; Auto-kill compilation process and recompile
(defun interrupt-and-recompile ()
  "Interrupt old compilation, if any, and recompile."
  (interactive)
  (ignore-errors
    (process-kill-without-query
     (get-buffer-process
      (get-buffer "*compilation*"))))
  (ignore-errors
    (kill-buffer "*compilation*"))
  (recompile))

;; Always open a new compilation window to easily close it
(defun new-compilation-window-hook ()
  (progn
    (if (not (get-buffer-window "*compilation*"))
        (progn (split-window-vertically)))))

(add-hook 'compilation-mode-hook 'new-compilation-window-hook)

;; Close the compilation window if there was no error
(setq compilation-exit-message-function
      (lambda (status code msg)
        (when (and (eq status 'exit) (zerop code))
          (bury-buffer "*compilation*")
          (delete-window (get-buffer-window (get-buffer "*compilation*"))))
        ;; Always return the anticipated result of compilation-exit-message-function
        (cons msg code)))
;; Auto-scroll in the compilation buffer
(setq compilation-scroll-output 'first-error)
;; When compilation uses color, apply them if possible
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region (point-min) (point-max))
  (toggle-read-only))

(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

;; Bash
(setq-default sh-basic-offset 4)
(setq-default sh-indentation 4)

;; C
(setq-default c-default-style "linux")
(setq-default c-basic-offset 4)
