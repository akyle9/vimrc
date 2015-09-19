(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-shift-width 2))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "gray30"))))
 '(font-lock-constant-face ((t (:foreground "green"))))
 '(font-lock-function-name-face ((t (:foreground "turquoise2"))))
 '(font-lock-string-face ((t (:foreground "Firebrick"))))
 '(lazy-highlight ((t (:background "yellow")))))

(require 'package)  ;; should be first in .emacs file
  (push '("marmalade" . "http://marmalade-repo.org/packages/")
        package-archives )
  (push '("melpa" . "http://melpa.milkbox.net/packages/")
        package-archives)
(package-initialize)

(add-hook 'prog-mode-hook 'highlight-numbers-mode)

;; Line numbers
(global-linum-mode t)
(unless window-system
    (add-hook 'linum-before-numbering-hook
        (lambda ()
            (setq-local linum-format
                (let ((w (length (number-to-string
                                 (count-lines (point-min) (point-max))))))
                (concat " %" (number-to-string w) "d " ))))))

;; Horizontal cursor line and customize its appearance (to be like vim's cursor line)
(global-hl-line-mode 1)
(set-face-background 'highlight (face-attribute 'default :background))
(set-face-foreground 'highlight nil)
(set-face-underline-p 'highlight t)

;; set ~/.emacs_saves to be dir for all autosave, recovery, and backup files
(setq backup-directory-alist `((".*" . "~/.emacs_saves/")))
(setq auto-save-file-name-transforms `((".*" ,"~/.emacs_saves/" t)))
(setq backup-by-copying t)
(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(show-paren-mode) ;; Highlights the matching paren.
(add-hook 'before-save-hook 'delete-trailing-whitespace) ;; No trailing spaces
(setq require-final-newline t) ;; Good practice.
(setq-default indent-tabs-mode nil) ;; Don't indent with tabs.

(xclip-mode 1) ;; copy and paste to system clipboard
(menu-bar-mode -1)

;; Evil Setup
(require 'evil-leader)
(global-evil-leader-mode)

(evil-leader/set-leader ",")

(require 'evil)
  (evil-mode 1)

(require 'powerline-evil)  ;; vim like status bar
(powerline-evil-vim-color-theme)
(display-time-mode t)

(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map  "jj" 'evil-normal-state)

;; Fixes 'Invalid function: evil-without-input-method-hooks' error when using evil search
(evil-select-search-module 'evil-search-module 'evil-search)


;(setq TeX-PDF-mode t)
;(require 'tex)
;(TeX-global-PDF-mode t)
;(setq latex-run-command "pdflatex")
;;Latex stuff .........................
;; AucTeX
;(setq TeX-auto-save t)
;(setq TeX-parse-self t)
;(setq-default TeX-master nil)
;(add-hook 'LaTeX-mode-hook 'visual-line-mode)
;(add-hook 'LaTeX-mode-hook 'flyspell-mode)
;(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)
;; Use Skim as viewer, enable source <-> PDF sync
;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
;(add-hook 'LaTeX-mode-hook (lambda ()
;  (push
;    '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
;      :help "Run latexmk on file")
;    TeX-command-list)))
;(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))
;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background
;(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
;(setq TeX-view-program-list
     ;'(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
;; end latex stuff .......


;; auto-compliete config
(ac-config-default)
(global-auto-complete-mode t)
(add-to-list 'ac-modes 'latex-mode)
(add-to-list 'ac-modes 'sml-mode)
(add-to-list 'ac-modes 'c0-mode)
(add-to-list 'ac-modes 'makefile-mode)
(add-to-list 'ac-modes 'makefile-bsdmake-mode)

(setq ac-auto-show-menu    0)
(setq ac-delay             0)
(setq ac-show-menu-immediately-on-auto-complete t)

(global-set-key (kbd "C-?") 'help-command)
(global-set-key (kbd "M-?") 'mark-paragraph)
(global-set-key (kbd "C-h") 'delete-backward-char)
(global-set-key (kbd "M-h") 'backward-kill-word)

;; keep some of the emacs navigation commands
(define-key evil-normal-state-map "\C-f" 'evil-forward-char)
(define-key evil-insert-state-map "\C-f" 'evil-forward-char)
(define-key evil-insert-state-map "\C-f" 'evil-forward-char)
(define-key evil-normal-state-map "\C-b" 'evil-backward-char)
(define-key evil-insert-state-map "\C-b" 'evil-backward-char)
(define-key evil-visual-state-map "\C-b" 'evil-backward-char)
(define-key evil-normal-state-map "\C-d" 'evil-delete-char)
(define-key evil-insert-state-map "\C-d" 'evil-delete-char)
(define-key evil-visual-state-map "\C-d" 'evil-delete-char)
(define-key evil-normal-state-map "\C-n" 'evil-next-line)
(define-key evil-insert-state-map "\C-n" 'evil-next-line)
(define-key evil-visual-state-map "\C-n" 'evil-next-line)
(define-key evil-normal-state-map "\C-p" 'evil-previous-line)
(define-key evil-insert-state-map "\C-p" 'evil-previous-line)
(define-key evil-visual-state-map "\C-p" 'evil-previous-line)
(define-key evil-normal-state-map (kbd ";") 'evil-ex)

(defun exec-python()
  (interactive)
  ;;(python-shell-switch-to-shell)
  (python-shell-get-or-create-process "/usr/bin/python -i" nil t)
  ;;(other-window 1)
  (python-shell-send-buffer) )

(defun exec-sml()
  (interactive)
  (when (get-process "sml")
      (delete-process "sml"))
  (when (get-buffer "*sml*")
    (switch-to-buffer "*sml*")
    (erase-buffer)
    (switch-to-buffer (other-buffer)) )
  (sml-prog-proc-load-file (buffer-name))
  ;(call-interactively (global-key-binding "RET"))
  ;(choose-completion)
  ;(exit-minibuffer)
  (other-window 1) )
  ;(when (> (count-windows) 1)
  ;  (other-window 1) ) )

(defun exec-latex()
  (interactive)
  (save-buffer)
  (tex-file)
  (message nil)
  (other-window 1)
  (delete-window) )

(defun save-and-recompile()
  (interactive)
  (save-buffer)
  (recompile) )

(defun halve-other-window-height ()
  "Expand current window to use half of the other window's lines."
  (interactive)
  (enlarge-window (/ (window-height (next-window)) 2)))

(evil-leader/set-key-for-mode 'python-mode "e" 'exec-python)
(evil-leader/set-key-for-mode 'latex-mode "e" 'TeX-command-master)
(evil-leader/set-key-for-mode 'c0-mode "e" 'save-and-recompile)
(evil-leader/set-key-for-mode 'c-mode "e" 'save-and-recompile)
(evil-leader/set-key-for-mode 'c++-mode "e" 'save-and-recompile)
(evil-leader/set-key-for-mode 'sml-mode "e" 'exec-sml)

(evil-leader/set-key "r" 'halve-other-window-height)
(evil-leader/set-key "SPC" 'evil-ex-nohighlight)

;; Setup for c0-mode
;;(setq c0-root "/afs/andrew/course/15/122/")
;;(load (concat c0-root "c0-mode/c0.el"))
(setq c0-root "/usr/local/cc0/")
(load (concat c0-root "c0-mode/c0.el"))
(require 'cl) ;; require comomn lisp
