;; Set up package.el to work with MELPA
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; set username
(setq user-full-name "rizwan ahmed afzal")
(setq user-mail-address "rizwan@synopsys.com")

;; ask y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; speed up emacs startup
;; The default is 800 kilobytes.  Measured in bytes.
(setq gc-cons-threshold (* 50 1000 1000))

;; Remove useless whitespace before saving a file
(add-hook 'before-save-hook 'whitespace-cleanup)
(add-hook 'before-save-hook (lambda() (delete-trailing-whitespace)))

(require 'use-package)
(setq use-package-always-ensure t)

;; inhibit the startup screen
(setq inhibit-startup-screen t)
;;
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

(define-key key-translation-map (kbd "C-;") (kbd "C-x"))
(define-key key-translation-map (kbd "C-.") (kbd "C-c"))

;; set a theme
(load-theme 'zenburn t)

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

;; enable minibuffer completion
;; (setq fido-mode t)
;; (setq icomplete-vertical-mode t)

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

;; move around windows using SHIFT + ARROW keys
;; (when (fboundp 'windmove-default-keybindings)
;;   (windmove-default-keybindings))

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
   '(multiple-cursors god-mode zenburn-theme org-roam-ui gruber-darker-theme tree-sitter-langs tree-sitter all-the-icons-dired markdown-mode hydra move-text company)))


;; copy from the line above
(autoload 'copy-from-above-command "misc"
  "Copy characters from previous nonblank line, starting just above point.

  \(fn &optional arg)"
  'interactive)

(global-set-key [up] 'copy-from-above-command) ;; up arrow key will copy the rest of the line forward

(global-set-key [down] (lambda ()	;; now the down arrow key will copy from the line above
                         (interactive)
                         (forward-line 1)
                         (open-line 1)
                         (copy-from-above-command)))

(global-set-key [right] (lambda ()	;; right arrow key will copy one character from above
                          (interactive)
                          (copy-from-above-command 1)))

(global-set-key [left] (lambda ()	;; left arrow key will copy from above, backwards!!
                         (interactive)
                         (copy-from-above-command -1)
                         (forward-char -1)
                         (delete-char -1)))

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
