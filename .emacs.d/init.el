; Set up package.el to work with MELPA
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

;; set username
(setq user-full-name "rizwan ahmed afzal")
(setq user-mail-address "rizwan@synopsys.com")

;; ask y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; make iBuffer the defalt
(defalias 'list-buffers 'ibuffer)       ;; improved version of list-buffers function which adds colors to the display

;; using async wherever possible
(use-package async
  :ensure t
  :init (dired-async-mode 1))

;; preserve the point position while scrolling
(setq scroll-preserve-screen-position t)

;; Vertical Scroll
(setq scroll-step 1)
(setq scroll-margin 1)
(setq scroll-conservatively 101)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq auto-window-vscroll nil)
(setq fast-but-imprecise-scrolling nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)

;; Show Keystrokes in Progress Instantly
(setq echo-keystrokes 0.1)

;; self documenting suggestions
(use-package which-key
  :ensure t
  :config
    (which-key-mode))

;; camleCase strings will be treated as separate words
(global-subword-mode 1)

;; speed up emacs startup
(setq gc-cons-threshold (* 50 1000 1000)) ;; this variable controls the garbare collection threshold ;; The default is 800 kilobytes.  Measured in bytes.

;; Unbind unneeded keys
(global-set-key (kbd "C-x C-z") nil)    ;; also disable (supend-frame) command. Very annoying at times
(global-set-key (kbd "C-z") nil)        ;; (suspend-frame) also bound to this combination

;; Remove useless whitespace before saving a file
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))


;; inhibit the startup screen
(setq inhibit-startup-screen t)

;; remove all gui
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode -1)
(show-paren-mode 1)
(setq visible-bell t)

;; c-style comments
(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

;; set font size
(set-face-attribute 'default nil :font "Iosevka" :height 140)

;; useful global keymaps
(global-set-key (kbd "C-<down>") (kbd "C-u 1 C-v")) ;; scroll up
(global-set-key (kbd "C-<up>") (kbd "C-u 1 M-v"))   ;; scroll down

;; set a theme
(load-theme 'modus-vivendi)

;; line numbers
(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

;; completions
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; display colored shell properly without any wiered symbols
(add-hook 'shell-mode-hook 'ansi-color=for-comint-mode-on)

;; start the initial frame maximized (start emacs window maximised)
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; enabble globbing in shell-mode
(setq dired-enable-globstar-in-shell t)

;; don't ask questions while deleting
(setq dired-recursive-deletes 'always)

;; enable autopairs by default
(electric-pair-mode 1)

;; disable emacs to automatically save files
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)

;; Save backup files in a dedicated directory
(setq backup-directory-alist '(("." . "~/.saves")))

;; Set locale to UTF8
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; remeber and restrore the last cursor location in the file edited recently
(save-place-mode 1)

;; disable UI pop-up dialoge box to keep emacs fully keyboard driven
(setq use-dialog-box nil)

;; automatically referesh files when the underlying buffers have changed (useful when buffers are changed by other editors )
(global-auto-revert-mode 1)

;; do the same on non-file buffers (such as dired)
(setq global-auto-revert-non-file-buffers t)

;; org-mode
(defun org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

(setq org-modules
      '(org-crypt
        org-habit
        org-bookmark
        org-eshell
        ))

(use-package org
  :hook (org-mode . org-mode-setup)
  :config (setq org-ellipsis " ▾"))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; setting up org-roam
(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/Notes/org-roam-notes")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i"    . completion-at-point))
  :config
  (org-roam-setup))

(setq find-file-visit-truename t)                   ;; force emacs to always resolve symlinks (performace cost)

;; over-ride the behaviour of org-roam note search to be case-insensitive
(defun case-insensitive-org-roam-node-read (orig-fn &rest args)
  (let ((completion-ignore-case t))
    (apply orig-fn args)))

(advice-add 'org-roam-node-read :around #'case-insensitive-org-roam-node-read)

;; enable database autosync
(org-roam-db-autosync-mode 1)

;; multiple-cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;; auto-completion
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; display icons in dired-mode
(let ((installed (package-installed-p 'all-the-icons)))
  (use-package all-the-icons)
  (unless installed (all-the-icons-install-fonts)))

(use-package all-the-icons-dired
  :after all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))

;; dired - list directories first
(setq dired-listing-switches "-agho --group-directories-first"
      dired-omit-files "^\\.[^.].*"
      dired-omit-verbose nil
      dired-hide-details-hide-symlink-targets nil
      delete-by-moving-to-trash t)

(autoload 'dired-omit-mode "dired-x")

;; move-text
(require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;; will display the funtion def in the menu bar
(add-hook 'my-mode-hook 'imenu-add-menubar-index)
(global-set-key (kbd "C-S-f") 'imenu)

;; auto-delete hightlighted text
(delete-selection-mode 1)

;; use spaces instead of tabs / ensures uniformity among various platforms
(setq-default indent-tabs-mode nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f366d4bc6d14dcac2963d45df51956b2409a15b770ec2f6d730e73ce0ca5c8a7" "ba4ab079778624e2eadbdc5d9345e6ada531dc3febeb24d257e6d31d5ed02577" default))
 '(package-selected-packages
   '(which-key async multiple-cursors god-mode zenburn-theme org-roam-ui gruber-darker-theme tree-sitter-langs tree-sitter all-the-icons-dired markdown-mode hydra move-text company)))

;; tree-sitter configuration
(require 'tree-sitter)
(require 'tree-sitter-langs)
(global-tree-sitter-mode)

;; automatic encryption and decryption for gpg encrypted files
(require 'epa-file)
(epa-file-enable)

;; allowing for password prompt in minibuffer
(setq epa-pinentry-mode 'loopback)

;; run-cmd from within EMACS
(defun run-cmdexe ()
      (interactive)
      (let ((shell-file-name "cmd.exe"))
        (shell "*cmd.exe*")))

;; use windows clipboard
(defun copy-selected-text (start end)
  (interactive "r")
    (if (use-region-p)
        (let ((text (buffer-substring-no-properties start end)))
          (shell-command (concat "echo '" text "' | clip.exe")))))

;; WSL-specific setup
(when (and (eq system-type 'gnu/linux)
           (getenv "WSLENV"))

  ;; Teach Emacs how to open links in your default Windows browser (firefox)
  (let ((cmd-exe "/mnt/c/Windows/System32/cmd.exe")
        (cmd-args '("/c" "start")))
    (when (file-exists-p cmd-exe)
      (setq browse-url-generic-program  cmd-exe
            browse-url-generic-args     cmd-args
            browse-url-browser-function 'browse-url-generic
            search-web-default-browser 'browse-url-generic))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(god-mode-lighter ((t (:inherit error)))))

;; reducing RSI
(repeat-mode 1)                         ;; to disable use C-g whenever active (use M-x: describe-repeat-maps to get a complete list of commands that are activated in repeat-mode)

;; Start God-Mode from M-x when needed
(setq god-mode-enable-function-key-translation nil)
(require 'god-mode)

(global-set-key (kbd "C-.") #'god-mode-all) ;; enable / disable god-mode in a buffer

(defun my-god-mode-toggle-on-overwrite () ;; behaviour when in overwrite mode
  "Toggle god-mode on overwrite-mode."
  (if (bound-and-true-p overwrite-mode)
      (god-local-mode-pause)
    (god-local-mode-resume)))

(add-hook 'overwrite-mode-hook #'my-god-mode-toggle-on-overwrite)

(require 'god-mode-isearch)             ;; god-mode intergration with i-search
(define-key isearch-mode-map (kbd "C-.") #'god-mode-isearch-activate)
(define-key god-mode-isearch-map (kbd "C-.") #'god-mode-isearch-disable)
(defun my-god-mode-self-insert ()
  (interactive)
  (if (and (bolp)
           (eq major-mode 'org-mode))
      (call-interactively 'org-self-insert-command)
    (call-interactively 'god-mode-self-insert)))

(define-key god-local-mode-map [remap self-insert-command] #'my-god-mode-self-insert)

(define-key god-local-mode-map (kbd ".") #'repeat) ;; vim like dot repeating command
(define-key god-local-mode-map (kbd "i") #'god-local-mode) ;; insert into god-mode in the local buffer

(global-set-key (kbd "C-x C-1") #'delete-other-windows) ;; navigations are easier with the current and following keybindings
(global-set-key (kbd "C-x C-2") #'split-window-below)
(global-set-key (kbd "C-x C-3") #'split-window-right)
(global-set-key (kbd "C-x C-0") #'delete-window)

(define-key god-local-mode-map (kbd "[") #'backward-paragraph) ;; for easier paragraph navigation
(define-key god-local-mode-map (kbd "]") #'forward-paragraph)

(add-to-list 'god-exempt-major-modes 'dired-mode) ;; exempt god-mode in dired-mode
(add-to-list 'god-exempt-major-modes 'compilation-mode) ;; exempt god-mode in compilation mode

;; (defun my-god-mode-update-cursor-type () ;; visual indication when entering god-mode
;;   (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))

;; (add-hook 'post-command-hook #'my-god-mode-update-cursor-type)

(custom-set-faces
 '(god-mode-lighter ((t (:inherit error))))) ;; another visual indication on status line if god-mode is active
