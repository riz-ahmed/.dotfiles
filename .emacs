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

(require 'ido)
(ido-mode t)
(ido-everywhere 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(global-set-key (kbd "<escape>") 'kbd-escape-quit)

(tool-bar-mode -1)	;removing clickable toolstrips

(scroll-bar-mode -1)

(tooltip-mode -1)

(set-fringe-mode 10)

(menu-bar-mode -1)

(setq visible-bell t)

(set-face-attribute 'default nil :font "Iosevka" :height 200)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" default))
 '(package-selected-packages '(company evil anki-editor mu4e smex gruber-darker-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(load-theme 'gruber-darker)

(column-number-mode)
(global-display-line-numbers-mode t)
;; disable line number in some modes
(dolist (mode '(org-mode-hook
		shell-mode-hook
		term-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))
(menu-bar--display-line-numbers-mode-relative)

;; display the colored shell output properly without dispalying any wired symbols
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; enable autopair minor mode by default
(electric-pair-mode 1)

;; mail client
(unless (package-installed-p 'notmuch)
  (package-refresh-contents)
  (package-install 'notmuch))
(require 'notmuch)
;;(setq notmuch-search-oldest-first nil)  ;; Optional: Show newest emails first
(setq notmuch-show-logo nil)           ;; Optional: Disable logo in email view
;; Define account-specific variables
(setq my-email-account1-address "riz.ahmed@eclipso.de")
(setq my-email-account1-database "~/Mail/riz.ahmed@eclipso.de") ;; Replace with the path to your account1's notmuch database
;; Configure notmuch accounts
(setq notmuch-accounts
      `((:name "Eclipso"
               :address ,my-email-account1-address
               :database ,my-email-account1-database)))

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
;;Exit insert mode by pressing j and then k quickly
(require 'key-chord)
(key-chord-mode 1)
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)
(key-chord-mode 1)
