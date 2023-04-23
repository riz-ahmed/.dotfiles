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

(tool-bar-mode -1)	;removing clickable toolstrips

(scroll-bar-mode -1)

(tooltip-mode -1)

(set-fringe-mode 10)

(menu-bar-mode -1)

(setq visible-bell t)

(set-face-attribute 'default nil :font "Iosevka" :height 200)
(custom-set-variables
 ;; custom-sfet-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" default))
 '(package-selected-packages '(smex gruber-darker-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(load-theme 'gruber-darker)

(setq display-line-numbers 'relative)
(global-display-line-numbers-mode)
(menu-bar--display-line-numbers-mode-relative)
