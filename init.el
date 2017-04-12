;; Add chinise elpa mirror and initialize package
(when (>= emacs-major-version 24)
     (require 'package)
     (package-initialize)
     (setq package-archives '(("gnu" . "http://elpa.emacs-china.org/gnu/")
			      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))
;; cl - Common Lisp Extension
(require 'cl)

 ;; Add Packages
(defvar my/packages '(
		;; 拼音输入法和词库
		chinese-pyim
		chinese-pyim-greatdict
                ;; Auto-completion
                company
                ;; Better Editor
                hungry-delete
		smex
                swiper
                counsel
                exec-path-from-shell
                ;; Themes
                monokai-theme
                solarized-theme
                ) "Default packages")

 (setq package-selected-packages my/packages)

 (defun my/packages-installed-p ()
     (loop for pkg in my/packages
           when (not (package-installed-p pkg)) do (return nil)
           finally (return t)))

 (unless (my/packages-installed-p)
     (message "%s" "Refreshing package database...")
     (package-refresh-contents)
     (dolist (pkg my/packages)
       (when (not (package-installed-p pkg))
         (package-install pkg))))

;; Find Executable Path on OS, ???
(when (memq window-system '(ns))
  (exec-path-from-shell-initialize))        


;; Replace selection with newly inputed word
(delete-selection-mode 1)
;; Set curs style
(setq-default cursor-type 'bar)
;; Close ugly toolbar UI
(tool-bar-mode -1)
;; Hight light current line
(global-hl-line-mode 1)
;; Open line number mode
(global-linum-mode 1)
;; Close auto-backup, 'xxx.txt~ file'
(setq make-backup-files nil)
;; Change font size
(set-face-attribute 'default nil :height 140)
;; Open recentf mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-item 10)

;; Quick open init.el
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f12>") 'open-init-file)

;; Open company mode
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; Auto move curs to new window
(require 'popwin)
(popwin-mode 1)
;; use theme
(load-theme 'solarized-dark 1)

;; Open semx mode
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; 拼音输入法设置
(require 'chinese-pyim)
  ;; 拼音词库设置，五笔用户 *不需要* 此行设置
(require 'chinese-pyim-basedict)
  ;; 拼音词库，五笔用户 *不需要* 此行设置
(chinese-pyim-basedict-enable)   
  ;; 我使用全拼
(setq pyim-default-scheme 'quanpin)
  ;; 选词框显示5个候选词
(setq pyim-page-length 10)
  ;; 全半角切换
  ;; 执行(pyim-punctuation-toggle)
  ;; 使用外置词库
(require 'chinese-pyim-greatdict)
(chinese-pyim-greatdict-enable)
  ;; 设置默认输入法为chinese-pyim
(setq default-input-method "chinese-pyim")
  ;; 设置快捷键, 系统默认的快捷键已是该配置
;;(global-set-key (kbd "C-\\") 'toggle-input-method)
