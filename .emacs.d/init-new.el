(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(require 'use-package)
(setq use-package-always-ensure t)

(setq user-full-name "rizwan ahmed afzal")
(setq user-mail-address "rizwan@synopsys.com")

(fset 'yes-or-no-p 'y-or-n-p)           ;; ask y or n instead of yes or no
(defalias 'list-buffers 'ibuffer)       ;; improved version of listing iBuffers
(setq echo-keystrokes 0.1)              ;; show keystrokes in minibuffer instantly
(global-subword-mode 1)                 ;; camelCase string wills be treated as separate words
(setq gc-cons-threshold (* 50 1000 1000)) ;; increasing garbage collection thresold for faster startup times
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace))) ;; remove whitespaces while saving

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

(global-set-key (kbd "C-<down>") (kbd "C-u 1 C-v")) ;; scroll up
(global-set-key (kbd "C-<up>") (kbd "C-u 1 M-v"))   ;; scroll down

;; line numbers
(column-number-mode)
(global-display-line-numbers-mode t)
(setq display-line-numbers-type 'relative)

(add-to-list 'initial-frame-alist '(fullscreen . maximized)) ;; start emacs in fullscreen
(electric-pair-mode 1)                                         ;; enable autopairs by default

(setq use-dialog-box nil)               ;; diasable UI pop-up to keep fully keyboard driven
;; will display the funtion def in the menu bar
(add-hook 'my-mode-hook 'imenu-add-menubar-index)
(global-set-key (kbd "C-S-f") 'imenu)

;; auto-delete hightlighted text
(delete-selection-mode 1)

(setq-default indent-tabs-mode nil)     ;; use spaces instead of tabs

;; minibuffer completions
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mod

(add-hook 'shell-mode-hook 'ansi-color=for-comint-mode-on) ;; diaplay colored shell properly
(setq dired-enable-globstar-in-shell t)                    ;; enable globbing in shell-mode
(setq dired-recursive-deletes 'always)                     ;; don't ask confimation questions

;; disable emacs to automatically save files
(setq make-backup-files nil)
(setq backup-inhibited t)
(setq auto-save-default nil)

;; Save backup files in a dedicated directory
(setq backup-directory-alist '(("." . "~/.saves")))

(global-auto-revert-mode 1)             ;; auto-revert changed files
(setq global-auto-revert-non-file-buffers t) ;; auto-revert for non-file buffers

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

(autoload 'dired-omit-mode "dired-x")   ;; dired-x has some additonal features

(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(set-face-attribute 'default nil :font "Iosevka" :height 140)

;; c-style comments
(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

(global-set-key (kbd "C-x C-z") nil)    ;; disable (supend-frame) command. Very annoying at times
(global-set-key (kbd "C-z") nil)        ;; (suspend-frame) also bound to this combination

(load-theme 'doom-palenight t)

(setq scroll-preserve-screen-position t) ;; preserve scrolling position

;; Smooth Vertical Scroll
(setq scroll-step 1)
(setq scroll-margin 1)
(setq scroll-conservatively 101)
(setq scroll-up-aggressively 0.01)
(setq scroll-down-aggressively 0.01)
(setq auto-window-vscroll nil)
(setq fast-but-imprecise-scrolling nil)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)

(save-place-mode 1)                     ;; restore last cursor location

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
  :config (setq org-ellipsis " ▾")
  (setq org-directory "~/Notes/org-mode")
  (setq org-agenda-start-with-log-mode t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

;; org-babel activate languages
(org-babel-do-load-languages            ;; supported languages ("https://orgmode.org/worg/org-contrib/babel/languages/index.html#configure")
  'org-babel-load-languages
  '((emacs-lisp . t)
    (python . t)))

(setq org-confirm-babel-evaluate nil)   ;; avoid emacs asking for yes or no questions

(require 'org-tempo)                    ;; (usage (<el for inserting emacs-lisp template))
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))

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

;; Automatically tangle our Emacs.org config file when we save it
(defun org-babel-tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "~/.emacs.d/init.org"))
    ;; Dynamic scoping to the rescue
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'org-babel-tangle-config)))

(use-package async
  :ensure t
  :init (dired-async-mode 1))

(use-package which-key
  :ensure t
  :config
    (which-key-mode))

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;; tree-sitter configuration
(require 'tree-sitter)
(require 'tree-sitter-langs)
(global-tree-sitter-mode)

;; automatic encryption and decryption for gpg encrypted files
(require 'epa-file)
(epa-file-enable)

;; allowing for password prompt in minibuffer
(setq epa-pinentry-mode 'loopback)

(when (and (eq system-type 'gnu/linux)
           (getenv "WSLENV"))

  ;; Teach Emacs how to open links in your default Windows browser (firefox)
  (let ((cmd-exe "/mnt/c/Windows/System32/cmd.exe")
        (cmd-args '("/c" "start")))
    (when (file-exists-p cmd-exe)
      (setq browse-url-generic-program  cmd-exe
            browse-url-generic-args     cmd-args
            browse-url-browser-function 'browse-url-generic
            search-web-default-browser 'browse-url-generic)))
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
          (shell-command (concat "echo '" text "' | clip.exe"))))))

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

(defun my-god-mode-update-cursor-type () ;; visual indication when entering god-mode
  (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))

(add-hook 'post-command-hook #'my-god-mode-update-cursor-type)
