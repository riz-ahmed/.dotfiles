(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
;; Comment/uncomment this line to enable MELsPA Stable if desired.
;; See `package-archive-priorities` and `package-pinned-packages`.
;; Most users will not need nor want to do this.
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-referesh-contents))

;; reduce startup time
;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;; initialise use-package
(require 'use-package)
(setq use-package-always-ensure t)

;; set username and email-id
(setq user-full-name "rizwan ahmed afzal")
(setq user-mail-address "riz.ahmed@gmx.de")

;; reduce typing by prompts
(fset 'yes-or-no-p 'y-or-n-p)

;; remove useless whitespaces while saving a file
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; for better startup performace
(setq gc-cons-threshold (* 50 1000 1000))

;; god-mode (no more RSI)
(setq god-mode-enable-function-key-translation nil)
(require 'god-mode)
(god-mode)
(global-set-key (kbd "<escape>") #'god-mode-all)
(setq god-exempt-major-modes nil)
(setq god-exempt-predicates nil)
(defun my-god-mode-update-mode-line ()  ;; viusal indication if when god-mode is active
  (cond
   (god-local-mode
    (set-face-attribute 'mode-line nil
                        :foreground "#604000"
                        :background "#fff29a")
    (set-face-attribute 'mode-line-inactive nil
                        :foreground "#3f3000"
                        :background "#fff3da"))
   (t
    (set-face-attribute 'mode-line nil
            :foreground "#0a0a0a"
            :background "#d7d7d7")
    (set-face-attribute 'mode-line-inactive nil
            :foreground "#404148"
            :background "#efefef"))))

(add-hook 'post-command-hook #'my-god-mode-update-mode-line)
(defun my-god-mode-toggle-on-overwrite () ;; pause god-mode when in overwrite mode
  "Toggle god-mode on overwrite-mode."
  (if (bound-and-true-p overwrite-mode)
      (god-local-mode-pause)
    (god-local-mode-resume)))

(add-hook 'overwrite-mode-hook #'my-god-mode-toggle-on-overwrite)

(require 'god-mode-isearch)             ;; god-mode in i-search as well
(define-key isearch-mode-map (kbd "<escape>") #'god-mode-isearch-activate)
(define-key god-mode-isearch-map (kbd "<escape>") #'god-mode-isearch-disable)

(define-key god-local-mode-map (kbd ".") #'repeat) ;; vim like dot command for repeating previous action
(define-key god-local-mode-map (kbd "i") #'god-local-mode) ;; insert into god-mode in a lcoal buffer

(add-to-list 'god-exempt-major-modes 'dired-mode) ;; exempt god-mode in dired buffer

;; auto-suggestions / completions in the mini-buffer
(require 'ido)
(ido-mode t)
(ido-everywhere 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
;; (global-set-key (kbd "<escape>") 'kbd-escape-quit)

;; remove all gui
(tool-bar-mode -1)	;removing clickable toolstrips
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(show-paren-mode 1)
(setq visible-bell t)

(set-face-attribute 'default nil :font "Iosevka" :height 150)

;; modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874" "e3daa8f18440301f3e54f2093fe15f4fe951986a8628e98dcd781efbec7a46f2" "991ca4dbb23cab4f45c1463c187ac80de9e6a718edc8640003892a2523cb6259" "251ed7ecd97af314cd77b07359a09da12dcd97be35e3ab761d4a92d8d8cf9a71" "636b135e4b7c86ac41375da39ade929e2bd6439de8901f53f88fde7dd5ac3561" "2e05569868dc11a52b08926b4c1a27da77580daa9321773d92822f7a639956ce" "adaf421037f4ae6725aa9f5654a2ed49e2cd2765f71e19a7d26a454491b486eb" "443e2c3c4dd44510f0ea8247b438e834188dc1c6fb80785d83ad3628eadf9294" "7a424478cb77a96af2c0f50cfb4e2a88647b3ccca225f8c650ed45b7f50d9525" "f366d4bc6d14dcac2963d45df51956b2409a15b770ec2f6d730e73ce0ca5c8a7" "e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" default))
 '(package-selected-packages
   '(god-mode vterm yasnippet dired-ranger dired-range dired-single general which-key python-mode multiple-cursors magit doom-modeline doom-themes zenburn-theme lsp-mode tree-sitter-langs tree-sitter org-roam-ui move-text all-the-icons-dired org-roam org-bullets use-package rust-mode company mu4e smex gruber-darker-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; active theme
(load-theme 'doom-palenight t)

;; line numbers
(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

;; display the colored shell output properly without dispalying any wired symbols
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; enable autopair minor mode by default
(electric-pair-mode 1)

;; enable globbing in shell-mode
(setq dired-enable-globstar-in-shett t)

;; disable emacs to automatically save files
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)

;; save backup fiels in a dedicated dir
(setq backup-directory-alist '(("." . "~/.saves")))

;; set locale to UTF8
(set-default-coding-systems 'utf-8)

;; remember and restore last cursor location in the file edited recently
(save-place-mode 1)

;; disable UI pop-up dialoge box to keep emacs fully keyboard driven
(setq use-dialog-box nil)

;; automatically referesh files when underlying buffers have changed
(global-auto-revert-mode 1)

;; automatically referesh non-file buffers (such as dired on changes)
(setq global-auto-revert-non-file-buffers t)

;;; multiple cursors
(require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;; setting up which key
(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; org-mode
(defun org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

(setq org-modules
      '(org-crypt
        org-habit
        org-bookmark))

(use-package org
  :hook (org-mode . org-mode-setup)
  :config
  (setq org-ellipsis " ▾")
  (setq org-hide-emphasis-markers t))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; Replace list hyphen with dot
(font-lock-add-keywords 'org-mode
                        '(("^ *\\([-]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; org-roam
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Notes/org-roam-notes")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-/" . completion-at-point))
  :config
  (org-roam-setup))

(setq find-file-visit-truename t)	;; force emacs to always resolve symlinks

;; over-ride current behavior of org-roam notes search to be case-insensitive
(defun case-insensitive-org-roam-node-read (orig-fn &rest args)
  (let ((completion-ignore-case t))
    (apply orig-fn args)))

(advice-add 'org-roam-node-read :around #'case-insensitive-org-roam-node-read)

;; enable db-autosync
(org-roam-db-autosync-mode 1)

;; auto-completion
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; dired settings
(use-package all-the-icons-dired)

(use-package dired
  :ensure nil
  :defer 1
  :commands (dired dired-jump)
  :config
  (setq dired-listing-switches "-agho --group-directories-first"
        dired-omit-files "^\\.[^.].*"
        dired-omit-verbose nil
        dired-hide-details-hide-symlink-targets nil
        delete-by-moving-to-trash t)

  (autoload 'dired-omit-mode "dired-x"))

;; move-text
(require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;; move between windows uisng Shift + Arrow keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; use spaces instead of tabs for consistency across all IDEs
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; tree-sitter setup
(require 'tree-sitter)
(require 'tree-sitter-langs)

;; lsp config
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((c-mode . lsp-deferred)
         (bash-ts-mode . lsp-deferred))
  :commands (lsp lsp-deferred))

;; addtional lsp configs (if lsp performace degrades)
;; (setq read-process-output-max (* 1024 1024))
;; (setq gc-cons-threshold 100000000)

;; enable auto scrolling in the compile and re-compile buffers
(use-package compile
  :custom
  (compilation-scroll-output t))

(defun auto-recompile-buffer ()
  (interactive)
  (if (member #'recompile after-save-hook)
      (remove-hook 'after-save-hook #'recompile t)
    (add-hook 'after-save-hook #'recompile nil t)))

;; sinpppets
(use-package yasnippet
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all))

;; vterm (not emacs implement terminal, but slightly better)
(use-package vterm
  :commands vterm
  :config
  (setq vterm-max-scrollback 10000))
