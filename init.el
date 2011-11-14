(add-to-list 'load-path "~/.emacs.d/packages/")

;; load emacs24 package manager
(require 'package)
(package-initialize)

(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; markdown
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.markdown" . markdown-mode) auto-mode-alist))
(add-hook 'markdown-mode-hook 'turn-on-visual-line-mode) ;; sane text handling for markdown

;; python-mode
(require 'python-mode)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; Cython
(require 'cython-mode)
(add-to-list 'auto-mode-alist '("\\.pyx\\'" . cython-mode))
(add-to-list 'auto-mode-alist '("\\.pxd\\'" . cython-mode))
(add-to-list 'auto-mode-alist '("\\.pxi\\'" . cython-mode))


;; Treat Objective C++ like Objective-C
(setq auto-mode-alist (cons '("\\.mm" . objc-mode) auto-mode-alist))

;; Turn off C-H as help so that Panic Prompt works properly
(global-set-key [(control h)] 'delete-backward-char)


;; mouse stuff
(unless window-system
  (require 'mouse)
  (xterm-mouse-mode 1)
  (global-set-key [mouse-4] '(lambda ()
                               (interactive)
                               (scroll-down 1)))
  (global-set-key [mouse-5] '(lambda ()
                               (interactive)
                               (scroll-up 1)))
  (xterm-mouse-mode t)
  (defun track-mouse (e)) 
  (setq mouse-sel-mode t))

;; Hookup emacs clipboard with mac system clipboard
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil)) 
      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))
(if (eq system-type 'darwin)
  (setq interprogram-cut-function 'paste-to-osx))
(if (eq system-type 'darwin)
  (setq interprogram-paste-function 'copy-from-osx))

;; turn off menu bars at terminal and tool bars in gui
(if window-system
  (tool-bar-mode -1))
(unless window-system
  (menu-bar-mode -1))

;; No splash screens
(setq inhibit-splash-screen t)

;; No word wrap
(setq-default truncate-lines t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes (quote (tango))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#eeeeec" :foreground "#2e3436" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 180 :width normal :foundry "apple" :family "Anonymous_Pro")))))
