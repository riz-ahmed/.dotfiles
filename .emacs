(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
;; Comment/uncomment this line to enable MELsPA Stable if desired.
;; See `package-archive-priorities` and `package-pinned-packages`.
;; Most users will not need nor want to do this.
;; (add-to-list 'package-archives
;;              '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-referesh-contents))

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

;; auto-suggestions / completions in the mini-buffer
(require 'ido)
(ido-mode t)
(ido-everywhere 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
(global-set-key (kbd "<escape>") 'kbd-escape-quit)

;; remove all gui
(tool-bar-mode -1)	;removing clickable toolstrips
(scroll-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)
(menu-bar-mode -1)
(show-paren-mode 1)
(setq visible-bell t)

(set-face-attribute 'default nil :font "Iosevka" :height 170)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" default))
 '(package-selected-packages
   '(move-text all-the-icons-dired org-roam org-bullets use-package rust-mode company evil anki-editor mu4e smex gruber-darker-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(load-theme 'gruber-darker)

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
(set-language-environment 'utf-8)
(set-terminal-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; remember and restore last cursor location in the file edited recently
(save-place-mode 1)

;; disable UI pop-up dialoge box to keep emacs fully keyboard driven
(setq use-dialog-box nil)

;; automatically referesh files when underlying buffers have changed
(global-auto-revert-mode 1)

;; automatically referesh non-file buffers (such as dired on changes)
(setq global-auto-revert-non-file-buffers t)

;; org-mode
(defun org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1))

(setq org-modules
      '(org-crypt
        org-habit
        org-bookmark
        org-eshell))

(use-package org
  :hook (org-mode . org-mode-setup)
  :config (setq org-ellipsis " ▾"))

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
  (org-roam-directory "~/Notes/org-roam")
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

;; file icons in dire
(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

;; dired list directories first
(setq dired-listing-switches "-aho --group-directories-first"
      dired-omit-files "\\.[^.].*"
      dired-omit-verbose nil
      dired-hide-details-hide-symlinks-targets nil
      delete-by-moving-to-trash t)

(autoload 'dired-omit-mode "dired-x")

;; move-text
(require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

;; move between windows uisng Shift + Arrow keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; delete-hightlighted text
(delete-selection-mode 1)

;; use spaces instead of tabs for consistency across all IDEs
(setq-default indent-tabs-mode nil)

;; copy from above (lines)
(autoload 'copy-from-above-command "misc"
  "Copy characters from previous nonblank line, starting just above point.

  \(fn &optional arg)"
  'interactive)
(global-set-key [up] 'copy-from-above-command)
(global-set-key [down] (lambda ()
                           (interactive)
                           (forward-line 1)
                           (open-line 1)
                           (copy-from-above-command)))
(global-set-key [right] (lambda ()
                            (interactive)
                            (copy-from-above-command 1)))
(global-set-key [left] (lambda ()
                           (interactive)
                            (copy-from-above-command -1)
                            (forward-char -1)
                            (delete-char -1)))
