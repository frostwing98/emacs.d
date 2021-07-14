(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)
;;(add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
;;(require 'powerline)
(add-to-list 'load-path "/home/allen/.emacs.d/elpa/emacs-application-framework")
(require 'eaf)
(eaf-setq eaf-pdf-dark-mode "false")

(display-time-mode 1)
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)

(require 'vlf-setup)
(setq bidi-inhibit-bpa t)

(require 'all-the-icons)
(require 'ivy-rich)
(all-the-icons-ivy-rich-mode 1)
(ivy-rich-mode 1)

(require 'doom-modeline)
(doom-modeline-mode 1)
(add-hook 'after-init-hook #'doom-modeline-mode)
(require 'all-the-icons)
(setq doom-modeline-icon (display-graphic-p))


(require 'doom-themes)
 ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-zenburn t)

(require 'doc-view)
(setq doc-view-resolution 300)
;; Or use this
;; Use `window-setup-hook' if the right segment is displayed incorrectly
;;(add-hook 'after-init-hook #'doom-modeline-mode)

;; =========
;; display battery
;; ========
;(add-hook 'after-init-hook #'fancy-battery-mode)


(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

;; ========
;; toggle wrapping
;; ========
(global-visual-line-mode t)
(add-hook 'visual-line-mode-hook 'adaptive-wrap-prefix-mode)



;; ============
;; projectile-mode
;; ============
;(projectile-mode +1)
;(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
;(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

;; =============
;; irony-mode
;; =============
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
;; =============
;; company mode
;; =============
(add-hook 'c++-mode-hook 'company-mode)
(add-hook 'c-mode-hook 'company-mode)
;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))
(setq company-idle-delay 0)
;; (optional) adds CC special commands to `company-begin-commands' in order to
;; trigger completion at interesting places, such as after scope operator
;;     std::|
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
;; =============
;; flycheck-mode
;; =============
(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)
(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))
;; =============
;; eldoc-mode
;; =============
(add-hook 'irony-mode-hook 'irony-eldoc)
;; ==========================================
;; (optional) bind TAB for indent-or-complete
;; ==========================================
(defun irony--check-expansion ()
  (save-excursion
    (if (looking-at "\\_>") t
      (backward-char 1)
      (if (looking-at "\\.") t
        (backward-char 1)
        (if (looking-at "->") t nil)))))
(defun irony--indent-or-complete ()
  "Indent or Complete"
  (interactive)
  (cond ((and (not (use-region-p))
              (irony--check-expansion))
         (message "complete")
         (company-complete-common))
        (t
         (message "indent")
         (call-interactively 'c-indent-line-or-region))))
(defun irony-mode-keys ()
  "Modify keymaps used by `irony-mode'."
  (local-set-key (kbd "TAB") 'irony--indent-or-complete)
  (local-set-key [tab] 'irony--indent-or-complete))
(add-hook 'c-mode-common-hook 'irony-mode-keys)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(quelpa use-package doom solaire-mode all-the-icons-dired all-the-icons-ivy-rich treemacs amx all-the-icons-ivy counsel swiper dashboard ivy centaur-tabs doom-themes doom-modeline dash-functional all-the-icons magit spaceline fancy-battery vlf company-jedi projectile irony-eldoc flycheck-irony company-irony))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; python company
(setq python-shell-interpreter "/usr/bin/python3")

(global-company-mode t)

(setq company-idle-delay 0)

(setq company-minimum-prefix-length 3)

(company-quickhelp-mode 1)

(setq company-quickhelp-delay 0)

(defun my/python-mode-hook ())

(add-to-list 'company-backends 'company-jedi)

(add-hook 'python-mode-hook 'my/python-mode-hook)

(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)

(setq-default dired-listing-switches "-alh")
(setq-default word-wrap t)
(electric-pair-mode t)
;; centaur
(require 'centaur-tabs)
(centaur-tabs-mode t)
(global-set-key (kbd "C-<left>")  'centaur-tabs-backward)
(global-set-key (kbd "C-<right>") 'centaur-tabs-forward)
(centaur-tabs-headline-match)
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-gray-out-icons 'buffer)

(setq centaur-tabs-style "bar")
(setq centaur-tabs-set-bar 'left)




(require 'dashboard)
(dashboard-setup-startup-hook)

(amx-mode t)


(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)


;(require 'pretty-mode)
; if you want to set it globally
;(global-pretty-mode t)

